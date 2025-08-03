import 'dart:convert';
import 'dart:io';
import 'package:app_riderguard/core/utils/logger.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:app_riderguard/core/networks/api_endpoints.dart';

class ApiBase {
  final String baseUrl = ApiEndpoints.baseUrl;

  Future<Map<String, String>> _getHeaders({bool withAuth = true}) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('accessToken') ?? '';

    final headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };

    if (withAuth && token.isNotEmpty) {
      headers['Authorization'] = 'Bearer $token';
    }

    return headers;
  }

  String _asJsonString(dynamic data) {
    try {
      return const JsonEncoder.withIndent('  ').convert(data);
    } catch (_) {
      return data.toString();
    }
  }

  Map<String, dynamic> _sanitizeSensitive(Map<String, dynamic> data) {
    final Map<String, dynamic> copy = Map.from(data);
    const sensitiveKeys = ['password', 'pass', 'old_password', 'new_password'];

    for (final key in sensitiveKeys) {
      if (copy.containsKey(key)) {
        copy[key] = '****';
      }
    }

    return copy;
  }

  void _logApiCall({
    required String method,
    required String url,
    required Map<String, String> headers,
    dynamic requestBody,
    int? statusCode,
    dynamic responseBody,
  }) {
    final buffer = StringBuffer();
    final sanitizedHeaders = Map<String, String>.from(headers);
    if (sanitizedHeaders.containsKey('Authorization')) {
      sanitizedHeaders['Authorization'] = '[REDACTED]';
    }

    buffer.writeln('📡 [$method] $url');
    buffer.writeln('🧾 Headers: ${_asJsonString(sanitizedHeaders)}');

    if (requestBody != null) {
      if (requestBody is Map<String, dynamic>) {
        buffer.writeln(
            '📦 Request Body: ${_asJsonString(_sanitizeSensitive(requestBody))}');
      } else {
        buffer.writeln('📦 Request Body: ${_asJsonString(requestBody)}');
      }
    }

    if (statusCode != null) {
      buffer.writeln('✅ Response [$statusCode]');
    }

    if (responseBody != null) {
      buffer.writeln('📬 Response Body: ${_asJsonString(responseBody)}');
    }

    logger.i(buffer.toString());
  }

  Future<Map<String, dynamic>?> _tryDecode(String body) async {
    try {
      return jsonDecode(body);
    } catch (_) {
      return null;
    }
  }

  Future<dynamic> _handleResponse(
      http.Response response, Map<String, dynamic>? parsedBody) async {
    if (response.statusCode == 401) {
      await _clearSession();
      throw ApiException('Unauthorized. Please login again.',
          responseBody: parsedBody);
    }

    if (response.statusCode >= 400) {
      final errorMsg = parsedBody?['message'] ??
          'Error ${response.statusCode}: ${response.reasonPhrase}';
      throw ApiException(errorMsg, responseBody: parsedBody);
    }

    return parsedBody;
  }

  Future<void> _clearSession() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }

  Future<dynamic> get(String endpoint, {bool withAuth = true}) async {
    final headers = await _getHeaders(withAuth: withAuth);
    final url = '$baseUrl$endpoint';
    final response = await http.get(Uri.parse(url), headers: headers);
    final parsed = await _tryDecode(response.body);

    _logApiCall(
      method: 'GET',
      url: url,
      headers: headers,
      statusCode: response.statusCode,
      responseBody: parsed,
    );

    return _handleResponse(response, parsed);
  }

  Future<dynamic> post(String endpoint, Map<String, dynamic> body,
      {bool withAuth = true}) async {
    final headers = await _getHeaders(withAuth: withAuth);
    final url = '$baseUrl$endpoint';
    final response = await http.post(
      Uri.parse(url),
      headers: headers,
      body: jsonEncode(body),
    );
    final parsed = await _tryDecode(response.body);

    _logApiCall(
      method: 'POST',
      url: url,
      headers: headers,
      requestBody: body,
      statusCode: response.statusCode,
      responseBody: parsed,
    );

    return _handleResponse(response, parsed);
  }

  Future<dynamic> put(String endpoint, Map<String, dynamic> body,
      {bool withAuth = true}) async {
    final headers = await _getHeaders(withAuth: withAuth);
    final url = '$baseUrl$endpoint';
    final response = await http.put(
      Uri.parse(url),
      headers: headers,
      body: jsonEncode(body),
    );
    final parsed = await _tryDecode(response.body);

    _logApiCall(
      method: 'PUT',
      url: url,
      headers: headers,
      requestBody: body,
      statusCode: response.statusCode,
      responseBody: parsed,
    );

    return _handleResponse(response, parsed);
  }

  Future<dynamic> patch(String endpoint, Map<String, dynamic> body,
      {bool withAuth = true}) async {
    final headers = await _getHeaders(withAuth: withAuth);
    final url = '$baseUrl$endpoint';
    final response = await http.patch(
      Uri.parse(url),
      headers: headers,
      body: jsonEncode(body),
    );
    final parsed = await _tryDecode(response.body);

    _logApiCall(
      method: 'PATCH',
      url: url,
      headers: headers,
      requestBody: body,
      statusCode: response.statusCode,
      responseBody: parsed,
    );

    return _handleResponse(response, parsed);
  }

  Future<dynamic> delete(String endpoint,
      {Map<String, dynamic>? body, bool withAuth = true}) async {
    final headers = await _getHeaders(withAuth: withAuth);
    final url = '$baseUrl$endpoint';
    final response = await http.delete(
      Uri.parse(url),
      headers: headers,
      body: body != null ? jsonEncode(body) : null,
    );
    final parsed = await _tryDecode(response.body);

    _logApiCall(
      method: 'DELETE',
      url: url,
      headers: headers,
      requestBody: body,
      statusCode: response.statusCode,
      responseBody: parsed,
    );

    return _handleResponse(response, parsed);
  }

  Future<http.StreamedResponse> postMultipart(
    String endpoint,
    Map<String, String> fields,
    File? file, {
    bool withAuth = true,
    String fileField = 'file',
  }) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('accessToken') ?? '';
    final uri = Uri.parse('$baseUrl$endpoint');
    final request = http.MultipartRequest('POST', uri);

    if (withAuth && token.isNotEmpty) {
      request.headers['Authorization'] = 'Bearer $token';
    }

    request.fields.addAll(fields);

    if (file != null) {
      request.files
          .add(await http.MultipartFile.fromPath(fileField, file.path));
    }

    final sanitizedHeaders = Map<String, String>.from(request.headers);
    if (sanitizedHeaders.containsKey('Authorization')) {
      sanitizedHeaders['Authorization'] = '[REDACTED]';
    }

    final buffer = StringBuffer()
      ..writeln('📡 [POST Multipart] $uri')
      ..writeln('🧾 Headers: ${_asJsonString(sanitizedHeaders)}')
      ..writeln('📎 Fields: ${_asJsonString(_sanitizeSensitive(fields))}');

    if (file != null) {
      buffer.writeln('📂 File: ${file.path}');
    }

    logger.i(buffer.toString());
    return await request.send();
  }

  Future<http.StreamedResponse> putMultipart(
    String endpoint,
    Map<String, String> fields,
    File? file, {
    bool withAuth = true,
    String fileField = 'file',
  }) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('accessToken') ?? '';
    final uri = Uri.parse('$baseUrl$endpoint');
    final request = http.MultipartRequest('PUT', uri);

    if (withAuth && token.isNotEmpty) {
      request.headers['Authorization'] = 'Bearer $token';
    }

    request.fields.addAll(fields);

    if (file != null) {
      request.files
          .add(await http.MultipartFile.fromPath(fileField, file.path));
    }

    // Logging
    final sanitizedHeaders = Map<String, String>.from(request.headers);
    if (sanitizedHeaders.containsKey('Authorization')) {
      sanitizedHeaders['Authorization'] = '[REDACTED]';
    }

    final buffer = StringBuffer()
      ..writeln('📡 [PUT Multipart] $uri')
      ..writeln('🧾 Headers: ${_asJsonString(sanitizedHeaders)}')
      ..writeln('📎 Fields: ${_asJsonString(_sanitizeSensitive(fields))}');

    if (file != null) {
      buffer.writeln('📂 File: ${file.path}');
    }

    logger.i(buffer.toString());

    return await request.send();
  }
}

class ApiException implements Exception {
  final String message;
  final Map<String, dynamic>? responseBody;

  ApiException(this.message, {this.responseBody});

  @override
  String toString() => message;
}
