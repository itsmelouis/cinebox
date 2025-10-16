# Supabase Database Setup

## 📋 Overview

Ce projet utilise Supabase comme backend pour :
- **Authentification** : JWT + OAuth (GitHub)
- **Base de données** : PostgreSQL avec cache des médias TMDB
- **Row Level Security (RLS)** : Sécurité au niveau des lignes

## 🗄️ Schema

### Tables

#### 1. `media` (Cache TMDB)
Stocke les informations des films/séries récupérées depuis TMDB.

**Colonnes principales :**
- `id` : TMDB ID (PRIMARY KEY)
- `media_type` : 'movie' ou 'tv'
- `title`, `overview`, `poster_path`, etc.
- `streaming_providers` : Disponibilité sur les plateformes de streaming (JSONB)
- `created_at`, `updated_at`

**Politique RLS :**
- ✅ Lecture publique (tout le monde peut voir)
- ✅ Écriture authentifiée (seuls les utilisateurs connectés peuvent ajouter/modifier)

#### 2. `user_media` (Liste personnelle)
Stocke les médias ajoutés par chaque utilisateur avec leurs données personnelles.

**Colonnes principales :**
- `id` : UUID (PRIMARY KEY)
- `user_id` : Référence vers `auth.users`
- `media_id`, `media_type` : Référence vers `media`
- `watch_status` : 'to_watch', 'watching', 'watched'
- `my_rating` : Note personnelle (0-10)
- `my_review` : Critique personnelle
- `is_favorite` : Favori ou non
- `added_at`, `updated_at`, `watched_at`

**Politique RLS :**
- ✅ Chaque utilisateur ne peut voir/modifier que ses propres données

### Functions

#### `get_user_media_list()`
Récupère la liste des médias d'un utilisateur avec filtres.

**Paramètres :**
- `p_user_id` : UUID de l'utilisateur
- `p_watch_status` : Filtrer par statut (optionnel)
- `p_media_type` : Filtrer par type (optionnel)
- `p_is_favorite` : Filtrer les favoris (optionnel)
- `p_limit`, `p_offset` : Pagination

#### `get_user_media_stats()`
Récupère les statistiques d'un utilisateur (nombre total, par statut, note moyenne, etc.).

## 🚀 Installation

### 1. Créer un projet Supabase

1. Aller sur [supabase.com](https://supabase.com)
2. Créer un nouveau projet
3. Noter l'URL et les clés API

### 2. Exécuter le schema SQL

1. Aller dans l'onglet **SQL Editor** de votre projet Supabase
2. Copier le contenu de `schema.sql`
3. Exécuter le script

### 3. Configurer OAuth GitHub

#### Dans GitHub :
1. Aller dans **Settings** > **Developer settings** > **OAuth Apps**
2. Créer une nouvelle OAuth App :
   - **Application name** : CinéBox
   - **Homepage URL** : `https://votre-projet.supabase.co`
   - **Authorization callback URL** : `https://votre-projet.supabase.co/auth/v1/callback`
3. Noter le **Client ID** et **Client Secret**

#### Dans Supabase :
1. Aller dans **Authentication** > **Providers**
2. Activer **GitHub**
3. Entrer le **Client ID** et **Client Secret**
4. Sauvegarder

### 4. Configurer les variables d'environnement

Copier `.env.example` vers `.env` et remplir :

```env
# Supabase
SUPABASE_URL=https://votre-projet.supabase.co
SUPABASE_ANON_KEY=votre_anon_key
SUPABASE_SERVICE_ROLE_KEY=votre_service_role_key

# GitHub OAuth
GITHUB_CLIENT_ID=votre_github_client_id
GITHUB_CLIENT_SECRET=votre_github_client_secret

# TMDB
TMDB_API_KEY=votre_tmdb_api_key
TMDB_BASE_URL=https://api.themoviedb.org/3
```

## 🔒 Sécurité

### Row Level Security (RLS)

Le RLS est activé sur toutes les tables pour garantir que :
- Les utilisateurs ne peuvent accéder qu'à leurs propres données dans `user_media`
- Tout le monde peut lire les données de `media` (cache public)
- Seuls les utilisateurs authentifiés peuvent écrire dans `media`

### Policies

```sql
-- user_media : accès restreint à l'utilisateur propriétaire
CREATE POLICY "Users can view their own media list"
    ON public.user_media FOR SELECT
    USING (auth.uid() = user_id);

-- media : lecture publique, écriture authentifiée
CREATE POLICY "Media are viewable by everyone"
    ON public.media FOR SELECT
    USING (true);
```

## 📊 Workflow de données

### 1. Récupération d'un média

```
1. User recherche "La La Land"
2. App vérifie si le film existe dans `media` (cache)
3. Si OUI : retourner depuis Supabase
4. Si NON : 
   - Fetch depuis TMDB API
   - Insérer dans `media` (cache)
   - Retourner les données
```

### 2. Ajout à la liste personnelle

```
1. User clique "Ajouter à ma liste"
2. Vérifier que le média existe dans `media`
3. Si NON : fetch TMDB + insert dans `media`
4. Insérer dans `user_media` avec user_id
5. RLS garantit que seul le user peut voir/modifier cette entrée
```

## 🧪 Tests

### Tester le schema

```sql
-- Vérifier les tables
SELECT table_name FROM information_schema.tables 
WHERE table_schema = 'public';

-- Vérifier les policies
SELECT * FROM pg_policies WHERE schemaname = 'public';

-- Tester l'insertion d'un média
INSERT INTO public.media (id, media_type, title, overview)
VALUES (12345, 'movie', 'Test Movie', 'Test description');

-- Tester les stats (remplacer UUID par un vrai user_id)
SELECT * FROM get_user_media_stats('00000000-0000-0000-0000-000000000000');
```

## 📝 Notes

- **TMDB Watch Providers** : L'API TMDB fournit les plateformes de streaming via l'endpoint `/movie/{id}/watch/providers`. Stockez ces données dans `streaming_providers` (JSONB).
- **Cache Strategy** : Les données TMDB sont mises en cache pour réduire les appels API. Vous pouvez ajouter une logique de TTL (Time To Live) si nécessaire.
- **Migrations** : Pour les modifications futures du schema, utilisez les migrations Supabase.

## 🔗 Ressources

- [Supabase Documentation](https://supabase.com/docs)
- [Supabase Auth with Flutter](https://supabase.com/docs/guides/auth/auth-helpers/flutter-auth)
- [Row Level Security](https://supabase.com/docs/guides/auth/row-level-security)
- [TMDB API](https://developer.themoviedb.org/docs)
