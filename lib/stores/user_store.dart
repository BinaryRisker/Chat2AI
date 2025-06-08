import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:chat2ai/models/user_model.dart';
import 'package:chat2ai/services/api_service.dart';

// The state of our notifier is the User object itself, or null if not authenticated.
// AsyncValue will handle loading and error states for us.
class UserNotifier extends AsyncNotifier<User?> {
  
  late ApiService _apiService;

  @override
  Future<User?> build() async {
    _apiService = ref.read(apiServiceProvider);
    // Here you could auto-login the user from a saved token
    return null;
  }

  Future<void> login(String email, String password) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final response = await _apiService.login(email, password);
      final user = User.fromJson(response['user']);
      // Here you would save the token: response['token']
      return user.copyWith(token: response['token']);
    });
  }
  
  Future<void> register(String name, String email, String password) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final response = await _apiService.register(name, email, password);
      final user = User.fromJson(response['user']);
      // Here you would save the token: response['token']
      return user.copyWith(token: response['token']);
    });
  }

  Future<void> logout() async {
    state = const AsyncValue.data(null);
    // Here you would also clear any saved tokens
  }
}

final userNotifierProvider = AsyncNotifierProvider<UserNotifier, User?>(
  () => UserNotifier(),
);