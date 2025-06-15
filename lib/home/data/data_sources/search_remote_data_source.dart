import 'package:dio/dio.dart';
import '../models/movie_model.dart';

class SearchRemoteDataSource {
  final Dio _dio;

  SearchRemoteDataSource(this._dio);

  Future<List<MovieModel>> searchMovies(String query) async {
    final response = await _dio.get('/search/movie', queryParameters: {
      'query': query,
      'language': 'en-US',
      'page': 1,
    });
    return (response.data['results'] as List)
        .map((json) => MovieModel.fromJson(json))
        .toList();
  }
}