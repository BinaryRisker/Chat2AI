import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:chat2ai/models/user_model.dart';
import 'api_service.dart';

class UserService {
  final ApiService _apiService;

  UserService(this._apiService);

  Future<User> getCurrentUser() async {
    final response = await _apiService.get('/users/me');
    return User.fromJson(response.data);
  }

  Future<User> updateUser(User user) async {
    final response = await _apiService.put(
      '/users/me',
      data: user.toJson(),
    );
    return User.fromJson(response.data);
  }

  Future<UserPreferences> getUserPreferences() async {
    final response = await _apiService.get('/users/me/preferences');
    return UserPreferences.fromJson(response.data);
  }

  Future<UserPreferences> updateUserPreferences(UserPreferences preferences) async {
    final response = await _apiService.put(
      '/users/me/preferences',
      data: preferences.toJson(),
    );
    return UserPreferences.fromJson(response.data);
  }

  Future<void> deleteAccount() async {
    await _apiService.delete('/users/me');
  }
}

final userServiceProvider = Provider<UserService>((ref) {
  final apiService = ref.read(apiServiceProvider);
  return UserService(apiService);
});