import '../entities/tv_entity.dart';
import '../repositories/tv_repository.dart';

class GetNowPlayingTv {
  final TvRepository _repository;

  GetNowPlayingTv(this._repository);

  Future<List<TvEntity>> execute() async {
    return await _repository.getNowPlayingTv();
  }
}