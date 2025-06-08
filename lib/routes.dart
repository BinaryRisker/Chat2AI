import 'dart:async';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:chat2ai/pages/home_page.dart';
import 'package:chat2ai/pages/login_page.dart';
import 'package:chat2ai/pages/settings_page.dart';
import 'package:chat2ai/pages/chat_page.dart';
import 'package:chat2ai/pages/register_page.dart';
import 'package:chat2ai/stores/user_store.dart';

// Create a provider for the router
final routerProvider = Provider<GoRouter>((ref) {
  // Watch the user provider. This will cause the router to rebuild when the state changes.
  final userAsyncValue = ref.watch(userNotifierProvider);

  return GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const HomePage(),
      ),
      GoRoute(
        path: '/login',
        builder: (context, state) => const LoginPage(),
      ),
      GoRoute(
        path: '/register',
        builder: (context, state) => const RegisterPage(),
      ),
      GoRoute(
        path: '/settings',
        builder: (context, state) => const SettingsPage(),
      ),
    ],
    // redirect: (BuildContext context, GoRouterState state) {
    //   final isAuthenticated = userAsyncValue.valueOrNull != null;
    //   final isLoggingIn = state.matchedLocation == '/login';

    //   // If the user is not authenticated and not on the login page, redirect to login.
    //   if (!isAuthenticated && !isLoggingIn) {
    //     return '/login';
    //   }
      
    //   // If the user is authenticated and on the login page, redirect to home.
    //   if (isAuthenticated && isLoggingIn) {
    //     return '/';
    //   }
      
    //   // No redirect needed.
    //   return null;
    // },
  );
});

// Helper class to make GoRouter refresh when a stream emits.
// This is not strictly necessary if the provider itself is listened to,
// but can be kept for other use cases.
class GoRouterRefreshStream extends ChangeNotifier {
  GoRouterRefreshStream(Stream<dynamic> stream) {
    notifyListeners();
    _subscription = stream.asBroadcastStream().listen((_) => notifyListeners());
  }

  late final StreamSubscription<dynamic> _subscription;

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}