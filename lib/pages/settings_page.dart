import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:chat2ai/stores/user_store.dart';

class SettingsPage extends ConsumerWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Watching the user provider to get user info and logout method
    final userAsyncValue = ref.watch(userNotifierProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: ListView(
        children: [
          ListTile(
            title: const Text('Dark Mode'),
            trailing: Switch(
              value: false, // Disabled for now
              onChanged: (value) {
                // To be implemented by refactoring ThemeStore
              },
            ),
          ),
          const ListTile(
            title: Text('Primary Color'),
            // Color picker functionality disabled for now
          ),
          const Divider(),
          userAsyncValue.when(
            data: (user) => ListTile(
              title: Text(user?.name ?? 'Not logged in'),
              subtitle: Text(user?.email ?? ''),
            ),
            loading: () => const ListTile(title: Text('Loading...')),
            error: (e, st) => ListTile(title: Text('Error: $e')),
          ),
          ListTile(
            title: const Text('Logout'),
            leading: const Icon(Icons.exit_to_app),
            onTap: () {
              ref.read(userNotifierProvider.notifier).logout();
              // The router will automatically redirect
            },
          ),
        ],
      ),
    );
  }
}