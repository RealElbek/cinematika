import 'package:dio/dio.dart';
import '../models/tv_model.dart';

class RemoteTvDataSource {
  final Dio _dio;

  RemoteTvDataSource(this._dio);

  Future<List<TvModel>> getPopularTv() async {
    try {
      final response = await _dio.get('/tv/popular');
      return (response.data['results'] as List)
          .map((json) => TvModel.fromJson(json))
          .toList();
    } catch (e) {
      rethrow;
    }
  }

  Future<List<TvModel>> getNowPlayingTv() async {
    try {
      final response = await _dio.get('/tv/on_the_air');
      return (response.data['results'] as List)
          .map((json) => TvModel.fromJson(json))
          .toList();
    } catch (e) {
      rethrow;
    }
  }
}