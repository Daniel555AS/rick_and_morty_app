class LocationCharacterModel {
  final String name;
  final String url;

  LocationCharacterModel({required this.name, required this.url});

  factory LocationCharacterModel.fromJson(Map<String, dynamic> json) {
    return LocationCharacterModel(name: json['name'], url: json['url']);
  }
}
