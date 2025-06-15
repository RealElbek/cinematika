import 'package:equatable/equatable.dart';
class MovieEntity extends Equatable {
  final int id;
  final String title;
  final String posterPath;
  final List<int> genreIds;
  final String overview;
  final double voteAverage;
  MovieEntity({
    required this.id,
    required this.title,
    required this.posterPath,
    required this.genreIds,
    required this.overview,
    required this.voteAverage,
  });
  @override
  List<Object?> get props => [id, title, posterPath, genreIds, overview, voteAverage];
}