import 'package:dio/dio.dart';
import '../models/movie_model.dart';

class MovieRemoteDataSource {
  final Dio _dio;

  MovieRemoteDataSource(this._dio);

  Future<List<MovieModel>> getNowPlayingMovies() async {
    final response = await _dio.get('/movie/now_playing', queryParameters: {
      'language': 'en-US',
      'page': 1,
    });
    return (response.data['results'] as List)
        .map((json) => MovieModel.fromJson(json))
        .toList();
  }

  Future<List<MovieModel>> getPopularMovies() async {
    final response = await _dio.get('/movie/popular', queryParameters: {
      'language': 'en-US',
      'page': 2,
    });
    return (response.data['results'] as List)
        .map((json) => MovieModel.fromJson(json))
        .toList();
  }
}