import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../domain/entities/media.dart';
import '../providers/media_providers.dart';
import 'media_detail_page.dart';

/// Discovery Page - Pure UI
/// Displays trending media and search functionality
class DiscoveryPage extends ConsumerStatefulWidget {
  const DiscoveryPage({super.key});

  @override
  ConsumerState<DiscoveryPage> createState() => _DiscoveryPageState();
}

class _DiscoveryPageState extends ConsumerState<DiscoveryPage> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Load trending media on init
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(discoveryViewModelProvider.notifier).loadTrendingMedia();
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(discoveryViewModelProvider);
    final viewModel = ref.read(discoveryViewModelProvider.notifier);

    return Scaffold(
      backgroundColor: Colors.black,
      body: CustomScrollView(
        slivers: [
          _buildAppBar(context),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
              child: Row(
                children: [
                  Expanded(child: _buildSearchBar(viewModel)),
                  const SizedBox(width: 12),
                  _buildFilterButton(context, state, viewModel),
                ],
              ),
            ),
          ),
          if (state.errorMessage != null)
            SliverToBoxAdapter(child: _buildErrorMessage(state.errorMessage!)),
          state.isSearching
              ? _buildSearchResults(state)
              : _buildTrendingContent(state, viewModel),
        ],
      ),
    );
  }

  Widget _buildSearchBar(viewModel) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey.shade900,
        borderRadius: BorderRadius.circular(12),
      ),
      child: TextField(
        controller: _searchController,
        onChanged: (query) => viewModel.searchMedia(query),
        style: const TextStyle(color: Colors.white),
        decoration: InputDecoration(
          hintText: 'Rechercher...',
          hintStyle: TextStyle(color: Colors.grey.shade600),
          prefixIcon: Icon(Icons.search, color: Colors.grey.shade600),
          suffixIcon: _searchController.text.isNotEmpty
              ? IconButton(
                  icon: Icon(Icons.clear, color: Colors.grey.shade600),
                  onPressed: () {
                    _searchController.clear();
                    viewModel.clearSearch();
                  },
                )
              : null,
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 14,
          ),
        ),
      ),
    );
  }

  Widget _buildFilterButton(context, state, viewModel) {
    final hasActiveFilters =
        state.selectedType != 'Tous' || state.minRating > 0;

    return Container(
      decoration: BoxDecoration(
        color: hasActiveFilters ? Colors.red.shade600 : Colors.grey.shade900,
        borderRadius: BorderRadius.circular(12),
      ),
      child: IconButton(
        icon: Stack(
          children: [
            const Icon(Icons.tune, color: Colors.white),
            if (hasActiveFilters)
              Positioned(
                right: 0,
                top: 0,
                child: Container(
                  width: 8,
                  height: 8,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
          ],
        ),
        onPressed: () => _showFiltersModal(context, state, viewModel),
      ),
    );
  }

  void _showFiltersModal(context, state, viewModel) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.grey.shade900,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (modalContext) => Consumer(
        builder: (context, ref, child) {
          // Watch the state inside the modal to rebuild when it changes
          final currentState = ref.watch(discoveryViewModelProvider);
          
          return Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Text(
                      'Filtres',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Spacer(),
                    if (currentState.selectedType != 'Tous' || currentState.minRating > 0)
                      TextButton(
                        onPressed: () => viewModel.resetFilters(),
                        child: const Text(
                          'Réinitialiser',
                          style: TextStyle(color: Colors.red),
                        ),
                      ),
                    IconButton(
                      icon: const Icon(Icons.close, color: Colors.white),
                      onPressed: () => Navigator.pop(modalContext),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                Text(
                  'Type',
                  style: TextStyle(
                    color: Colors.grey.shade400,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 12),
                Wrap(
                  spacing: 8,
                  children: ['Tous', 'Films', 'Séries'].map((type) {
                    return _buildFilterChip(
                      type,
                      currentState.selectedType == type,
                      () => viewModel.updateTypeFilter(type),
                    );
                  }).toList(),
                ),
                const SizedBox(height: 24),
                Row(
                  children: [
                    Text(
                      'Note minimale: ${currentState.minRating.toStringAsFixed(1)}',
                      style: TextStyle(
                        color: Colors.grey.shade400,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(width: 8),
                    const Icon(Icons.star, color: Colors.amber, size: 16),
                  ],
                ),
                Slider(
                  value: currentState.minRating,
                  min: 0,
                  max: 10,
                  divisions: 20,
                  activeColor: Colors.red.shade600,
                  inactiveColor: Colors.grey.shade800,
                  onChanged: (value) => viewModel.updateMinRating(value),
                ),
                const SizedBox(height: 16),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildFilterChip(String label, bool isSelected, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? Colors.red.shade600 : Colors.grey.shade900,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected ? Colors.red.shade600 : Colors.grey.shade800,
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.grey.shade400,
            fontSize: 14,
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
          ),
        ),
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

  Widget _buildSearchResults(state) {
    if (state.isSearchLoading) {
      return const SliverFillRemaining(
        child: Center(child: CircularProgressIndicator(color: Colors.red)),
      );
    }

    if (state.searchResults.isEmpty) {
      return SliverFillRemaining(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.search_off, size: 64, color: Colors.grey.shade700),
              const SizedBox(height: 16),
              Text(
                'Aucun résultat trouvé',
                style: TextStyle(color: Colors.grey.shade600, fontSize: 18),
              ),
            ],
          ),
        ),
      );
    }

    return SliverPadding(
      padding: const EdgeInsets.all(16),
      sliver: SliverGrid(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          childAspectRatio: 0.65,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
        ),
        delegate: SliverChildBuilderDelegate((context, index) {
          return _buildMediaCard(context, state.searchResults[index]);
        }, childCount: state.searchResults.length),
      ),
    );
  }

  Widget _buildTrendingContent(state, viewModel) {
    if (state.isLoading) {
      return const SliverFillRemaining(
        child: Center(child: CircularProgressIndicator(color: Colors.red)),
      );
    }

    final filteredMedia = viewModel.getFilteredTrendingMedia();

    if (filteredMedia.isEmpty) {
      return SliverFillRemaining(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.filter_alt_off, size: 64, color: Colors.grey.shade700),
              const SizedBox(height: 16),
              Text(
                'Aucun contenu ne correspond aux filtres',
                style: TextStyle(color: Colors.grey.shade600, fontSize: 16),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      );
    }

    return SliverToBoxAdapter(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 10),
          // Tendances
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
              itemCount: filteredMedia.length,
              itemBuilder: (context, index) {
                return _buildHorizontalMediaCard(context, filteredMedia[index]);
              },
            ),
          ),
          const SizedBox(height: 30),
          // Films populaires
          _buildPopularMoviesSection(viewModel),
          const SizedBox(height: 30),
          // Séries populaires
          _buildPopularTvShowsSection(viewModel),
          const SizedBox(height: 30),
        ],
      ),
    );
  }

  Widget _buildPopularMoviesSection(viewModel) {
    final state = ref.watch(discoveryViewModelProvider);
    
    // Appliquer les filtres
    final filteredMovies = state.popularMovies.where((media) {
      final matchesRating =
          media.voteAverage == null || media.voteAverage! >= state.minRating;
      return matchesRating;
    }).toList();
    
    if (filteredMovies.isEmpty) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
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
            itemCount: filteredMovies.length,
            itemBuilder: (context, index) {
              return _buildHorizontalMediaCard(context, filteredMovies[index]);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildPopularTvShowsSection(viewModel) {
    final state = ref.watch(discoveryViewModelProvider);
    
    // Appliquer les filtres
    final filteredTvShows = state.popularTvShows.where((media) {
      final matchesRating =
          media.voteAverage == null || media.voteAverage! >= state.minRating;
      return matchesRating;
    }).toList();
    
    if (filteredTvShows.isEmpty) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
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
            itemCount: filteredTvShows.length,
            itemBuilder: (context, index) {
              return _buildHorizontalMediaCard(context, filteredTvShows[index]);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildMediaCard(BuildContext context, Media media) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                MediaDetailPage(mediaId: media.id, mediaType: media.mediaType),
          ),
        );
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Image.network(
                    media.posterUrl,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        color: Colors.grey.shade900,
                        child: const Icon(
                          Icons.movie_outlined,
                          color: Colors.grey,
                          size: 30,
                        ),
                      );
                    },
                  ),
                  if (media.voteAverage != null)
                    Positioned(
                      top: 4,
                      right: 4,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 6,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.black.withValues(alpha: 0.7),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(
                              Icons.star,
                              color: Colors.amber,
                              size: 10,
                            ),
                            const SizedBox(width: 2),
                            Text(
                              media.formattedVoteAverage,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            media.title,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHorizontalMediaCard(BuildContext context, Media media) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                MediaDetailPage(mediaId: media.id, mediaType: media.mediaType),
          ),
        );
      },
      child: Container(
        width: 140,
        margin: const EdgeInsets.symmetric(horizontal: 4),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Stack(
                children: [
                  Image.network(
                    media.posterUrl,
                    height: 180,
                    width: 140,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        height: 180,
                        width: 140,
                        color: Colors.grey.shade900,
                        child: const Icon(
                          Icons.movie_outlined,
                          color: Colors.grey,
                          size: 40,
                        ),
                      );
                    },
                  ),
                  if (media.voteAverage != null)
                    Positioned(
                      top: 8,
                      right: 8,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.black.withValues(alpha: 0.7),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(
                              Icons.star,
                              color: Colors.amber,
                              size: 14,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              media.formattedVoteAverage,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                ],
              ),
            ),
            const SizedBox(height: 8),
            Text(
              media.title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAppBar(BuildContext context) {
    return SliverAppBar(
      floating: true,
      pinned: true,
      backgroundColor: Colors.black,
      elevation: 0,
      title: ShaderMask(
        shaderCallback: (bounds) => LinearGradient(
          colors: [Colors.red.shade400, Colors.red.shade600],
        ).createShader(bounds),
        child: const Text(
          'Découverte',
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 8),
          child: GestureDetector(
            onTap: () {
              context.go('/my-list');
            },
            child: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  colors: [Colors.red.shade600, Colors.red.shade900],
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.red.withValues(alpha: 0.3),
                    blurRadius: 10,
                    spreadRadius: 2,
                  ),
                ],
              ),
              child: const Icon(
                Icons.bookmark_border,
                size: 20,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
