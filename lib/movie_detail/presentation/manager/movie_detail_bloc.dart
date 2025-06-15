import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/movie_detail_entity.dart';
import '../../domain/entities/tv_detail_entity.dart';
import '../../domain/entities/trailer_entity.dart';
import '../../domain/entities/review_entity.dart';
import '../../domain/use_cases/get_movie_details.dart';
import '../../domain/use_cases/get_movie_trailers.dart';
import '../../domain/use_cases/get_movie_reviews.dart';
import '../../domain/use_cases/get_tv_details.dart';

// Events
abstract class MovieDetailEvent {}

class FetchMovieDetails extends MovieDetailEvent {
  final int movieId;

  FetchMovieDetails(this.movieId);
}

class FetchTvDetails extends MovieDetailEvent {
  final int tvId;

  FetchTvDetails(this.tvId);
}

// States
abstract class MovieDetailState {}

class MovieDetailInitial extends MovieDetailState {}

class MovieDetailLoading extends MovieDetailState {}

class MovieDetailLoaded extends MovieDetailState {
  final MovieDetailEntity? movie;
  final TvDetailEntity? tv;
  final List<TrailerEntity> trailers;
  final List<ReviewEntity> reviews;

  MovieDetailLoaded({
    this.movie,
    this.tv,
    required this.trailers,
    required this.reviews,
  });
}

class MovieDetailError extends MovieDetailState {
  final String message;

  MovieDetailError(this.message);
}

// BLoC
class MovieDetailBloc extends Bloc<MovieDetailEvent, MovieDetailState> {
  final GetMovieDetails _getMovieDetails;
  final GetMovieTrailers _getMovieTrailers;
  final GetMovieReviews _getMovieReviews;
  final GetTvDetails _getTvDetails;

  MovieDetailBloc(
      this._getMovieDetails,
      this._getMovieTrailers,
      this._getMovieReviews,
      this._getTvDetails,
      ) : super(MovieDetailInitial()) {
    on<FetchMovieDetails>((event, emit) async {
      emit(MovieDetailLoading());
      try {
        final movie = await _getMovieDetails.execute(event.movieId);
        final trailers = await _getMovieTrailers.execute(event.movieId);
        final reviews = await _getMovieReviews.execute(event.movieId);
        emit(MovieDetailLoaded(
          movie: movie,
          tv: null,
          trailers: trailers,
          reviews: reviews,
        ));
      } catch (e) {
        emit(MovieDetailError(e.toString()));
      }
    });

    on<FetchTvDetails>((event, emit) async {
      emit(MovieDetailLoading());
      try {
        final tv = await _getTvDetails.execute(event.tvId);
        emit(MovieDetailLoaded(
          movie: null,
          tv: tv,
          trailers: [],
          reviews: [],
        ));
      } catch (e) {
        emit(MovieDetailError(e.toString()));
      }
    });
  }
}