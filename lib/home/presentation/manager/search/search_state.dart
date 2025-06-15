import '../../../domain/entities/movie_entity.dart';

abstract class SearchState {}

class SearchInitial extends SearchState {}

class SearchLoading extends SearchState {}

class SearchSuccess extends SearchState {
  final List<MovieEntity> movies;
  SearchSuccess(this.movies);
}

class SearchError extends SearchState {
  final String message;
  SearchError(this.message);
}
