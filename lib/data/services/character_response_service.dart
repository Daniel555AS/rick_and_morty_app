import 'package:rick_and_morty_app/core/network/api_client.dart';
import 'package:rick_and_morty_app/data/models/character_response_model.dart';

class CharacterResponseService {
  final ApiClient _apiClient = ApiClient();

  Future<CharacterResponseModel> getCharacterResponseModelByNameAndPage({
    String? name,
    int? page = 1,
  }) async {
    String endpoint = "character?page=$page";

    if (name != null && name.isNotEmpty) {
      endpoint += "&name=$name";
    }

    final response = await _apiClient.get(endpoint);

    return CharacterResponseModel.fromJson(response);
  }
}
