# 🎬 CinéBox - Backend Setup Guide

## 📋 Ce qui a été implémenté

### ✅ Architecture Clean + MVVM
- **Core Layer** : Failures, Exceptions, Result types, Config
- **Auth Feature** : Authentification complète (JWT + OAuth GitHub)
- **Media Feature** : CRUD complet avec cache TMDB + Supabase

### ✅ Fonctionnalités
1. **Authentification**
   - JWT (email/password)
   - OAuth GitHub
   - Guards de navigation
   - Gestion de session

2. **API CRUD Media**
   - Cache intelligent (TMDB → Supabase)
   - Liste personnelle utilisateur
   - Statuts de visionnage (à voir, en cours, vu)
   - Notes et reviews personnelles
   - Favoris
   - Statistiques utilisateur
   - **Plateformes de streaming** (via TMDB watch providers)

3. **Guards & Sécurité**
   - Routes protégées (nécessitent authentification)
   - Row Level Security (RLS) Supabase
   - Validation des données

---

## 🚀 Installation

### 1. Installer les dépendances

```bash
flutter pub get
```

### 2. Configurer les variables d'environnement

Copier `.env.example` vers `.env` et remplir :

```env
# TMDB API
TMDB_API_KEY=votre_clé_tmdb
TMDB_BASE_URL=https://api.themoviedb.org/3

# GitHub OAuth
GITHUB_CLIENT_ID=votre_github_client_id
GITHUB_CLIENT_SECRET=votre_github_client_secret

# Supabase
SUPABASE_URL=https://votre-projet.supabase.co
SUPABASE_ANON_KEY=votre_supabase_anon_key
SUPABASE_SERVICE_ROLE_KEY=votre_supabase_service_role_key
```

### 3. Configurer Supabase

#### A. Créer le schéma de base de données

1. Aller dans **SQL Editor** de votre projet Supabase
2. Copier le contenu de `supabase/schema.sql`
3. Exécuter le script

#### B. Configurer OAuth GitHub

**Dans GitHub :**
1. Aller dans **Settings** > **Developer settings** > **OAuth Apps**
2. Créer une nouvelle OAuth App :
   - **Application name** : CinéBox
   - **Homepage URL** : `https://votre-projet.supabase.co`
   - **Authorization callback URL** : `https://votre-projet.supabase.co/auth/v1/callback`
3. Noter le **Client ID** et **Client Secret**

**Dans Supabase :**
1. Aller dans **Authentication** > **Providers**
2. Activer **GitHub**
3. Entrer le **Client ID** et **Client Secret**
4. Sauvegarder

### 4. Générer le code (Freezed, JSON, Retrofit)

```bash
flutter pub run build_runner build --delete-conflicting-outputs
```

Cette commande génère :
- Classes Freezed (`.freezed.dart`)
- Sérialiseurs JSON (`.g.dart`)
- Clients Retrofit

### 5. Lancer l'application

```bash
flutter run
```

---

## 📁 Structure du projet

```
lib/
  src/
    core/
      error/
        failures.dart           # Types de failures
        exceptions.dart         # Exceptions
      network/
        dio_client.dart         # Client HTTP TMDB
      config/
        env_config.dart         # Configuration environnement
      utils/
        result.dart             # Type Result<T>
    
    features/
      auth/
        domain/
          entities/             # UserEntity
          repositories/         # AuthRepository (interface)
          usecases/            # SignIn, SignUp, SignOut, etc.
        data/
          models/              # UserModel
          datasources/         # AuthRemoteDataSource (Supabase)
          repositories/        # AuthRepositoryImpl
        presentation/
          viewmodels/          # AuthViewModel
          pages/               # LoginPage, SignUpPage, SplashPage
          providers/           # Riverpod providers
      
      media/
        domain/
          entities/            # Media, UserMedia
          repositories/        # MediaRepository (interface)
          usecases/           # GetMediaById, SearchMedia, etc.
        data/
          models/             # MediaModel, UserMediaModel
          datasources/        # TmdbRemoteDataSource, MediaSupabaseDataSource
          repositories/       # MediaRepositoryImpl
        presentation/
          providers/          # Riverpod providers
    
    app/
      router/
        app_router.dart       # Navigation avec guards
  
  main.dart                   # Point d'entrée
```

---

## 🔐 Authentification

### Flux d'authentification

```
1. SplashPage
   ↓
2. Vérification auth state
   ↓
3a. Authentifié → HomePage
3b. Non authentifié → LoginPage
```

### Utilisation dans le code

```dart
// Vérifier si l'utilisateur est connecté
final isAuthenticated = ref.watch(isAuthenticatedProvider);

// Obtenir l'utilisateur actuel
final currentUser = ref.watch(currentUserProvider);

// Se connecter
final authViewModel = ref.read(authViewModelProvider.notifier);
await authViewModel.signInWithEmail(email, password);

// Se déconnecter
await authViewModel.signOut();
```

---

## 🎬 API Media

### Cache Strategy

Le système utilise une stratégie de cache intelligente :

```
1. User demande un film (ex: La La Land, ID: 313369)
2. Vérifier si existe dans Supabase (table media)
3. Si OUI → Retourner depuis Supabase (rapide)
4. Si NON → 
   a. Fetch depuis TMDB API
   b. Fetch watch providers (plateformes streaming)
   c. Stocker dans Supabase
   d. Retourner les données
```

### Endpoints TMDB utilisés

- `/movie/{id}` - Détails film
- `/tv/{id}` - Détails série
- `/movie/{id}/watch/providers` - **Plateformes streaming film**
- `/tv/{id}/watch/providers` - **Plateformes streaming série**
- `/search/multi` - Recherche
- `/trending/all/week` - Trending
- `/movie/popular` - Films populaires
- `/tv/popular` - Séries populaires

### Utilisation dans le code

```dart
// Obtenir un média (avec cache automatique)
final getMediaById = ref.read(getMediaByIdProvider);
final result = await getMediaById(
  id: 313369,
  mediaType: 'movie',
  language: 'fr-FR',
);

// Rechercher des médias
final searchMedia = ref.read(searchMediaProvider);
final results = await searchMedia(query: 'Inception');

// Ajouter à ma liste
final upsertUserMedia = ref.read(upsertUserMediaProvider);
await upsertUserMedia(
  mediaId: 313369,
  mediaType: 'movie',
  watchStatus: WatchStatus.toWatch,
  myRating: 8.5,
  myReview: 'Excellent film !',
  isFavorite: true,
);

// Obtenir ma liste
final getUserMediaList = ref.read(getUserMediaListProvider);
final myList = await getUserMediaList(
  status: WatchStatus.watched,
  isFavorite: true,
);
```

---

## 🔒 Guards de navigation

Les routes protégées nécessitent une authentification :

```dart
// Routes publiques
/ (home)
/search
/media/:type/:id

// Routes protégées (nécessitent auth)
/my-list
/profile
```

Le router redirige automatiquement vers `/login` si l'utilisateur n'est pas authentifié.

---

## 📊 Base de données Supabase

### Tables

#### `media` (Cache TMDB)
- Stocke les films/séries récupérés depuis TMDB
- **Inclut les plateformes de streaming** dans `streaming_providers` (JSONB)
- RLS : Lecture publique, écriture authentifiée

#### `user_media` (Liste personnelle)
- Stocke les médias de chaque utilisateur
- Colonnes : `watch_status`, `my_rating`, `my_review`, `is_favorite`
- RLS : Chaque user ne voit que ses propres données

### Fonctions SQL

- `get_user_media_list()` - Liste avec filtres
- `get_user_media_stats()` - Statistiques utilisateur

---

## 🎨 Plateformes de Streaming

L'API TMDB fournit les plateformes de streaming disponibles par pays.

### Structure des données

```json
{
  "FR": [
    {
      "provider_id": 8,
      "provider_name": "Netflix",
      "logo_path": "/t2yyOv40HZeVlLjYsCsPHnWLk4W.jpg"
    },
    {
      "provider_id": 119,
      "provider_name": "Amazon Prime Video",
      "logo_path": "/emthp39XA2YScoYL1p0sdbAH2WA.jpg"
    }
  ]
}
```

### Affichage dans l'UI

```dart
// Obtenir les providers pour la France
final providers = media.streamingProviders?['FR'];

if (providers != null && providers.isNotEmpty) {
  // Afficher les logos
  for (final provider in providers) {
    Image.network(provider.logoUrl);
  }
}
```

---

## 🧪 Tests

```bash
# Tous les tests
flutter test

# Tests unitaires
flutter test test/unit/

# Analyse du code
flutter analyze
```

---

## 🔧 Commandes utiles

```bash
# Générer le code (après modification des models)
flutter pub run build_runner build --delete-conflicting-outputs

# Watch mode (génération automatique)
flutter pub run build_runner watch

# Clean
flutter clean && flutter pub get

# Vérifier les dépendances obsolètes
flutter pub outdated
```

---

## 📝 TODO pour votre collègue (Frontend)

Votre collègue doit implémenter les pages UI :

1. **HomePage / DiscoverPage**
   - Afficher trending media
   - Grilles de films/séries populaires
   - Navigation vers détails

2. **SearchPage**
   - Champ de recherche
   - Résultats en grille
   - Filtres (type, genre)

3. **MediaDetailPage**
   - Affiche détails du média
   - **Affiche les plateformes de streaming disponibles**
   - Boutons "Ajouter à ma liste", "Éditer"

4. **MyListPage** (protégée)
   - Liste des médias de l'utilisateur
   - Filtres par statut
   - Tri

5. **ProfilePage** (protégée)
   - Informations utilisateur
   - Statistiques
   - Déconnexion

---

## 🐛 Debugging

### Problèmes courants

**1. Erreurs de génération de code**
```bash
flutter pub run build_runner clean
flutter pub run build_runner build --delete-conflicting-outputs
```

**2. Erreur Supabase "User not authenticated"**
- Vérifier que l'utilisateur est connecté
- Vérifier les RLS policies dans Supabase

**3. Erreur TMDB API**
- Vérifier la clé API dans `.env`
- Vérifier les quotas TMDB

**4. OAuth GitHub ne fonctionne pas**
- Vérifier les URLs de callback
- Vérifier les credentials dans Supabase

---

## 📚 Ressources

- [Supabase Documentation](https://supabase.com/docs)
- [TMDB API Documentation](https://developer.themoviedb.org/docs)
- [Riverpod Documentation](https://riverpod.dev)
- [Go Router Documentation](https://pub.dev/packages/go_router)
- [Freezed Documentation](https://pub.dev/packages/freezed)

---

## ✅ Checklist d'implémentation

- [x] Core (Failures, Exceptions, Result, Config)
- [x] Auth Domain (Entities, Repositories, Use Cases)
- [x] Auth Data (Models, DataSources, Repository Impl)
- [x] Auth Presentation (ViewModels, Pages, Providers)
- [x] Media Domain (Entities, Repositories, Use Cases)
- [x] Media Data (Models, DataSources, Repository Impl)
- [x] Media Presentation (Providers)
- [x] Navigation avec Guards
- [x] Schéma Supabase
- [x] Configuration OAuth GitHub
- [x] **Support plateformes de streaming**
- [ ] Pages UI (à faire par votre collègue)
- [ ] Tests unitaires
- [ ] Tests d'intégration

---

**Bon courage pour la suite du projet ! 🚀**
