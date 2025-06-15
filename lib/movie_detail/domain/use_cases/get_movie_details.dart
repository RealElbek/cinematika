import '../entities/movie_detail_entity.dart';
import '../repositories/movie_repository.dart';

class GetMovieDetails {
  final MovieDetailRepository _repository;

  GetMovieDetails(this._repository);

  Future<MovieDetailEntity> execute(int movieId) async {
    return await _repository.getMovieDetails(movieId);
  }
}