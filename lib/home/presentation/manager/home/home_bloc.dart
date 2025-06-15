import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/use_cases/get_now_playing_movies.dart';
import '../../../domain/use_cases/get_popular_movies.dart';
import 'home_event.dart';
import 'home_state.dart';


class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final GetNowPlayingMovies _getNowPlayingMovies;
  final GetPopularMovies _getPopularMovies;

  HomeBloc(this._getNowPlayingMovies, this._getPopularMovies) : super(HomeInitial()) {
    on<FetchHomeData>((event, emit) async {
      emit(HomeLoading());
      try {
        final nowPlaying = await _getNowPlayingMovies.execute();
        final popular = await _getPopularMovies.execute();
        emit(HomeSuccess(nowPlaying, popular));
      } catch (e) {
        emit(HomeError(e.toString()));
      }
    });
  }
}