// test/api_test.dart
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:cinematika/home/domain/entities/movie_entity.dart';
import 'package:cinematika/home/domain/repositories/movie_repository.dart';
import 'package:cinematika/home/domain/use_cases/get_now_playing_movies.dart';
import '../mocks/mocks.mocks.dart';

void main() {
  late GetNowPlayingMovies getNowPlayingMovies;
  late MockMovieRepository mockMovieRepository;

  setUp(() {
    mockMovieRepository = MockMovieRepository();
    getNowPlayingMovies = GetNowPlayingMovies(mockMovieRepository);
  });

  test('should return a list of now playing movies from the repository', () async {

    final expectedMovies = [
      MovieEntity(
        id: 1,
        title: 'Movie 1',
        posterPath: '/path1.jpg',
        genreIds: [18, 80],
        overview: 'A thrilling drama',
        voteAverage: 7.5,
      ),
      MovieEntity(
        id: 2,
        title: 'Movie 2',
        posterPath: '/path2.jpg',
        genreIds: [28, 12],
        overview: 'An action-packed adventure',
        voteAverage: 8.0,
      ),
    ];
    when(mockMovieRepository.getNowPlayingMovies())
        .thenAnswer((_) async => expectedMovies);

    // Act
    final result = await getNowPlayingMovies.execute();

    // Assert
    expect(result, equals(expectedMovies));
    verify(mockMovieRepository.getNowPlayingMovies()).called(1);
    verifyNoMoreInteractions(mockMovieRepository);
  });

  test('should throw an exception when repository fails', () async {
    // Arrange
    when(mockMovieRepository.getNowPlayingMovies())
        .thenThrow(Exception('API error'));

    // Act & Assert
    expect(() async => await getNowPlayingMovies.execute(),
        throwsA(isA<Exception>().having((e) => e.toString(), 'message', 'Exception: API error')));
    verify(mockMovieRepository.getNowPlayingMovies()).called(1);
    verifyNoMoreInteractions(mockMovieRepository);
  });
}