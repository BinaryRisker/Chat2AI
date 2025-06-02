import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:chat2ai/models/settings_model.dart';
import 'api_service.dart';

class SettingsService {
  final ApiService _apiService;

  SettingsService(this._apiService);

  Future<AppSettings> getAppSettings() async {
    final response = await _apiService.get('/settings/app');
    return AppSettings.fromJson(response.data);
  }

  Future<AppSettings> updateAppSettings(AppSettings settings) async {
    final response = await _apiService.put(
      '/settings/app',
      data: settings.toJson(),
    );
    return AppSettings.fromJson(response.data);
  }

  Future<ModelSettings> getModelSettings() async {
    final response = await _apiService.get('/settings/model');
    return ModelSettings.fromJson(response.data);
  }

  Future<ModelSettings> updateModelSettings(ModelSettings settings) async {
    final response = await _apiService.put(
      '/settings/model',
      data: settings.toJson(),
    );
    return ModelSettings.fromJson(response.data);
  }
}

final settingsServiceProvider = Provider<SettingsService>((ref) {
  final apiService = ref.read(apiServiceProvider);
  return SettingsService(apiService);
});