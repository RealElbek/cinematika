
abstract class MovieDetailEvent {}

class FetchMovieDetails extends MovieDetailEvent {
  final int movieId;

  FetchMovieDetails(this.movieId);
}

class FetchTvDetails extends MovieDetailEvent {
  final int tvId;

  FetchTvDetails(this.tvId);
}