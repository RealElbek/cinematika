import '../entities/tv_entity.dart';
import '../repositories/tv_repository.dart';

class GetPopularTv {
  final TvRepository _repository;

  GetPopularTv(this._repository);

  Future<List<TvEntity>> execute() async {
    return await _repository.getPopularTv();
  }
}