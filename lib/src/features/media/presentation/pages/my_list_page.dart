import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../domain/entities/user_media.dart';
import '../providers/media_providers.dart';

/// My List Page - User's personal media collection
class MyListPage extends ConsumerStatefulWidget {
  const MyListPage({super.key});

  @override
  ConsumerState<MyListPage> createState() => _MyListPageState();
}

class _MyListPageState extends ConsumerState<MyListPage> {
  @override
  void initState() {
    super.initState();
    // Load media list on init
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(myListViewModelProvider.notifier).loadMediaList();
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(myListViewModelProvider);

    return Scaffold(
      backgroundColor: Colors.black,
      body: CustomScrollView(
        slivers: [
          _buildAppBar(context, state),
          if (state.isLoading)
            const SliverFillRemaining(
              child: Center(
                child: CircularProgressIndicator(color: Colors.red),
              ),
            )
          else if (state.errorMessage != null)
            SliverFillRemaining(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.error_outline, size: 64, color: Colors.red.shade600),
                    const SizedBox(height: 16),
                    Text(
                      state.errorMessage!,
                      style: const TextStyle(color: Colors.white),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            )
          else if (state.mediaList.isEmpty)
            SliverFillRemaining(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.movie_outlined, size: 80, color: Colors.grey.shade700),
                    const SizedBox(height: 16),
                    Text(
                      'Votre liste est vide',
                      style: TextStyle(
                        color: Colors.grey.shade400,
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Ajoutez des films et séries depuis la page Découvrir',
                      style: TextStyle(
                        color: Colors.grey.shade600,
                        fontSize: 14,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            )
          else
            SliverPadding(
              padding: const EdgeInsets.all(16),
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    final userMedia = state.mediaList[index];
                    return _buildMediaCard(context, userMedia);
                  },
                  childCount: state.mediaList.length,
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildAppBar(BuildContext context, state) {
    return SliverAppBar(
      floating: true,
      pinned: true,
      backgroundColor: Colors.black,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back, color: Colors.white),
        onPressed: () => context.go('/'),
      ),
      title: const Text(
        'Ma liste',
        style: TextStyle(
          color: Colors.white,
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
      ),
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(72),
        child: Padding(
          padding: const EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 16),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                _buildFilterChip('Tous', null, state.selectedFilter),
                const SizedBox(width: 8),
                _buildFilterChip('À voir', WatchStatus.toWatch, state.selectedFilter),
                const SizedBox(width: 8),
                _buildFilterChip('En cours', WatchStatus.watching, state.selectedFilter),
                const SizedBox(width: 8),
                _buildFilterChip('Vus', WatchStatus.watched, state.selectedFilter),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFilterChip(String label, WatchStatus? status, WatchStatus? selectedFilter) {
    final isSelected = status == selectedFilter;
    return FilterChip(
      label: Text(label),
      selected: isSelected,
      onSelected: (_) {
        ref.read(myListViewModelProvider.notifier).filterByStatus(status);
      },
      backgroundColor: Colors.grey.shade900,
      selectedColor: Colors.red.shade600,
      labelStyle: TextStyle(
        color: isSelected ? Colors.white : Colors.grey.shade400,
        fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
      ),
      checkmarkColor: Colors.white,
    );
  }

  Widget _buildMediaCard(BuildContext context, UserMedia userMedia) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.grey.shade900,
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        onTap: () {
          context.push('/media/${userMedia.mediaType}/${userMedia.mediaId}');
        },
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Poster
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: userMedia.posterPath != null
                    ? Image.network(
                        'https://image.tmdb.org/t/p/w200${userMedia.posterPath}',
                        width: 80,
                        height: 120,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            width: 80,
                            height: 120,
                            color: Colors.grey.shade800,
                            child: const Icon(Icons.movie, color: Colors.grey),
                          );
                        },
                      )
                    : Container(
                        width: 80,
                        height: 120,
                        color: Colors.grey.shade800,
                        child: const Icon(Icons.movie, color: Colors.grey),
                      ),
              ),
              const SizedBox(width: 12),
              // Info
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      userMedia.title ?? 'Unknown',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 8),
                    // Status chip
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: _getStatusColor(userMedia.watchStatus).withOpacity(0.2),
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: _getStatusColor(userMedia.watchStatus)),
                      ),
                      child: Text(
                        _getStatusLabel(userMedia.watchStatus),
                        style: TextStyle(
                          color: _getStatusColor(userMedia.watchStatus),
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    if (userMedia.myRating != null) ...[
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          const Icon(Icons.star, color: Colors.amber, size: 16),
                          const SizedBox(width: 4),
                          Text(
                            userMedia.myRating!.toStringAsFixed(1),
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ],
                    if (userMedia.myReview != null && userMedia.myReview!.isNotEmpty) ...[
                      const SizedBox(height: 8),
                      Text(
                        userMedia.myReview!,
                        style: TextStyle(
                          color: Colors.grey.shade400,
                          fontSize: 13,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ],
                ),
              ),
              // Delete button
              IconButton(
                icon: const Icon(Icons.delete_outline, color: Colors.red),
                onPressed: () => _showDeleteDialog(context, userMedia),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Color _getStatusColor(WatchStatus status) {
    switch (status) {
      case WatchStatus.toWatch:
        return Colors.blue;
      case WatchStatus.watching:
        return Colors.orange;
      case WatchStatus.watched:
        return Colors.green;
    }
  }

  String _getStatusLabel(WatchStatus status) {
    switch (status) {
      case WatchStatus.toWatch:
        return 'À voir';
      case WatchStatus.watching:
        return 'En cours';
      case WatchStatus.watched:
        return 'Vu';
    }
  }

  Future<void> _showDeleteDialog(BuildContext context, UserMedia userMedia) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.grey.shade900,
        title: const Text(
          'Supprimer',
          style: TextStyle(color: Colors.white),
        ),
        content: Text(
          'Voulez-vous vraiment supprimer "${userMedia.title}" de votre liste ?',
          style: TextStyle(color: Colors.grey.shade300),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text(
              'Annuler',
              style: TextStyle(color: Colors.grey.shade400),
            ),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text(
              'Supprimer',
              style: TextStyle(color: Colors.red),
            ),
          ),
        ],
      ),
    );

    if (confirmed == true && mounted) {
      final success = await ref
          .read(myListViewModelProvider.notifier)
          .deleteMedia(userMedia.mediaId, userMedia.mediaType);

      if (success && mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text('Supprimé de votre liste'),
            backgroundColor: Colors.green.shade700,
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    }
  }
}
