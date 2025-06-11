import 'package:rick_and_morty_app/data/models/character_model.dart';
import 'package:rick_and_morty_app/data/models/info_model.dart';

class CharacterResponseModel {
  final InfoModel info;
  final List<CharacterModel> characters;

  CharacterResponseModel({required this.info, required this.characters});

  factory CharacterResponseModel.fromJson(Map<String, dynamic> json) {
    return CharacterResponseModel(
      info: InfoModel.fromJson(json['info']),
      characters: _getCharactersFromApiResponse(json['results']),
    );
  }

  static List<CharacterModel> _getCharactersFromApiResponse(
    List<dynamic> rawList,
  ) {
    List<CharacterModel> characters = [];

    for (Map<String, dynamic> json in rawList) {
      characters.add(CharacterModel.fromJson(json));
    }

    return characters;
  }
}
