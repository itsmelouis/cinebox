# 🎨 CinéBox - Guide Frontend pour votre collègue

## 👋 Bienvenue !

Le backend est **100% fonctionnel**. Voici comment utiliser les fonctionnalités déjà implémentées pour créer les pages UI.

---

## 🚀 Quick Start

### 1. Comprendre la structure

Tout le backend est dans `lib/src/features/` :
- `auth/` - Authentification (déjà fait avec pages UI)
- `media/` - API CRUD médias (providers prêts, pages UI à faire)

### 2. Utiliser les providers (Riverpod)

Tous les providers sont déjà créés. Il suffit de les utiliser dans vos pages.

---

## 📱 Pages à créer

### 1. HomePage / DiscoverPage

**Emplacement :** `lib/src/features/media/presentation/pages/discover_page.dart`

**Fonctionnalités :**
- Afficher les films/séries trending
- Grilles de films populaires
- Grilles de séries populaires

**Code de base :**

```dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/media_providers.dart';

class DiscoverPage extends ConsumerWidget {
  const DiscoverPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Découvrir'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () => context.push('/search'),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Section Trending
            _buildSection(
              title: 'Tendances',
              child: _buildTrendingList(ref),
            ),
            
            // Section Films populaires
            _buildSection(
              title: 'Films populaires',
              child: _buildPopularMovies(ref),
            ),
            
            // Section Séries populaires
            _buildSection(
              title: 'Séries populaires',
              child: _buildPopularTvShows(ref),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTrendingList(WidgetRef ref) {
    // Utiliser le use case
    final getTrendingMedia = ref.read(getTrendingMediaProvider);
    
    return FutureBuilder(
      future: getTrendingMedia(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        }
        
        return snapshot.data?.fold(
          (failure) => Text('Erreur: $failure'),
          (mediaList) => ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: mediaList.length,
            itemBuilder: (context, index) {
              final media = mediaList[index];
              return MediaCard(media: media);
            },
          ),
        ) ?? const SizedBox();
      },
    );
  }
}
```

---

### 2. SearchPage

**Emplacement :** `lib/src/features/media/presentation/pages/search_page.dart`

**Fonctionnalités :**
- Champ de recherche
- Résultats en grille
- Filtres (optionnel)

**Code de base :**

```dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/media_providers.dart';

class SearchPage extends ConsumerStatefulWidget {
  const SearchPage({super.key});

  @override
  ConsumerState<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends ConsumerState<SearchPage> {
  final _searchController = TextEditingController();
  List<Media> _results = [];
  bool _isLoading = false;

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _search(String query) async {
    if (query.isEmpty) {
      setState(() => _results = []);
      return;
    }

    setState(() => _isLoading = true);

    final searchMedia = ref.read(searchMediaProvider);
    final result = await searchMedia(query: query);

    result.fold(
      (failure) {
        // Afficher erreur
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Erreur: $failure')),
        );
      },
      (mediaList) {
        setState(() => _results = mediaList);
      },
    );

    setState(() => _isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: _searchController,
          decoration: const InputDecoration(
            hintText: 'Rechercher un film ou une série...',
            border: InputBorder.none,
          ),
          onSubmitted: _search,
        ),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.7,
              ),
              itemCount: _results.length,
              itemBuilder: (context, index) {
                final media = _results[index];
                return MediaCard(media: media);
              },
            ),
    );
  }
}
```

---

### 3. MediaDetailPage

**Emplacement :** `lib/src/features/media/presentation/pages/media_detail_page.dart`

**Fonctionnalités :**
- Afficher détails du média
- **Afficher les plateformes de streaming** 🎯
- Bouton "Ajouter à ma liste"
- Bouton "Éditer" (si déjà dans la liste)

**Code de base :**

```dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/media_providers.dart';
import '../../../auth/presentation/providers/auth_providers.dart';

class MediaDetailPage extends ConsumerWidget {
  final int mediaId;
  final String mediaType;

  const MediaDetailPage({
    super.key,
    required this.mediaId,
    required this.mediaType,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final getMediaById = ref.read(getMediaByIdProvider);
    final isAuthenticated = ref.watch(isAuthenticatedProvider);

    return Scaffold(
      body: FutureBuilder(
        future: getMediaById(id: mediaId, mediaType: mediaType),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          return snapshot.data?.fold(
            (failure) => Center(child: Text('Erreur: $failure')),
            (media) => CustomScrollView(
              slivers: [
                // App bar avec backdrop
                SliverAppBar(
                  expandedHeight: 300,
                  flexibleSpace: FlexibleSpaceBar(
                    background: Image.network(
                      media.backdropUrl,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                
                // Contenu
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Titre
                        Text(
                          media.title,
                          style: Theme.of(context).textTheme.headlineMedium,
                        ),
                        const SizedBox(height: 8),
                        
                        // Note TMDB
                        Row(
                          children: [
                            const Icon(Icons.star, color: Colors.amber),
                            Text(' ${media.formattedVoteAverage}'),
                          ],
                        ),
                        const SizedBox(height: 16),
                        
                        // Synopsis
                        Text(
                          media.overview ?? 'Pas de synopsis disponible',
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        const SizedBox(height: 24),
                        
                        // 🎯 PLATEFORMES DE STREAMING
                        if (media.streamingProviders != null)
                          _buildStreamingProviders(context, media),
                        
                        const SizedBox(height: 24),
                        
                        // Boutons d'action
                        if (isAuthenticated)
                          _buildActionButtons(context, ref, media),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ) ?? const SizedBox();
        },
      ),
    );
  }

  Widget _buildStreamingProviders(BuildContext context, Media media) {
    // Récupérer les providers pour la France
    final providers = media.streamingProviders?['FR'];
    
    if (providers == null || providers.isEmpty) {
      return const SizedBox();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Disponible sur :',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: providers.map((provider) {
            return Tooltip(
              message: provider.providerName,
              child: Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  image: DecorationImage(
                    image: NetworkImage(provider.logoUrl),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildActionButtons(BuildContext context, WidgetRef ref, Media media) {
    return Row(
      children: [
        Expanded(
          child: ElevatedButton.icon(
            onPressed: () async {
              // Ajouter à ma liste
              final upsertUserMedia = ref.read(upsertUserMediaProvider);
              final result = await upsertUserMedia(
                mediaId: media.id,
                mediaType: media.mediaType,
                watchStatus: WatchStatus.toWatch,
              );
              
              result.fold(
                (failure) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Erreur: $failure')),
                  );
                },
                (userMedia) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Ajouté à votre liste !')),
                  );
                },
              );
            },
            icon: const Icon(Icons.add),
            label: const Text('Ajouter à ma liste'),
          ),
        ),
      ],
    );
  }
}
```

---

### 4. MyListPage (protégée)

**Emplacement :** `lib/src/features/media/presentation/pages/my_list_page.dart`

**Fonctionnalités :**
- Afficher la liste de l'utilisateur
- Filtres par statut (à voir, en cours, vu)
- Filtrer les favoris

**Code de base :**

```dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/media_providers.dart';

class MyListPage extends ConsumerStatefulWidget {
  const MyListPage({super.key});

  @override
  ConsumerState<MyListPage> createState() => _MyListPageState();
}

class _MyListPageState extends ConsumerState<MyListPage> {
  WatchStatus? _selectedStatus;
  bool? _showFavoritesOnly;

  @override
  Widget build(BuildContext context) {
    final getUserMediaList = ref.read(getUserMediaListProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Ma Liste'),
        actions: [
          // Filtres
          PopupMenuButton<WatchStatus?>(
            icon: const Icon(Icons.filter_list),
            onSelected: (status) {
              setState(() => _selectedStatus = status);
            },
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: null,
                child: Text('Tous'),
              ),
              const PopupMenuItem(
                value: WatchStatus.toWatch,
                child: Text('À voir'),
              ),
              const PopupMenuItem(
                value: WatchStatus.watching,
                child: Text('En cours'),
              ),
              const PopupMenuItem(
                value: WatchStatus.watched,
                child: Text('Vu'),
              ),
            ],
          ),
        ],
      ),
      body: FutureBuilder(
        future: getUserMediaList(
          status: _selectedStatus,
          isFavorite: _showFavoritesOnly,
        ),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          return snapshot.data?.fold(
            (failure) => Center(child: Text('Erreur: $failure')),
            (userMediaList) {
              if (userMediaList.isEmpty) {
                return const Center(
                  child: Text('Votre liste est vide'),
                );
              }

              return ListView.builder(
                itemCount: userMediaList.length,
                itemBuilder: (context, index) {
                  final userMedia = userMediaList[index];
                  return UserMediaCard(userMedia: userMedia);
                },
              );
            },
          ) ?? const SizedBox();
        },
      ),
    );
  }
}
```

---

## 🎨 Widgets réutilisables à créer

### MediaCard

```dart
class MediaCard extends StatelessWidget {
  final Media media;

  const MediaCard({super.key, required this.media});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.push('/media/${media.mediaType}/${media.id}');
      },
      child: Card(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Poster
            Expanded(
              child: Image.network(
                media.posterUrl,
                fit: BoxFit.cover,
                width: double.infinity,
              ),
            ),
            
            // Titre
            Padding(
              padding: const EdgeInsets.all(8),
              child: Text(
                media.title,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
```

---

## 📚 Providers disponibles

### Auth Providers

```dart
// Vérifier si authentifié
final isAuthenticated = ref.watch(isAuthenticatedProvider);

// Obtenir l'utilisateur actuel
final currentUser = ref.watch(currentUserProvider);

// Se déconnecter
final authViewModel = ref.read(authViewModelProvider.notifier);
await authViewModel.signOut();
```

### Media Providers

```dart
// Obtenir un média par ID
final getMediaById = ref.read(getMediaByIdProvider);
final result = await getMediaById(id: 123, mediaType: 'movie');

// Rechercher
final searchMedia = ref.read(searchMediaProvider);
final results = await searchMedia(query: 'Inception');

// Obtenir trending
final getTrendingMedia = ref.read(getTrendingMediaProvider);
final trending = await getTrendingMedia();

// Ajouter à ma liste
final upsertUserMedia = ref.read(upsertUserMediaProvider);
await upsertUserMedia(
  mediaId: 123,
  mediaType: 'movie',
  watchStatus: WatchStatus.toWatch,
  myRating: 8.5,
  myReview: 'Super film !',
);

// Obtenir ma liste
final getUserMediaList = ref.read(getUserMediaListProvider);
final myList = await getUserMediaList(status: WatchStatus.watched);

// Supprimer de ma liste
final deleteUserMedia = ref.read(deleteUserMediaProvider);
await deleteUserMedia(mediaId: 123, mediaType: 'movie');
```

---

## 🎯 Conseils

1. **Gestion des erreurs** : Toujours gérer les `Either<Failure, T>` avec `.fold()`
2. **Loading states** : Utiliser `FutureBuilder` ou `AsyncValue` de Riverpod
3. **Navigation** : Utiliser `context.push()` et `context.go()` de go_router
4. **Images** : Utiliser `cached_network_image` pour les posters
5. **Responsive** : Utiliser `LayoutBuilder` ou `MediaQuery`

---

## 🚀 Commencer maintenant

1. Créer `discover_page.dart`
2. Tester avec les providers
3. Créer les widgets réutilisables
4. Ajouter les autres pages

**Tout le backend est prêt, il ne reste que l'UI ! 🎨**
