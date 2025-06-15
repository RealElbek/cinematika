import '../entities/movie_entity.dart';
import '../repositories/movie_repository.dart';

class GetNowPlayingMovies {
  final MovieRepository _repository;

  GetNowPlayingMovies(this._repository);

  Future<List<MovieEntity>> execute() async {
    return await _repository.getNowPlayingMovies();
  }
}