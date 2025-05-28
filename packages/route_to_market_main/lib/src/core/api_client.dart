import 'dart:convert';
import 'package:http/http.dart' as http;
import 'exceptions.dart';

class ApiClient {
  final http.Client _client;
  final String _baseUrl;
  final Map<String, String> _headers;

  ApiClient({
    required http.Client client,
    required String baseUrl,
    required Map<String, String> headers,
  })  : _client = client,
        _baseUrl = baseUrl,
        _headers = headers;

  Future<http.Response> get(String path, {Map<String, String>? queryParams}) {
    final uri = Uri.parse('$_baseUrl$path').replace(queryParameters: queryParams);
    return _safeRequest(() => _client.get(uri, headers: _headers));
  }

  Future<http.Response> post(String path, {Object? body}) {
    final uri = Uri.parse('$_baseUrl$path');
    return _safeRequest(() => _client.post(uri, headers: _headers, body: jsonEncode(body)));
  }

  Future<http.Response> put(String path, {Object? body}) {
    final uri = Uri.parse('$_baseUrl$path');
    return _safeRequest(() => _client.put(uri, headers: _headers, body: jsonEncode(body)));
  }

  Future<http.Response> delete(String path) {
    final uri = Uri.parse('$_baseUrl$path');
    return _safeRequest(() => _client.delete(uri, headers: _headers));
  }

  Future<http.Response> _safeRequest(Future<http.Response> Function() request) async {
    try {
      final response = await request();

      if (response.statusCode >= 200 && response.statusCode < 300) {
        return response;
      } else if (response.statusCode == 404) {
        throw NotFoundException();
      } else {
        throw ApiException(response.body, statusCode: response.statusCode);
      }
    } on http.ClientException catch (e) {
      throw NetworkException(e.message);
    } catch (e, s) {
      throw AppException('Unexpected error: $e', s);
    }
  }
}
