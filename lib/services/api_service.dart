import 'dart:math';
import 'package:dio/dio.dart';
import 'package:chat2ai/stores/user_store.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:chat2ai/config.dart';
import 'package:chat2ai/models/user_model.dart';

final apiServiceProvider = Provider<ApiService>((ref) => ApiService(ref));

class ApiService {
  final Ref _ref;
  late final Dio _dio;

  ApiService(this._ref) {
    final options = BaseOptions(
      baseUrl: baseUrl,
      connectTimeout: const Duration(seconds: 5),
      receiveTimeout: const Duration(seconds: 3),
    );
    
    _dio = Dio(options);
    _dio.interceptors.add(_createAuthInterceptor());
  }

  Interceptor _createAuthInterceptor() {
    return InterceptorsWrapper(
      onRequest: (options, handler) {
        final user = _ref.read(userNotifierProvider).valueOrNull;
        final traceId = DateTime.now().millisecondsSinceEpoch.toRadixString(36) +
            '_' +
            _generateRandomString(8);

        options.headers['Content-Type'] = 'application/json';
        options.headers['X-Trace-ID'] = traceId;
        // Assuming the token is part of the User model, or you'd get it from a secure storage
        // if (user != null && user.token.isNotEmpty) {
        //   options.headers['Authorization'] = 'Bearer ${user.token}';
        // }
        
        return handler.next(options);
      },
    );
  }

  Future<Response> get(String path, {Map<String, dynamic>? queryParameters}) async {
    return _dio.get(path, queryParameters: queryParameters);
  }

  Future<Response> post(String path, {dynamic data}) async {
    return _dio.post(path, data: data);
  }
  
  String _generateRandomString(int length) {
    const chars = 'abcdefghijklmnopqrstuvwxyz0123456789';
    final random = Random();
    return String.fromCharCodes(Iterable.generate(
      length, (_) => chars.codeUnitAt(random.nextInt(chars.length))));
  }

  Future<Map<String, dynamic>> login(String email, String password) async {
    final response = await _dio.post('/auth/login', data: {
      'email': email,
      'password': password,
    });
    return response.data;
  }

  Future<Map<String, dynamic>> register(String name, String email, String password) async {
    final response = await _dio.post('/auth/register', data: {
      'name': name,
      'email': email,
      'password': password,
    });
    return response.data;
  }

  // Chat methods
  Future<List<dynamic>> getConversations() async {
    final response = await _dio.get('/chat');
    return response.data;
  }

  Future<Map<String, dynamic>> createConversation(String title) async {
    final response = await _dio.post('/chat', data: {'title': title});
    return response.data;
  }

  Future<Map<String, dynamic>> sendMessage(String conversationId, String content) async {
    final response = await _dio.post('/chat/$conversationId/messages', data: {'content': content});
    return response.data;
  }

  Future<User?> checkLoginStatus() async {
    // TODO: Implement actual token check against a backend endpoint
    // For now, assume no user is logged in on startup.
    return null;
  }
}