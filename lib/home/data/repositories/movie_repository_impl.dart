import '../../domain/entities/movie_entity.dart';
import '../../domain/repositories/movie_repository.dart';
import '../data_sources/remote_data_source.dart';
import '../data_sources/search_remote_data_source.dart';

class MovieRepositoryImpl implements MovieRepository {
  final MovieRemoteDataSource _remoteDataSource;
  final SearchRemoteDataSource _searchRemoteDataSource;

  MovieRepositoryImpl(this._remoteDataSource, this._searchRemoteDataSource);

  @override
  Future<List<MovieEntity>> searchMovies(String query) async {
    final models = await _searchRemoteDataSource.searchMovies(query);
    return models.map((model) => model.toEntity()).toList();
  }

  @override
  Future<List<MovieEntity>> getNowPlayingMovies() async {
    final models = await _remoteDataSource.getNowPlayingMovies();
    return models.map((model) => model.toEntity()).toList();
  }

  @override
  Future<List<MovieEntity>> getPopularMovies() async {
    final models = await _remoteDataSource.getPopularMovies();
    return models.map((model) => model.toEntity()).toList();
  }
}
