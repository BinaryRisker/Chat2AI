import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:chat2ai/app.dart';

void main() {
  runApp(
    const ProviderScope(
      child: Chat2AIApp(),
    ),
  );
}