import 'package:rick_and_morty_app/data/models/character_model.dart';
import 'package:rick_and_morty_app/data/services/character_service.dart';

class CharacterRepository {
  final CharacterService _characterService = CharacterService();

  Future<List<CharacterModel>> getCharactersByName({String? name}) async {
    final rawList = await _characterService.getCharactersByName(name);

    List<CharacterModel> characterList = [];

    for (Map<String, dynamic> json in rawList) {
      CharacterModel character = CharacterModel.fromJson(json);
      characterList.add(character);
    }

    return characterList;
  }
}
