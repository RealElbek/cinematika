import '../../domain/entities/movie_detail_entity.dart';
import '../../domain/entities/review_entity.dart';
import '../../domain/entities/trailer_entity.dart';
import '../../domain/entities/tv_detail_entity.dart';

abstract class MovieDetailState {}

class MovieDetailInitial extends MovieDetailState {}

class MovieDetailLoading extends MovieDetailState {}

class MovieDetailLoaded extends MovieDetailState {
  final MovieDetailEntity? movie;
  final TvDetailEntity? tv;
  final List<TrailerEntity> trailers;
  final List<ReviewEntity> reviews;

  MovieDetailLoaded({
    this.movie,
    this.tv,
    required this.trailers,
    required this.reviews,
  });
}

class MovieDetailError extends MovieDetailState {
  final String message;

  MovieDetailError(this.message);
}