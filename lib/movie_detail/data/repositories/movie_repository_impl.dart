
import '../../domain/entities/movie_detail_entity.dart';
import '../../domain/entities/tv_detail_entity.dart';
import '../../domain/entities/trailer_entity.dart';
import '../../domain/entities/review_entity.dart';
import '../../domain/repositories/movie_repository.dart';
import '../remote/data_sources/remote_movie_data_source.dart';

class MovieDetailRepositoryImpl implements MovieDetailRepository {
  final RemoteMovieDetailDataSource _dataSource;

  MovieDetailRepositoryImpl(this._dataSource);

  @override
  Future<MovieDetailEntity> getMovieDetails(int movieId) async {
    try {
      final movieModel = await _dataSource.getMovieDetails(movieId);
      return movieModel.toEntity();
    } catch (e) {
      throw Exception('Failed to load movie details: $e');
    }
  }

  @override
  Future<TvDetailEntity> getTvDetails(int tvId) async {
    try {
      final tvModel = await _dataSource.getTvDetails(tvId);
      return tvModel.toEntity();
    } catch (e) {
      throw Exception('Failed to load TV details: $e');
    }
  }

  @override
  Future<List<TrailerEntity>> getMovieTrailers(int movieId) async {
    try {
      final trailers = await _dataSource.getMovieTrailers(movieId);
      return trailers.map((model) => model.toEntity()).toList();
    } catch (e) {
      throw Exception('Failed to load movie trailers: $e');
    }
  }

  @override
  Future<List<ReviewEntity>> getMovieReviews(int movieId) async {
    try {
      final reviews = await _dataSource.getMovieReviews(movieId);
      return reviews.map((model) => model.toEntity()).toList();
    } catch (e) {
      throw Exception('Failed to load movie reviews: $e');
    }
  }
}