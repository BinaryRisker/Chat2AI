import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:chat2ai/pages/home_page.dart';
import 'package:chat2ai/pages/login_page.dart';
import 'package:chat2ai/pages/settings_page.dart';
import 'package:chat2ai/pages/chat_page.dart';
import 'package:chat2ai/stores/user_store.dart';

final router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const HomePage(),
      routes: [
        GoRoute(
          path: 'login',
          builder: (context, state) => const LoginPage(),
        ),
        GoRoute(
          path: 'settings',
          builder: (context, state) => const SettingsPage(),
        ),
        GoRoute(
          path: 'chat/:id',
          builder: (context, state) => ChatPage(
            conversationId: state.pathParameters['id']!,
          ),
        ),
      ],
    ),
  ],
  redirect: (BuildContext context, GoRouterState state) {
    final userState = ProviderScope.containerOf(context).read(userStoreProvider);
    
    if (!userState.isAuthenticated && state.location != '/login') {
      return '/login';
    }
    
    if (userState.isAuthenticated && state.location == '/login') {
      return '/';
    }
    
    return null;
  },
);