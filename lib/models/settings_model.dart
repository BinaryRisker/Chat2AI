class AppSettings {
  final String theme;
  final String language;
  final bool darkMode;
  final bool notificationsEnabled;
  final bool analyticsEnabled;

  AppSettings({
    required this.theme,
    required this.language,
    required this.darkMode,
    required this.notificationsEnabled,
    required this.analyticsEnabled,
  });

  factory AppSettings.fromJson(Map<String, dynamic> json) {
    return AppSettings(
      theme: json['theme'],
      language: json['language'],
      darkMode: json['darkMode'],
      notificationsEnabled: json['notificationsEnabled'],
      analyticsEnabled: json['analyticsEnabled'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'theme': theme,
      'language': language,
      'darkMode': darkMode,
      'notificationsEnabled': notificationsEnabled,
      'analyticsEnabled': analyticsEnabled,
    };
  }
}

class ModelSettings {
  final String defaultModel;
  final double temperature;
  final int maxTokens;
  final double topP;
  final double frequencyPenalty;
  final double presencePenalty;

  ModelSettings({
    required this.defaultModel,
    required this.temperature,
    required this.maxTokens,
    required this.topP,
    required this.frequencyPenalty,
    required this.presencePenalty,
  });

  factory ModelSettings.fromJson(Map<String, dynamic> json) {
    return ModelSettings(
      defaultModel: json['defaultModel'],
      temperature: json['temperature']?.toDouble() ?? 0.7,
      maxTokens: json['maxTokens'] ?? 1000,
      topP: json['topP']?.toDouble() ?? 1.0,
      frequencyPenalty: json['frequencyPenalty']?.toDouble() ?? 0.0,
      presencePenalty: json['presencePenalty']?.toDouble() ?? 0.0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'defaultModel': defaultModel,
      'temperature': temperature,
      'maxTokens': maxTokens,
      'topP': topP,
      'frequencyPenalty': frequencyPenalty,
      'presencePenalty': presencePenalty,
    };
  }
}