import 'package:rick_and_morty_app/data/models/location_character_model.dart';
import 'package:rick_and_morty_app/data/models/origin_model.dart';

class CharacterModel {
  final String name;
  final String status;
  final String species;
  final String type;
  final String gender;
  final OriginModel origin;
  final LocationCharacterModel location;
  final String image;
  final List<String> episode;
  final String url;
  final String created;

  CharacterModel({
    required this.name,
    required this.status,
    required this.species,
    required this.type,
    required this.gender,
    required this.origin,
    required this.location,
    required this.image,
    required this.episode,
    required this.url,
    required this.created,
  });

  factory CharacterModel.fromJson(Map<String, dynamic> json) {
    return CharacterModel(
      name: json['name'],
      status: json['status'],
      species: json['species'],
      type: json['type'],
      gender: json['gender'],
      origin: OriginModel.fromJson(json['origin']),
      location: LocationCharacterModel.fromJson(json['location']),
      image: json['image'],
      episode: List<String>.from(json['episode']),
      url: json['url'],
      created: json['created'],
    );
  }
}
