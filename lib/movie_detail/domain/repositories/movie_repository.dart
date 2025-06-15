import '../entities/movie_detail_entity.dart';
import '../entities/tv_detail_entity.dart';
import '../entities/trailer_entity.dart';
import '../entities/review_entity.dart';

abstract class MovieDetailRepository {
  Future<MovieDetailEntity> getMovieDetails(int movieId);
  Future<TvDetailEntity> getTvDetails(int tvId);
  Future<List<TrailerEntity>> getMovieTrailers(int movieId);
  Future<List<ReviewEntity>> getMovieReviews(int movieId);
}