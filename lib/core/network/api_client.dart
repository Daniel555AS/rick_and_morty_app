import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:rick_and_morty_app/core/exceptions/api_exception.dart';

class ApiClient {
  final String _baseURL = "https://rickandmortyapi.com/api";

  Future<dynamic> get(String endpoint) async {
    final response = await http.get(Uri.parse("$_baseURL/$endpoint"));

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw ApiException('${response.statusCode}: ${response.reasonPhrase}');
    }
  }
}
