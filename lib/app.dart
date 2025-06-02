import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:chat2ai/stores/theme_store.dart';
import 'package:chat2ai/stores/user_store.dart';
import 'package:chat2ai/routes.dart';
import 'package:chat2ai/themes.dart';

class Chat2AIApp extends ConsumerWidget {
  const Chat2AIApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeState = ref.watch(themeStoreProvider);
    final userState = ref.watch(userStoreProvider);

    return MaterialApp.router(
      title: 'Chat2AI',
      debugShowCheckedModeBanner: false,
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: themeState.themeMode,
      routerConfig: router,
    );
  }
}