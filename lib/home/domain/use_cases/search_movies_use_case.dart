import '../entities/movie_entity.dart';
import '../repositories/movie_repository.dart';

class SearchMoviesUseCase {
  final MovieRepository _repository;

  SearchMoviesUseCase(this._repository);

  Future<List<MovieEntity>> execute(String query) async {
    return await _repository.searchMovies(query);
  }
}