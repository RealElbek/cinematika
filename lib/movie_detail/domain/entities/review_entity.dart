class AuthorDetailsEntity {
  final String name;
  final String username;
  final String? avatarPath;
  final double? rating;

  AuthorDetailsEntity({
    required this.name,
    required this.username,
    this.avatarPath,
    this.rating,
  });
}

class ReviewEntity {
  final String author;
  final String content;
  final String createdAt;
  final AuthorDetailsEntity authorDetails;

  ReviewEntity({
    required this.author,
    required this.content,
    required this.createdAt,
    required this.authorDetails,
  });
}
