import '../../domain/entities/tv_entity.dart';
import '../../domain/repositories/tv_repository.dart';
import '../data_sources/remote_tv_data_source.dart';

class TvRepositoryImpl implements TvRepository {
  final RemoteTvDataSource _remoteDataSource;

  TvRepositoryImpl(this._remoteDataSource);

  @override
  Future<List<TvEntity>> getPopularTv() async {
    final models = await _remoteDataSource.getPopularTv();
    return models.map((model) => model.toEntity()).toList();
  }

  @override
  Future<List<TvEntity>> getNowPlayingTv() async {
    final models = await _remoteDataSource.getNowPlayingTv();
    return models.map((model) => model.toEntity()).toList();
  }
}