// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:chat2ai/app.dart';
import 'package:chat2ai/services/api_service.dart';
import 'package:mocktail/mocktail.dart';

// Create a mock for the ApiService
class MockApiService extends Mock implements ApiService {}

void main() {
  testWidgets('App starts and shows LoginPage correctly', (WidgetTester tester) async {
    final mockApiService = MockApiService();

    // Stub all network methods that could be called during app initialization.
    when(() => mockApiService.checkLoginStatus()).thenAnswer((_) async => null);
    when(() => mockApiService.getConversations()).thenAnswer((_) async => []);

    // Build our app and trigger a frame, overriding the apiServiceProvider.
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          // Override the dependency that makes network calls
          apiServiceProvider.overrideWithValue(mockApiService),
        ],
        child: const Chat2AIApp(),
      ),
    );

    // Let the widget tree settle.
    await tester.pumpAndSettle();

    // Verify that the LoginPage is shown.
    expect(find.text('Login'), findsAtLeastNWidgets(1));
    expect(find.byType(ElevatedButton), findsOneWidget);
  });
}
