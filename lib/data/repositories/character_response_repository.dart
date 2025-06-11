import 'package:rick_and_morty_app/data/models/character_response_model.dart';
import 'package:rick_and_morty_app/data/services/character_response_service.dart';

class CharacterResponseRepository {
  final CharacterResponseService _characterResponseService =
      CharacterResponseService();

  Future<CharacterResponseModel> getCharacterResponseModelByName(
    String? name,
  ) async {
    return await _characterResponseService.getCharacterResponseModelByName(
      name: name,
    );
  }
}
