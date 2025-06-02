import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:chat2ai/stores/user_store.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ApiService {
  final String baseUrl;
  final Ref ref;

  ApiService(this.baseUrl, this.ref);

  Future<http.Response> get(String path, {Map<String, String>? headers}) async {
    final userState = ref.read(userStoreProvider);
    final traceId = DateTime.now().millisecondsSinceEpoch.toRadixString(36) + 
        '_' + _generateRandomString(8);
    
    final defaultHeaders = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${userState.token}',
      'X-Trace-ID': traceId,
    };
    
    if (headers != null) {
      defaultHeaders.addAll(headers);
    }
    
    return http.get(
      Uri.parse('$baseUrl$path'),
      headers: defaultHeaders,
    );
  }

  Future<http.Response> post(String path, 
      {Map<String, dynamic>? body, Map<String, String>? headers}) async {
    final userState = ref.read(userStoreProvider);
    final traceId = DateTime.now().millisecondsSinceEpoch.toRadixString(36) + 
        '_' + _generateRandomString(8);
    
    final defaultHeaders = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${userState.token}',
      'X-Trace-ID': traceId,
    };
    
    if (headers != null) {
      defaultHeaders.addAll(headers);
    }
    
    return http.post(
      Uri.parse('$baseUrl$path'),
      headers: defaultHeaders,
      body: jsonEncode(body),
    );
  }

  String _generateRandomString(int length) {
    const chars = 'abcdefghijklmnopqrstuvwxyz0123456789';
    final random = Random();
    return String.fromCharCodes(Iterable.generate(
      length, (_) => chars.codeUnitAt(random.nextInt(chars.length))));
  }
}