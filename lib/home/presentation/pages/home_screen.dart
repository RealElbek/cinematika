import 'package:cinematika/home/presentation/pages/search_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/locator.dart';
import '../../domain/entities/movie_entity.dart';
import '../manager/home/home_bloc.dart';
import '../manager/home/home_event.dart';
import '../manager/home/home_state.dart';
import '../widgets/movie_card.dart';
import '../widgets/movie_section.dart';
import '../widgets/unwatched_movie_card.dart';
import '../../../core/utils/genre_utils.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  void _showSearchScreen(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const SearchScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<HomeBloc>()..add(FetchHomeData()),
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          scrolledUnderElevation: 0,
          shadowColor: Colors.transparent,
          elevation: 0,
          actions: [
            IconButton(
              icon: const Icon(Icons.search, color: Colors.white),
              onPressed: () => _showSearchScreen(context),
            ),
          ],
        ),
        body: Container(
          color: Colors.black,
          child: Column(
            children: [
              Container(
                height: MediaQuery.of(context).padding.top,
                color: const Color(0xFF161616),
              ),
              Container(
                height: 120,
                color: const Color(0xFF161616),
                child: Padding(
                  padding: const EdgeInsets.only(left: 16, bottom: 16),
                  child: Align(
                    alignment: Alignment.bottomLeft,
                    child: const Text(
                      'Movies',
                      style: TextStyle(
                        fontSize: 34,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF2AB156),
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: BlocBuilder<HomeBloc, HomeState>(
                  builder: (context, state) {
                    if (state is HomeLoading) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (state is HomeSuccess) {
                      return ListView(
                        padding: EdgeInsets.zero,
                        children: [
                          SizedBox(height: 20,),
                          MovieSection(
                            seeAllVisible: false,
                            title: 'Unwatched',
                            height: 80,
                            movies: [
                              const UnwatchedMovieCard(
                                imageUrl: 'https://image.tmdb.org/t/p/w342//srj9rYrjefyWqkLc6l2xjTGeBGO.jpg',
                                percentage: '75%',
                              ),
                              const UnwatchedMovieCard(
                                imageUrl: 'https://image.tmdb.org/t/p/w342//srj9rYrjefyWqkLc6l2xjTGeBGO.jpg',
                                percentage: '15%',
                              ),
                            ],
                          ),
                          MovieSection(
                            seeAllVisible: true,
                            title: 'New movies',
                            height: 220,
                            movies: state.nowPlayingMovies.map((movie) {
                              return MovieCard(
                                title: movie.title,
                                imageUrl: 'https://image.tmdb.org/t/p/w342${movie.posterPath}',
                                genre: getGenre(movie.genreIds.first), id: movie.id,
                              );
                            }).toList(),
                          ),
                          MovieSection(
                            seeAllVisible: true,
                            title: 'Popular movies',
                            height: 220,
                            movies: state.popularMovies.map((movie) {
                              return MovieCard(
                                title: movie.title,
                                imageUrl: 'https://image.tmdb.org/t/p/w342${movie.posterPath}',
                                genre: getGenre(movie.genreIds.first), id: movie.id,
                              );
                            }).toList(),
                          ),
                        ],
                      );
                    } else if (state is HomeError) {
                      return Center(child: Text('Error: ${state.message}'));
                    }
                    return const SizedBox.shrink();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
