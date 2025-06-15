import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/tv_entity.dart';
import '../../domain/use_cases/get_now_playing_tv.dart';
import '../../domain/use_cases/get_popular_tv.dart';

abstract class TvEvent {}

class FetchTvData extends TvEvent {}

abstract class TvState {}

class TvInitial extends TvState {}

class TvLoading extends TvState {}

class TvSuccess extends TvState {
  final List<TvEntity> nowPlayingTv;
  final List<TvEntity> popularTv;

  TvSuccess(this.nowPlayingTv, this.popularTv);
}

class TvError extends TvState {
  final String message;

  TvError(this.message);
}

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