
import '../../../domain/entities/trailer_entity.dart';

class TrailerModel {
  final String key;
  final String name;
  final String site;

  TrailerModel({required this.key, required this.name, required this.site});

  factory TrailerModel.fromJson(Map<String, dynamic> json) {
    return TrailerModel(
      key: json['key'],
      name: json['name'],
      site: json['site'],
    );
  }

  TrailerEntity toEntity() {
    return TrailerEntity(key: key, name: name, site: site);
  }
}