import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../app/widgets/auth_required_dialog.dart';
import '../../../auth/presentation/providers/auth_providers.dart';
import '../../domain/entities/media.dart';
import '../../domain/entities/user_media.dart';
import '../providers/media_providers.dart';

/// Media Detail Page - Clean Architecture
/// Displays detailed information about a movie or TV show
class MediaDetailPage extends ConsumerStatefulWidget {
  final int mediaId;
  final String mediaType;

  const MediaDetailPage({
    super.key,
    required this.mediaId,
    required this.mediaType,
  });

  @override
  ConsumerState<MediaDetailPage> createState() => _MediaDetailPageState();
}

class _MediaDetailPageState extends ConsumerState<MediaDetailPage> {
  @override
  void initState() {
    super.initState();
    // Load media details on init
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final mediaKey = '${widget.mediaType}_${widget.mediaId}';
      ref
          .read(mediaDetailViewModelProvider(mediaKey).notifier)
          .loadMedia(widget.mediaId, widget.mediaType);
    });
  }

  @override
  Widget build(BuildContext context) {
    final mediaKey = '${widget.mediaType}_${widget.mediaId}';
    final state = ref.watch(mediaDetailViewModelProvider(mediaKey));

    if (state.isLoading) {
      return Scaffold(
        backgroundColor: Colors.black,
        body: const Center(
          child: CircularProgressIndicator(color: Colors.red),
        ),
      );
    }

    if (state.errorMessage != null) {
      return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Colors.black,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        body: Center(
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
      );
    }

    final media = state.media;
    if (media == null) {
      return Scaffold(
        backgroundColor: Colors.black,
        body: const Center(
          child: Text(
            'Aucune donnée disponible',
            style: TextStyle(color: Colors.white),
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: Colors.black,
      body: CustomScrollView(
        slivers: [
          _buildAppBar(context, media),
          SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildHeader(context, media),
                const SizedBox(height: 24),
                _buildSynopsis(context, media),
                const SizedBox(height: 24),
                _buildGenres(context, media),
                const SizedBox(height: 120),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: _buildActionButton(context, media, state),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  // Les méthodes de build seront ajoutées dans la prochaine partie
  Widget _buildAppBar(BuildContext context, media) {
    return SliverAppBar(
      expandedHeight: 400,
      pinned: true,
      backgroundColor: Colors.black,
      leading: Container(
        margin: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.5),
          shape: BoxShape.circle,
        ),
        child: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      flexibleSpace: FlexibleSpaceBar(
        background: Stack(
          fit: StackFit.expand,
          children: [
            if (media.backdropPath != null)
              Image.network(
                media.backdropUrl,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    color: Colors.grey.shade900,
                    child: const Icon(
                      Icons.movie_outlined,
                      size: 100,
                      color: Colors.grey,
                    ),
                  );
                },
              ),
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    Colors.black.withOpacity(0.7),
                    Colors.black,
                  ],
                  stops: const [0.0, 0.7, 1.0],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context, media) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            media.title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              if (media.releaseYear != null) ...[
                Text(
                  media.releaseYear!,
                  style: TextStyle(color: Colors.grey.shade400, fontSize: 16),
                ),
                const SizedBox(width: 16),
              ],
              if (media.voteAverage != null) ...[
                const Icon(Icons.star, color: Colors.amber, size: 20),
                const SizedBox(width: 4),
                Text(
                  media.formattedVoteAverage,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSynopsis(BuildContext context, media) {
    if (media.overview == null || media.overview!.isEmpty) {
      return const SizedBox.shrink();
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Synopsis',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            media.overview!,
            style: TextStyle(
              color: Colors.grey.shade300,
              fontSize: 15,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGenres(BuildContext context, media) {
    if (media.genres == null || media.genres!.isEmpty) {
      return const SizedBox.shrink();
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Genres',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: media.genres!.map<Widget>((genre) {
              return Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.red.shade600.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: Colors.red.shade600),
                ),
                child: Text(
                  genre.name,
                  style: TextStyle(
                    color: Colors.red.shade400,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton(BuildContext context, media, state) {
    final isInList = state.userMedia != null;

    return Container(
      width: MediaQuery.of(context).size.width - 32,
      height: 56,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.red.shade600, Colors.red.shade800],
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.red.withOpacity(0.4),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: state.isSaving
              ? null
              : () {
                  if (isInList) {
                    _showManageModal(context, media, state);
                  } else {
                    // Check auth before adding to list
                    final currentUser = ref.read(currentUserProvider);
                    if (currentUser == null) {
                      AuthRequiredDialog.show(
                        context,
                        title: 'Connexion requise',
                        message: 'Connectez-vous pour ajouter ce contenu à votre liste',
                      );
                    } else {
                      _addToList(context, media);
                    }
                  }
                },
          borderRadius: BorderRadius.circular(16),
          child: Center(
            child: state.isSaving
                ? const SizedBox(
                    width: 24,
                    height: 24,
                    child: CircularProgressIndicator(
                      color: Colors.white,
                      strokeWidth: 2,
                    ),
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        isInList ? Icons.edit : Icons.add,
                        color: Colors.white,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        isInList ? 'Gérer' : 'Ajouter à ma liste',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
          ),
        ),
      ),
    );
  }

  Future<void> _addToList(BuildContext context, media) async {
    final mediaKey = '${widget.mediaType}_${widget.mediaId}';
    
    await ref.read(mediaDetailViewModelProvider(mediaKey).notifier).updateUserMedia(
      watchStatus: WatchStatus.toWatch,
    );

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Ajouté à votre liste !'),
          backgroundColor: Colors.green.shade700,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      );
    }
  }

  void _showManageModal(BuildContext context, media, state) {
    final userMedia = state.userMedia;
    if (userMedia == null) return;

    WatchStatus selectedStatus = userMedia.watchStatus;
    double selectedRating = userMedia.myRating ?? 0.0;
    final reviewController = TextEditingController(text: userMedia.myReview ?? '');

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.grey.shade900,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (modalContext) => StatefulBuilder(
        builder: (context, setState) {
          return Padding(
            padding: EdgeInsets.only(
              left: 24,
              right: 24,
              top: 24,
              bottom: MediaQuery.of(context).viewInsets.bottom + 24,
            ),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Text(
                        'Gérer',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Spacer(),
                      IconButton(
                        icon: const Icon(Icons.close, color: Colors.white),
                        onPressed: () => Navigator.pop(modalContext),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  
                  // Statut
                  Text(
                    'Statut',
                    style: TextStyle(
                      color: Colors.grey.shade400,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Wrap(
                    spacing: 8,
                    children: [
                      _buildStatusChip('À voir', WatchStatus.toWatch, selectedStatus, (status) {
                        setState(() => selectedStatus = status);
                      }),
                      _buildStatusChip('En cours', WatchStatus.watching, selectedStatus, (status) {
                        setState(() => selectedStatus = status);
                      }),
                      _buildStatusChip('Vu', WatchStatus.watched, selectedStatus, (status) {
                        setState(() => selectedStatus = status);
                      }),
                    ],
                  ),
                  const SizedBox(height: 24),
                  
                  // Note
                  Row(
                    children: [
                      Text(
                        'Ma note: ${selectedRating.toStringAsFixed(1)}',
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
                    value: selectedRating,
                    min: 0,
                    max: 10,
                    divisions: 20,
                    activeColor: Colors.amber,
                    inactiveColor: Colors.grey.shade800,
                    onChanged: (value) {
                      setState(() => selectedRating = value);
                    },
                  ),
                  const SizedBox(height: 16),
                  
                  // Avis
                  Text(
                    'Mon avis',
                    style: TextStyle(
                      color: Colors.grey.shade400,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    controller: reviewController,
                    maxLines: 4,
                    style: const TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      hintText: 'Écrivez votre avis...',
                      hintStyle: TextStyle(color: Colors.grey.shade600),
                      filled: true,
                      fillColor: Colors.grey.shade800,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  
                  // Bouton Enregistrer
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () async {
                        final mediaKey = '${widget.mediaType}_${widget.mediaId}';
                        await ref.read(mediaDetailViewModelProvider(mediaKey).notifier).updateUserMedia(
                          watchStatus: selectedStatus,
                          myRating: selectedRating > 0 ? selectedRating : null,
                          myReview: reviewController.text.isEmpty ? null : reviewController.text,
                        );
                        
                        // Reload MyList to reflect changes
                        ref.read(myListViewModelProvider.notifier).loadMediaList();
                        
                        if (context.mounted) {
                          Navigator.pop(modalContext);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: const Text('Modifications enregistrées !'),
                              backgroundColor: Colors.green.shade700,
                              behavior: SnackBarBehavior.floating,
                            ),
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red.shade600,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text(
                        'Enregistrer',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildStatusChip(String label, WatchStatus status, WatchStatus selectedStatus, Function(WatchStatus) onTap) {
    final isSelected = status == selectedStatus;
    return FilterChip(
      label: Text(label),
      selected: isSelected,
      onSelected: (_) => onTap(status),
      backgroundColor: Colors.grey.shade800,
      selectedColor: Colors.red.shade600,
      labelStyle: TextStyle(
        color: isSelected ? Colors.white : Colors.grey.shade400,
        fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
      ),
      checkmarkColor: Colors.white,
    );
  }
}
