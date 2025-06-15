import '../../domain/entities/movie_entity.dart';

class MovieModel {
  final int id;
  final String title;
  final String posterPath;
  final List<int> genreIds;
  final String overview;
  final double voteAverage;

  MovieModel({
    required this.id,
    required this.title,
    required this.posterPath,
    required this.genreIds,
    required this.overview,
    required this.voteAverage,
  });

  factory MovieModel.fromJson(Map<String, dynamic> json) {
    return MovieModel(
      id: json['id'],
      title: json['title'],
      posterPath: json['poster_path'],
      genreIds: List<int>.from(json['genre_ids']),
      overview: json['overview'],
      voteAverage: json['vote_average'].toDouble(),
    );
  }

  MovieEntity toEntity() {
    return MovieEntity(
      id: id,
      title: title,
      posterPath: posterPath,
      genreIds: genreIds,
      overview: overview,
      voteAverage: voteAverage,
    );
  }
}