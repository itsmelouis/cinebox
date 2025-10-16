import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/auth_providers.dart';

/// Home page displayed after successful authentication
class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentUser = ref.watch(currentUserProvider);
    final signOut = ref.read(signOutProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('CinéBox'),
        actions: [
          // Bouton de déconnexion
          IconButton(
            icon: const Icon(Icons.logout),
            tooltip: 'Se déconnecter',
            onPressed: () async {
              // Afficher une confirmation
              final confirm = await showDialog<bool>(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text('Déconnexion'),
                  content: const Text('Voulez-vous vraiment vous déconnecter ?'),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(false),
                      child: const Text('Annuler'),
                    ),
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(true),
                      child: const Text('Se déconnecter'),
                    ),
                  ],
                ),
              );

              if (confirm == true && context.mounted) {
                await signOut();
              }
            },
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Avatar
            CircleAvatar(
              radius: 50,
              backgroundColor: Theme.of(context).colorScheme.primaryContainer,
              child: Icon(
                Icons.person,
                size: 50,
                color: Theme.of(context).colorScheme.onPrimaryContainer,
              ),
            ),
            const SizedBox(height: 24),

            // Message de bienvenue
            Text(
              'Bienvenue !',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 8),

            // Email de l'utilisateur
            if (currentUser != null)
              Column(
                children: [
                  Text(
                    currentUser.email,
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  if (currentUser.displayName != null) ...[
                    const SizedBox(height: 4),
                    Text(
                      currentUser.displayName!,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: Theme.of(context).colorScheme.secondary,
                          ),
                    ),
                  ],
                ],
              )
            else
              const Text('Utilisateur non connecté'),
            const SizedBox(height: 48),

            // Bouton de déconnexion alternatif (plus visible)
            ElevatedButton.icon(
              onPressed: () async {
                final confirm = await showDialog<bool>(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text('Déconnexion'),
                    content: const Text('Voulez-vous vraiment vous déconnecter ?'),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.of(context).pop(false),
                        child: const Text('Annuler'),
                      ),
                      FilledButton(
                        onPressed: () => Navigator.of(context).pop(true),
                        child: const Text('Se déconnecter'),
                      ),
                    ],
                  ),
                );

                if (confirm == true && context.mounted) {
                  await signOut();
                }
              },
              icon: const Icon(Icons.logout),
              label: const Text('Se déconnecter'),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(
                  horizontal: 32,
                  vertical: 16,
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Info
            Text(
              'Le backend est prêt !',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Theme.of(context).colorScheme.secondary,
                  ),
            ),
            const SizedBox(height: 8),
            Text(
              'Votre collègue peut maintenant créer les pages UI',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Theme.of(context).colorScheme.secondary,
                  ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
