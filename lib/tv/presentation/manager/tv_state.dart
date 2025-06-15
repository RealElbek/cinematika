import '../../domain/entities/tv_entity.dart';

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
