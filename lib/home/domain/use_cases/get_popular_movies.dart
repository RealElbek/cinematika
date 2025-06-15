import '../entities/movie_entity.dart';
import '../repositories/movie_repository.dart';

class GetPopularMovies {
  final MovieRepository _repository;

  GetPopularMovies(this._repository);

  Future<List<MovieEntity>> execute() async {
    return await _repository.getPopularMovies();
  }
}