import 'package:rick_and_morty_app/core/network/api_client.dart';

class CharacterService {
  final ApiClient _apiClient = ApiClient();

  Future<List<Map<String, dynamic>>> getCharactersByName(String? name) async {
    String endpoint = "character";

    if (name != null && name.isNotEmpty) {
      endpoint += "?name=$name";
    }

    final data = await _apiClient.get(endpoint);

    return List<Map<String, dynamic>>.from(data['results']);
  }
}
