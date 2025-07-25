import 'dart:convert';
import 'dart:io';

import 'package:app_riderguard/core/networks/api_endpoints.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ApiBase {
  final String baseUrl = ApiEndpoints.baseUrl;

  Future<Map<String, String>> _getHeaders({bool withAuth = true}) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token') ?? '';

    final headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };

    if (withAuth && token.isNotEmpty) {
      headers['Authorization'] = 'Bearer $token';
    }

    return headers;
  }

  Future<dynamic> get(String endpoint, {bool withAuth = true}) async {
    final headers = await _getHeaders(withAuth: withAuth);
    final response =
        await http.get(Uri.parse('$baseUrl$endpoint'), headers: headers);

    return _decodeResponse(response);
  }

  Future<dynamic> post(
    String endpoint,
    Map<String, dynamic> body, {
    bool withAuth = true,
  }) async {
    final headers = await _getHeaders(withAuth: withAuth);
    final response = await http.post(
      Uri.parse('$baseUrl$endpoint'),
      headers: headers,
      body: jsonEncode(body),
    );

    return _decodeResponse(response);
  }

  Future<dynamic> put(
    String endpoint,
    Map<String, dynamic> body, {
    bool withAuth = true,
  }) async {
    final headers = await _getHeaders(withAuth: withAuth);
    final response = await http.put(
      Uri.parse('$baseUrl$endpoint'),
      headers: headers,
      body: jsonEncode(body),
    );

    return _decodeResponse(response);
  }

  Future<dynamic> patch(
    String endpoint,
    Map<String, dynamic> body, {
    bool withAuth = true,
  }) async {
    final headers = await _getHeaders(withAuth: withAuth);
    final response = await http.patch(
      Uri.parse('$baseUrl$endpoint'),
      headers: headers,
      body: jsonEncode(body),
    );

    return _decodeResponse(response);
  }

  Future<dynamic> delete(
    String endpoint, {
    Map<String, dynamic>? body,
    bool withAuth = true,
  }) async {
    final headers = await _getHeaders(withAuth: withAuth);
    final response = await http.delete(
      Uri.parse('$baseUrl$endpoint'),
      headers: headers,
      body: body != null ? jsonEncode(body) : null,
    );

    return _decodeResponse(response);
  }

  Future<http.StreamedResponse> postMultipart(
    String endpoint,
    Map<String, String> fields,
    File? file, {
    bool withAuth = true,
    String fileField = 'file',
  }) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token') ?? '';

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

    return await request.send();
  }

  Future<dynamic> _decodeResponse(http.Response response) async {
    if (response.statusCode == 401) {
      await _clearSession();
      throw Exception('Unauthorized. Please login again.');
    }

    if (response.statusCode >= 400) {
      throw Exception(
        'Error ${response.statusCode}: ${response.reasonPhrase}\n${response.body}',
      );
    }

    try {
      return jsonDecode(response.body);
    } catch (e) {
      throw Exception('Failed to decode JSON: ${response.body}');
    }
  }

  Future<void> _clearSession() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }
}
