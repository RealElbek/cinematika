import '../../../domain/entities/movie_entity.dart';
abstract class HomeState {}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class HomeSuccess extends HomeState {
  final List<MovieEntity> nowPlayingMovies;
  final List<MovieEntity> popularMovies;

  HomeSuccess(this.nowPlayingMovies, this.popularMovies);
}

class HomeError extends HomeState {
  final String message;

  HomeError(this.message);
}