import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';

import '../home/data/data_sources/remote_data_source.dart';
import '../home/data/data_sources/search_remote_data_source.dart';
import '../home/data/repositories/movie_repository_impl.dart';
import '../home/domain/repositories/movie_repository.dart';
import '../home/domain/use_cases/get_now_playing_movies.dart';
import '../home/domain/use_cases/get_popular_movies.dart';
import '../home/domain/use_cases/search_movies_use_case.dart';
import '../home/presentation/manager/home/home_bloc.dart';
import '../home/presentation/manager/search/search_bloc.dart';
import '../login/data/data_sources/local_sources/shared_prefs.dart';
import '../login/data/data_sources/remote_data_source/firebase_auth_data_source.dart';
import '../login/data/repositories/auth_repository.dart';
import '../login/domain/use_cases/check_registration_use_case.dart';
import '../login/domain/use_cases/login_user_use_case.dart';
import '../login/domain/use_cases/register_user_use_case.dart';
import '../core/themes/colors.dart';
import '../login/presentation/manager/auth_bloc.dart';
import '../movie_detail/data/remote/data_sources/remote_movie_data_source.dart';
import '../movie_detail/data/repositories/movie_repository_impl.dart';
import '../movie_detail/domain/repositories/movie_repository.dart';
import '../movie_detail/domain/use_cases/get_movie_details.dart';
import '../movie_detail/domain/use_cases/get_movie_reviews.dart';
import '../movie_detail/domain/use_cases/get_movie_trailers.dart';
import '../movie_detail/domain/use_cases/get_tv_details.dart';
import '../movie_detail/presentation/manager/movie_detail_bloc.dart';
import '../tv/data/data_sources/remote_tv_data_source.dart';
import '../tv/data/repositories/tv_repository_impl.dart';
import '../tv/domain/repositories/tv_repository.dart';
import '../tv/domain/use_cases/get_now_playing_tv.dart';
import '../tv/domain/use_cases/get_popular_tv.dart';
import '../tv/presentation/manager/tv_bloc.dart'; // Assuming AppColors is defined here

final GetIt getIt = GetIt.instance;

void setupLocator() {
  try {
    // Register a single Dio instance with TMDB configuration
    getIt.registerLazySingleton<Dio>(() {
      final dio = Dio();
      dio.options.baseUrl = 'https://api.themoviedb.org/3';
      dio.options.queryParameters = {'api_key': 'fab3626d9e8d767dbf679f3c64849db5'};
      dio.interceptors.add(LogInterceptor(responseBody: true)); // Optional: Add logging for debugging
      return dio;
    });

    // Add AuthBloc registration
    getIt.registerFactory<AuthBloc>(
          () => AuthBloc(
        getIt<RegisterUserUseCase>(),
        getIt<LoginUserUseCase>(),
      ),
    );


    // Home module - Register data sources
    getIt.registerLazySingleton<MovieRemoteDataSource>(
          () => MovieRemoteDataSource(getIt<Dio>()),
    );
    getIt.registerLazySingleton<SearchRemoteDataSource>(
          () => SearchRemoteDataSource(getIt<Dio>()),
    );

    // Register a single MovieRepository with both data sources
    getIt.registerLazySingleton<MovieRepository>(
          () => MovieRepositoryImpl(
        getIt<MovieRemoteDataSource>(),
        getIt<SearchRemoteDataSource>(),
      ),
    );

    // Register use cases
    getIt.registerLazySingleton<GetNowPlayingMovies>(
          () => GetNowPlayingMovies(getIt<MovieRepository>()),
    );
    getIt.registerLazySingleton<GetPopularMovies>(
          () => GetPopularMovies(getIt<MovieRepository>()),
    );
    getIt.registerLazySingleton<SearchMoviesUseCase>(
          () => SearchMoviesUseCase(getIt<MovieRepository>()),
    );

    // Register blocs
    getIt.registerFactory<HomeBloc>(
          () => HomeBloc(getIt<GetNowPlayingMovies>(), getIt<GetPopularMovies>()),
    );
    getIt.registerFactory<SearchBloc>(
          () => SearchBloc(getIt<SearchMoviesUseCase>()),
    );

    // Login/Registration module
    getIt.registerLazySingleton<SharedPrefs>(() => SharedPrefs());
    getIt.registerLazySingleton<FirebaseAuthDataSource>(
          () => FirebaseAuthDataSource(getIt<Dio>()),
    );
    getIt.registerLazySingleton<AuthRepository>(
          () => AuthRepository(getIt<FirebaseAuthDataSource>(), getIt<SharedPrefs>()),
    );
    getIt.registerLazySingleton<RegisterUserUseCase>(
          () => RegisterUserUseCase(getIt<AuthRepository>()),
    );
    getIt.registerLazySingleton<LoginUserUseCase>(
          () => LoginUserUseCase(getIt<AuthRepository>()),
    );
    getIt.registerLazySingleton<CheckRegistrationUseCase>(
          () => CheckRegistrationUseCase(getIt<AuthRepository>()),
    );
  } catch (e) {
    // Handle dependency injection errors (e.g., log or throw)
    throw Exception('Failed to setup locator: $e');
  }

  getIt.registerLazySingleton<RemoteTvDataSource>(
        () => RemoteTvDataSource(getIt<Dio>()),
  );
  getIt.registerLazySingleton<TvRepository>(
        () => TvRepositoryImpl(getIt<RemoteTvDataSource>()),
  );
  getIt.registerLazySingleton<GetNowPlayingTv>(
        () => GetNowPlayingTv(getIt<TvRepository>()),
  );
  getIt.registerLazySingleton<GetPopularTv>(
        () => GetPopularTv(getIt<TvRepository>()),
  );
  getIt.registerFactory<TvBloc>(
        () => TvBloc(getIt<GetNowPlayingTv>(), getIt<GetPopularTv>()),
  );

  // Movie details
  // Register Data Source
  getIt.registerLazySingleton<RemoteMovieDetailDataSource>(
        () => RemoteMovieDetailDataSourceImpl(getIt<Dio>()),
  );

  // Register Repository
  getIt.registerLazySingleton<MovieDetailRepository>(
        () => MovieDetailRepositoryImpl(getIt<RemoteMovieDetailDataSource>()),
  );

  // Register Use Cases
  getIt.registerLazySingleton<GetMovieDetails>(
        () => GetMovieDetails(getIt<MovieDetailRepository>()),
  );
  getIt.registerLazySingleton<GetMovieTrailers>(
        () => GetMovieTrailers(getIt<MovieDetailRepository>()),
  );
  getIt.registerLazySingleton<GetMovieReviews>(
        () => GetMovieReviews(getIt<MovieDetailRepository>()),
  );
  getIt.registerLazySingleton<GetTvDetails>(
        () => GetTvDetails(getIt<MovieDetailRepository>()),
  );

  // Register BLoC
  getIt.registerFactory<MovieDetailBloc>(
        () => MovieDetailBloc(
      getIt<GetMovieDetails>(),
      getIt<GetMovieTrailers>(),
      getIt<GetMovieReviews>(),
      getIt<GetTvDetails>(),
    ),
  );
}