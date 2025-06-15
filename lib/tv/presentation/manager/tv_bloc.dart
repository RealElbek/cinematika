import 'package:cinematika/tv/presentation/manager/tv_event.dart';
import 'package:cinematika/tv/presentation/manager/tv_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/use_cases/get_now_playing_tv.dart';
import '../../domain/use_cases/get_popular_tv.dart';



class TvBloc extends Bloc<TvEvent, TvState> {
  final GetNowPlayingTv _getNowPlayingTv;
  final GetPopularTv _getPopularTv;

  TvBloc(this._getNowPlayingTv, this._getPopularTv) : super(TvInitial()) {
    on<FetchTvData>((event, emit) async {
      emit(TvLoading());
      try {
        final nowPlaying = await _getNowPlayingTv.execute();
        final popular = await _getPopularTv.execute();
        emit(TvSuccess(nowPlaying, popular));
      } catch (e) {
        emit(TvError(e.toString()));
      }
    });
  }
}