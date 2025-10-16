-- CinéBox Database Schema for Supabase
-- This schema manages user authentication and media (movies/TV shows) data

-- Enable UUID extension
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

-- ============================================
-- USERS TABLE (handled by Supabase Auth)
-- ============================================
-- Users are managed by Supabase Auth automatically
-- We'll reference auth.users(id) in our tables

-- ============================================
-- MEDIA TABLE (Movies & TV Shows Cache)
-- ============================================
CREATE TABLE IF NOT EXISTS public.media (
    id BIGINT PRIMARY KEY,  -- TMDB ID
    media_type VARCHAR(10) NOT NULL CHECK (media_type IN ('movie', 'tv')),
    title VARCHAR(500) NOT NULL,
    original_title VARCHAR(500),
    overview TEXT,
    poster_path VARCHAR(500),
    backdrop_path VARCHAR(500),
    release_date DATE,
    vote_average DECIMAL(3, 1),
    vote_count INTEGER,
    popularity DECIMAL(10, 3),
    original_language VARCHAR(10),
    genres JSONB,  -- Array of genre objects
    runtime INTEGER,  -- in minutes
    status VARCHAR(50),
    tagline TEXT,
    homepage VARCHAR(500),
    -- Streaming availability (from TMDB watch providers)
    streaming_providers JSONB,  -- {country: [{provider_name, logo_path, provider_id}]}
    -- Metadata
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    -- Indexes
    CONSTRAINT unique_media_type_id UNIQUE (id, media_type)
);

-- Indexes for media table
CREATE INDEX idx_media_type ON public.media(media_type);
CREATE INDEX idx_media_title ON public.media USING gin(to_tsvector('english', title));
CREATE INDEX idx_media_release_date ON public.media(release_date DESC);
CREATE INDEX idx_media_popularity ON public.media(popularity DESC);
CREATE INDEX idx_media_vote_average ON public.media(vote_average DESC);

-- ============================================
-- USER_MEDIA TABLE (User's Personal List)
-- ============================================
CREATE TABLE IF NOT EXISTS public.user_media (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    user_id UUID NOT NULL REFERENCES auth.users(id) ON DELETE CASCADE,
    media_id BIGINT NOT NULL,
    media_type VARCHAR(10) NOT NULL CHECK (media_type IN ('movie', 'tv')),
    -- User's personal data
    watch_status VARCHAR(20) NOT NULL DEFAULT 'to_watch' CHECK (watch_status IN ('to_watch', 'watching', 'watched')),
    my_rating DECIMAL(3, 1) CHECK (my_rating >= 0 AND my_rating <= 10),
    my_review TEXT,
    is_favorite BOOLEAN DEFAULT FALSE,
    -- Metadata
    added_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    watched_at TIMESTAMP WITH TIME ZONE,
    -- Foreign key to media table
    FOREIGN KEY (media_id, media_type) REFERENCES public.media(id, media_type) ON DELETE CASCADE,
    -- Ensure user can't add same media twice
    CONSTRAINT unique_user_media UNIQUE (user_id, media_id, media_type)
);

-- Indexes for user_media table
CREATE INDEX idx_user_media_user_id ON public.user_media(user_id);
CREATE INDEX idx_user_media_status ON public.user_media(watch_status);
CREATE INDEX idx_user_media_favorite ON public.user_media(is_favorite) WHERE is_favorite = TRUE;
CREATE INDEX idx_user_media_rating ON public.user_media(my_rating DESC) WHERE my_rating IS NOT NULL;
CREATE INDEX idx_user_media_added_at ON public.user_media(added_at DESC);

-- ============================================
-- TRIGGERS
-- ============================================

-- Update updated_at timestamp automatically
CREATE OR REPLACE FUNCTION update_updated_at_column()
RETURNS TRIGGER AS $$
BEGIN
    NEW.updated_at = NOW();
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER update_media_updated_at
    BEFORE UPDATE ON public.media
    FOR EACH ROW
    EXECUTE FUNCTION update_updated_at_column();

CREATE TRIGGER update_user_media_updated_at
    BEFORE UPDATE ON public.user_media
    FOR EACH ROW
    EXECUTE FUNCTION update_updated_at_column();

-- ============================================
-- ROW LEVEL SECURITY (RLS)
-- ============================================

-- Enable RLS
ALTER TABLE public.media ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.user_media ENABLE ROW LEVEL SECURITY;

-- Media table policies (public read, authenticated write)
CREATE POLICY "Media are viewable by everyone"
    ON public.media FOR SELECT
    USING (true);

CREATE POLICY "Authenticated users can insert media"
    ON public.media FOR INSERT
    TO authenticated
    WITH CHECK (true);

CREATE POLICY "Authenticated users can update media"
    ON public.media FOR UPDATE
    TO authenticated
    USING (true);

-- User_media table policies (users can only access their own data)
CREATE POLICY "Users can view their own media list"
    ON public.user_media FOR SELECT
    USING (auth.uid() = user_id);

CREATE POLICY "Users can insert their own media"
    ON public.user_media FOR INSERT
    TO authenticated
    WITH CHECK (auth.uid() = user_id);

CREATE POLICY "Users can update their own media"
    ON public.user_media FOR UPDATE
    TO authenticated
    USING (auth.uid() = user_id);

CREATE POLICY "Users can delete their own media"
    ON public.user_media FOR DELETE
    TO authenticated
    USING (auth.uid() = user_id);

-- ============================================
-- HELPER FUNCTIONS
-- ============================================

-- Function to get user's media list with filters
CREATE OR REPLACE FUNCTION get_user_media_list(
    p_user_id UUID,
    p_watch_status VARCHAR DEFAULT NULL,
    p_media_type VARCHAR DEFAULT NULL,
    p_is_favorite BOOLEAN DEFAULT NULL,
    p_limit INTEGER DEFAULT 50,
    p_offset INTEGER DEFAULT 0
)
RETURNS TABLE (
    id UUID,
    media_id BIGINT,
    media_type VARCHAR,
    title VARCHAR,
    poster_path VARCHAR,
    watch_status VARCHAR,
    my_rating DECIMAL,
    my_review TEXT,
    is_favorite BOOLEAN,
    added_at TIMESTAMP WITH TIME ZONE,
    updated_at TIMESTAMP WITH TIME ZONE
) AS $$
BEGIN
    RETURN QUERY
    SELECT 
        um.id,
        um.media_id,
        um.media_type,
        m.title,
        m.poster_path,
        um.watch_status,
        um.my_rating,
        um.my_review,
        um.is_favorite,
        um.added_at,
        um.updated_at
    FROM public.user_media um
    JOIN public.media m ON um.media_id = m.id AND um.media_type = m.media_type
    WHERE um.user_id = p_user_id
        AND (p_watch_status IS NULL OR um.watch_status = p_watch_status)
        AND (p_media_type IS NULL OR um.media_type = p_media_type)
        AND (p_is_favorite IS NULL OR um.is_favorite = p_is_favorite)
    ORDER BY um.added_at DESC
    LIMIT p_limit
    OFFSET p_offset;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- Function to get media statistics for a user
CREATE OR REPLACE FUNCTION get_user_media_stats(p_user_id UUID)
RETURNS TABLE (
    total_count INTEGER,
    to_watch_count INTEGER,
    watching_count INTEGER,
    watched_count INTEGER,
    favorites_count INTEGER,
    average_rating DECIMAL
) AS $$
BEGIN
    RETURN QUERY
    SELECT 
        COUNT(*)::INTEGER AS total_count,
        COUNT(*) FILTER (WHERE watch_status = 'to_watch')::INTEGER AS to_watch_count,
        COUNT(*) FILTER (WHERE watch_status = 'watching')::INTEGER AS watching_count,
        COUNT(*) FILTER (WHERE watch_status = 'watched')::INTEGER AS watched_count,
        COUNT(*) FILTER (WHERE is_favorite = TRUE)::INTEGER AS favorites_count,
        ROUND(AVG(my_rating), 1) AS average_rating
    FROM public.user_media
    WHERE user_id = p_user_id;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- ============================================
-- SAMPLE DATA (Optional - for testing)
-- ============================================

-- Insert some sample movies (you can remove this in production)
-- INSERT INTO public.media (id, media_type, title, overview, poster_path, release_date, vote_average, vote_count, popularity)
-- VALUES 
--     (550, 'movie', 'Fight Club', 'A ticking-time-bomb insomniac and a slippery soap salesman channel primal male aggression into a shocking new form of therapy.', '/pB8BM7pdSp6B6Ih7QZ4DrQ3PmJK.jpg', '1999-10-15', 8.4, 26280, 61.416),
--     (13, 'movie', 'Forrest Gump', 'A man with a low IQ has accomplished great things in his life and been present during significant historic events.', '/arw2vcBveWOVZr6pxd9XTd1TdQa.jpg', '1994-07-06', 8.5, 25471, 48.926);
