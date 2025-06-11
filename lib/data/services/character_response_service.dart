import 'package:rick_and_morty_app/core/network/api_client.dart';
import 'package:rick_and_morty_app/data/models/character_response_model.dart';

class CharacterResponseService {
  final ApiClient _apiClient = ApiClient();

  Future<CharacterResponseModel> getCharacterResponseModelByName({
    String? name,
  }) async {
    String endpoint = "character";

    if (name != null && name.isNotEmpty) {
      endpoint += "?name=$name";
    }

    final responseBody = await _apiClient.get(endpoint);

    return CharacterResponseModel.fromJson(responseBody);
  }
}
