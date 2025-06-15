import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shimmer/shimmer.dart';
import '../../../core/locator.dart';
import '../../../core/utils/genre_utils.dart';
import '../manager/home/home_bloc.dart';
import '../manager/home/home_event.dart';
import '../manager/home/home_state.dart';
import '../widgets/category_movie_card.dart';
import '../widgets/shimmer_movie_card.dart';
import 'filter_screen.dart';
import 'search_screen.dart';

class CategoryMoviesScreen extends StatelessWidget {
  final bool isNewMovies;

  const CategoryMoviesScreen({super.key, required this.isNewMovies});

  void _showSearchScreen(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const SearchScreen()),
    );
  }

  void _showFilterOptions(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const FilterScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<HomeBloc>()..add(FetchHomeData()),
      child: Scaffold(
        backgroundColor: const Color(0xFF121212),
        appBar: AppBar(
          backgroundColor: const Color(0xFF161616),
          centerTitle: true,
          leading: IconButton(
            icon: SvgPicture.asset(
              'assets/icons/back_icon.svg',
              width: 24, // Match typical icon size
              height: 24,
              colorFilter: const ColorFilter.mode(Color(0xFF8E8E93), BlendMode.srcIn),
            ),
            onPressed: () => Navigator.pop(context),
          ),
          title: Text(
            isNewMovies ? 'New Movies' : 'Popular Movies',
            style: const TextStyle(
              color: Color(0xFF2AB156),
              fontSize: 16,
              fontWeight: FontWeight.w700,
            ),
          ),
          actions: [
            IconButton(
              icon: SvgPicture.asset(
                'assets/icons/filter_icon.svg',
                width: 24,
                height: 24,
                colorFilter: const ColorFilter.mode(Color(0xFF8E8E93), BlendMode.srcIn),
              ),
              onPressed: () => _showFilterOptions(context),
            ),
            IconButton(
              icon: SvgPicture.asset(
                'assets/icons/search_icon.svg',
                width: 24,
                height: 24,
                colorFilter: const ColorFilter.mode(Color(0xFF8E8E93), BlendMode.srcIn),
              ),
              onPressed: () => _showSearchScreen(context),
            ),
            const SizedBox(width: 8),
          ],
        ),
        body: BlocBuilder<HomeBloc, HomeState>(
          builder: (context, state) {
            if (state is HomeLoading) {
              return GridView.builder(
                padding: const EdgeInsets.all(16),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.46,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                itemCount: 4,
                itemBuilder: (context, index) => const ShimmerMovieCard(),
              );
            } else if (state is HomeSuccess) {
              final movies = isNewMovies ? state.nowPlayingMovies : state.popularMovies;
              if (movies.isEmpty) {
                return const Center(
                  child: Text(
                    'No movies found',
                    style: TextStyle(color: Colors.white),
                  ),
                );
              }
              final limitedMovies = movies.take(8).toList();
              return GridView.builder(
                padding: const EdgeInsets.all(16),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.46,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                itemCount: limitedMovies.length,
                itemBuilder: (context, index) {
                  final movie = limitedMovies[index];
                  return MovieCard(
                    title: movie.title,
                    imageUrl: movie.posterPath != null
                        ? 'https://image.tmdb.org/t/p/w342${movie.posterPath}'
                        : 'https://via.placeholder.com/160x245',
                    genre: movie.genreIds.isNotEmpty ? getGenre(movie.genreIds.first) : 'Unknown Genre', id: movie.id,
                  );
                },
              );
            } else if (state is HomeError) {
              return Center(
                child: Text(
                  state.message,
                  style: const TextStyle(color: Colors.white),
                ),
              );
            }
            return const Center(
              child: Text(
                'Loading movies...',
                style: TextStyle(color: Colors.white),
              ),
            );
          },
        ),
      ),
    );
  }
}

