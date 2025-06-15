import '../entities/tv_detail_entity.dart';
import '../repositories/movie_repository.dart';

class GetTvDetails {
  final MovieDetailRepository _repository;

  GetTvDetails(this._repository);

  Future<TvDetailEntity> execute(int tvId) async {
    return await _repository.getTvDetails(tvId);
  }
}