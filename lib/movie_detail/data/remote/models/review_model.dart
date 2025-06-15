import '../../../domain/entities/review_entity.dart';
import 'auth_detail_model.dart';

class ReviewModel {
  final String author;
  final String content;
  final String createdAt;
  final AuthorDetailsModel? authorDetails;

  ReviewModel({
    required this.author,
    required this.content,
    required this.createdAt,
    this.authorDetails,
  });

  factory ReviewModel.fromJson(Map<String, dynamic> json) {
    return ReviewModel(
      author: json['author'],
      content: json['content'],
      createdAt: json['created_at'],
      authorDetails: json['author_details'] != null
          ? AuthorDetailsModel.fromJson(json['author_details'])
          : null,
    );
  }

  ReviewEntity toEntity() {
    return ReviewEntity(
      author: author,
      content: content,
      createdAt: createdAt,
      authorDetails: authorDetails!.toEntity(),
    );
  }
}
