import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../domain/entities/media.dart';
import '../providers/media_providers.dart';

/// Home Page - Catalog only (no search bar)
/// Shows trending, popular movies, and popular TV shows
class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  @override
  void initState() {
    super.initState();
    // Load trending content on init
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(discoveryViewModelProvider.notifier).loadTrendingMedia();
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(discoveryViewModelProvider);

    return Scaffold(
      backgroundColor: Colors.black,
      body: CustomScrollView(
        slivers: [
          _buildAppBar(),
          if (state.errorMessage != null)
            SliverToBoxAdapter(child: _buildErrorMessage(state.errorMessage!)),
          _buildContent(state),
        ],
      ),
    );
  }

  Widget _buildAppBar() {
    return SliverAppBar(
      floating: true,
      backgroundColor: Colors.black,
      title: Row(
        children: [
          Text(
            'CinéBox',
            style: TextStyle(
              color: Colors.red.shade600,
              fontSize: 28,
              fontWeight: FontWeight.bold,
              letterSpacing: -0.5,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildErrorMessage(String message) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.red.shade900.withValues(alpha: 0.3),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.red.shade800),
        ),
        child: Row(
          children: [
            const Icon(Icons.error_outline, color: Colors.red),
            const SizedBox(width: 12),
            Expanded(
              child: Text(message, style: const TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContent(state) {
    if (state.isLoading) {
      return const SliverFillRemaining(
        child: Center(child: CircularProgressIndicator(color: Colors.red)),
      );
    }

    return SliverToBoxAdapter(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 10),
          // Tendances
          if (state.trendingMedia.isNotEmpty) ...[
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                'Tendances du moment 🔥',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              height: 220,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 12),
                itemCount: state.trendingMedia.length,
                itemBuilder: (context, index) {
                  return _buildHorizontalMediaCard(
                    context,
                    state.trendingMedia[index],
                  );
                },
              ),
            ),
            const SizedBox(height: 30),
          ],
          // Films populaires
          if (state.popularMovies.isNotEmpty) ...[
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                'Films populaires 🎬',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              height: 220,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 12),
                itemCount: state.popularMovies.length,
                itemBuilder: (context, index) {
                  return _buildHorizontalMediaCard(
                    context,
                    state.popularMovies[index],
                  );
                },
              ),
            ),
            const SizedBox(height: 30),
          ],
          // Séries populaires
          if (state.popularTvShows.isNotEmpty) ...[
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                'Séries populaires 📺',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              height: 220,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 12),
                itemCount: state.popularTvShows.length,
                itemBuilder: (context, index) {
                  return _buildHorizontalMediaCard(
                    context,
                    state.popularTvShows[index],
                  );
                },
              ),
            ),
            const SizedBox(height: 30),
          ],
        ],
      ),
    );
  }

  Widget _buildHorizontalMediaCard(BuildContext context, Media media) {
    return GestureDetector(
      onTap: () => context.push('/media/${media.mediaType}/${media.id}'),
      child: Container(
        width: 140,
        margin: const EdgeInsets.symmetric(horizontal: 4),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: media.posterPath != null
                  ? Image.network(
                      'https://image.tmdb.org/t/p/w342${media.posterPath}',
                      height: 170,
                      width: 140,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          height: 170,
                          width: 140,
                          color: Colors.grey.shade900,
                          child: const Icon(Icons.movie, color: Colors.grey),
                        );
                      },
                    )
                  : Container(
                      height: 170,
                      width: 140,
                      color: Colors.grey.shade900,
                      child: const Icon(Icons.movie, color: Colors.grey),
                    ),
            ),
            const SizedBox(height: 8),
            Text(
              media.title ?? 'Unknown',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 13,
                fontWeight: FontWeight.w500,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
