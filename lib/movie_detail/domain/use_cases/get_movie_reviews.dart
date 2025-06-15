import '../entities/review_entity.dart';
import '../repositories/movie_repository.dart';

class GetMovieReviews {
  final MovieDetailRepository _repository;

  GetMovieReviews(this._repository);

  Future<List<ReviewEntity>> execute(int movieId) async {
    return await _repository.getMovieReviews(movieId);
  }
}