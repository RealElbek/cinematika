import '../entities/tv_entity.dart';

abstract class TvRepository {
  Future<List<TvEntity>> getPopularTv();
  Future<List<TvEntity>> getNowPlayingTv();
}