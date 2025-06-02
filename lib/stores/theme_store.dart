import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ThemeState {
  final ThemeMode themeMode;
  final Color primaryColor;

  const ThemeState({
    required this.themeMode,
    required this.primaryColor,
  });

  ThemeState copyWith({
    ThemeMode? themeMode,
    Color? primaryColor,
  }) {
    return ThemeState(
      themeMode: themeMode ?? this.themeMode,
      primaryColor: primaryColor ?? this.primaryColor,
    );
  }
}

class ThemeStore extends StateNotifier<ThemeState> {
  ThemeStore()
      : super(
          const ThemeState(
            themeMode: ThemeMode.system,
            primaryColor: Colors.blue,
          ),
        );

  void toggleTheme() {
    state = state.copyWith(
      themeMode: state.themeMode == ThemeMode.light
          ? ThemeMode.dark
          : ThemeMode.light,
    );
  }

  void changePrimaryColor(Color color) {
    state = state.copyWith(primaryColor: color);
  }
}

final themeStoreProvider = StateNotifierProvider<ThemeStore, ThemeState>(
  (ref) => ThemeStore(),
);