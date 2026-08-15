import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiClient {
  static const String baseUrl = "http://localhost:3000";

  Future<dynamic> getData(String endpoint) async {
    try {
      final response = await http.get(Uri.parse('$baseUrl$endpoint'));

      return _handleResponse(response);
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<dynamic> postData(String endpoint, Map<String, dynamic> body) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl$endpoint'),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(body),
      );

      return _handleResponse(response);
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  dynamic _handleResponse(http.Response response) {
    final data = jsonDecode(response.body);

    if (response.statusCode >= 200 && response.statusCode < 300) {
      return data;
    }

    throw Exception(data["message"] ?? "Something went wrong");
  }
}
