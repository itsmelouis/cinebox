import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../domain/entities/media.dart';
import '../providers/media_providers.dart';

/// Search Page - Search bar with filters (reused from DiscoveryPage)
class SearchPage extends ConsumerStatefulWidget {
  const SearchPage({super.key});

  @override
  ConsumerState<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends ConsumerState<SearchPage> {
  final TextEditingController _searchController = TextEditingController();

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
          _buildAppBar(),
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
          _buildSearchResults(state),
        ],
      ),
    );
  }

  Widget _buildAppBar() {
    return SliverAppBar(
      floating: true,
      backgroundColor: Colors.black,
      title: Text(
        'Recherche',
        style: TextStyle(
          color: Colors.red.shade600,
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
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
                    if (currentState.selectedType != 'Tous' ||
                        currentState.minRating > 0)
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
    if (!state.isSearching) {
      return SliverFillRemaining(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.search, size: 64, color: Colors.grey.shade700),
              const SizedBox(height: 16),
              Text(
                'Recherchez un film ou une série',
                style: TextStyle(color: Colors.grey.shade600, fontSize: 18),
              ),
            ],
          ),
        ),
      );
    }

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

  Widget _buildMediaCard(BuildContext context, Media media) {
    return GestureDetector(
      onTap: () => context.push('/media/${media.mediaType}/${media.id}'),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: media.posterPath != null
            ? Image.network(
                'https://image.tmdb.org/t/p/w342${media.posterPath}',
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    color: Colors.grey.shade900,
                    child: const Icon(Icons.movie, color: Colors.grey),
                  );
                },
              )
            : Container(
                color: Colors.grey.shade900,
                child: const Icon(Icons.movie, color: Colors.grey),
              ),
      ),
    );
  }
}
