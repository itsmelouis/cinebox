import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// Dialog shown when user tries to perform an action that requires authentication
/// Uses the app's black/red theme
class AuthRequiredDialog extends StatelessWidget {
  final String title;
  final String message;

  const AuthRequiredDialog({
    this.title = 'Connexion requise',
    this.message = 'Vous devez être connecté pour effectuer cette action.',
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.grey.shade900,
      title: Text(
        title,
        style: const TextStyle(color: Colors.white),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.lock_outline,
            size: 48,
            color: Colors.red.shade600,
          ),
          const SizedBox(height: 16),
          Text(
            message,
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.grey.shade300),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(
            'Annuler',
            style: TextStyle(color: Colors.grey.shade400),
          ),
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).pop();
            context.push('/login');
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.red.shade600,
          ),
          child: const Text('Se connecter'),
        ),
      ],
    );
  }

  /// Show the auth required dialog
  static Future<void> show(
    BuildContext context, {
    String? title,
    String? message,
  }) {
    return showDialog(
      context: context,
      builder: (context) => AuthRequiredDialog(
        title: title ?? 'Connexion requise',
        message: message ?? 'Vous devez être connecté pour effectuer cette action.',
      ),
    );
  }
}
