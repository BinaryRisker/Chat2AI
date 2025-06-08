import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:chat2ai/stores/theme_store.dart';
import 'package:chat2ai/routes.dart';
import 'package:chat2ai/themes.dart';

class Chat2AIApp extends ConsumerWidget {
  const Chat2AIApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // We get the router from the provider
    final routerConfig = ref.watch(routerProvider);
    // For simplicity, I'm removing the theme logic for now to ensure compilation.
    // We can re-add it after the main errors are fixed.

    return MaterialApp.router(
      title: 'Chat2AI',
      debugShowCheckedModeBanner: false,
      theme: lightTheme, // Using light theme directly
      darkTheme: darkTheme,
      themeMode: ThemeMode.system, // Using system theme directly
      routerConfig: routerConfig,
    );
  }
}