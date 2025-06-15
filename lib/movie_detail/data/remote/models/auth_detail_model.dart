import '../../../domain/entities/review_entity.dart';

class AuthorDetailsModel {
  final String name;
  final String username;
  final String? avatarPath;
  final double? rating;

  AuthorDetailsModel({
    required this.name,
    required this.username,
    this.avatarPath,
    this.rating,
  });

  factory AuthorDetailsModel.fromJson(Map<String, dynamic> json) {
    return AuthorDetailsModel(
      name: json['name'] ?? '',
      username: json['username'] ?? '',
      avatarPath: json['avatar_path'],
      rating: (json['rating'] != null) ? (json['rating'] as num).toDouble() : null,
    );
  }

  AuthorDetailsEntity toEntity() {
    return AuthorDetailsEntity(
      name: name,
      username: username,
      avatarPath: avatarPath,
      rating: rating,
    );
  }
}
