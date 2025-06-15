import 'package:dio/dio.dart';
import '../models/movie_detail_model.dart';
import '../models/tv_detail_model.dart';
import '../models/trailer_model.dart';
import '../models/review_model.dart';

abstract class RemoteMovieDetailDataSource {
  Future<MovieDetailModel> getMovieDetails(int movieId);
  Future<TvDetailModel> getTvDetails(int tvId);
  Future<List<TrailerModel>> getMovieTrailers(int movieId);
  Future<List<ReviewModel>> getMovieReviews(int movieId);
}

class RemoteMovieDetailDataSourceImpl implements RemoteMovieDetailDataSource {
  final Dio _dio;

  RemoteMovieDetailDataSourceImpl(this._dio);

  @override
  Future<MovieDetailModel> getMovieDetails(int movieId) async {
    final response = await _dio.get('/movie/$movieId');
    return MovieDetailModel.fromJson(response.data);
  }

  @override
  Future<TvDetailModel> getTvDetails(int tvId) async {
    final response = await _dio.get('/tv/$tvId');
    return TvDetailModel.fromJson(response.data);
  }

  @override
  Future<List<TrailerModel>> getMovieTrailers(int movieId) async {
    final response = await _dio.get('/movie/$movieId/videos');
    final results = (response.data['results'] as List)
        .map((json) => TrailerModel.fromJson(json))
        .toList();
    return results;
  }

  @override
  Future<List<ReviewModel>> getMovieReviews(int movieId) async {
    final response = await _dio.get('/movie/$movieId/reviews');
    final results = (response.data['results'] as List)
        .map((json) => ReviewModel.fromJson(json))
        .toList();
    return results;
  }
}