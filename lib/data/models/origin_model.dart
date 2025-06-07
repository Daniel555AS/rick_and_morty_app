class OriginModel {
  final String name;
  final String url;

  OriginModel({required this.name, required this.url});

  factory OriginModel.fromJson(Map<String, dynamic> json) {
    return OriginModel(name: json['name'], url: json['url']);
  }
}
