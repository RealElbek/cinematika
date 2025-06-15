import '../entities/trailer_entity.dart';
import '../repositories/movie_repository.dart';

class GetMovieTrailers {
  final MovieDetailRepository _repository;

  GetMovieTrailers(this._repository);

  Future<List<TrailerEntity>> execute(int movieId) async {
    return await _repository.getMovieTrailers(movieId);
  }
}