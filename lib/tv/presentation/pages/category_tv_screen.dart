import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shimmer/shimmer.dart';
import '../../../core/locator.dart';
import '../../../core/utils/genre_utils.dart';
import '../../../home/presentation/pages/filter_screen.dart';
import '../../../home/presentation/pages/search_screen.dart';
import '../manager/tv_bloc.dart';
import '../manager/tv_event.dart';
import '../manager/tv_state.dart';
import '../widgets/category_tv_card.dart';

class CategoryTvScreen extends StatelessWidget {
  final bool isNowPlaying;

  const CategoryTvScreen({super.key, required this.isNowPlaying});

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
      create: (context) => getIt<TvBloc>()..add(FetchTvData()),
      child: Scaffold(
        backgroundColor: const Color(0xFF121212),
        appBar: AppBar(
          backgroundColor: const Color(0xFF161616),
          centerTitle: true,
          leading: IconButton(
            icon: SvgPicture.asset(
              'assets/icons/back_icon.svg',
              width: 24,
              height: 24,
              colorFilter: const ColorFilter.mode(Color(0xFF8E8E93), BlendMode.srcIn),
            ),
            onPressed: () => Navigator.pop(context),
          ),
          title: Text(
            isNowPlaying ? 'Now Playing TV Shows' : 'Popular TV Shows',
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
        body: BlocBuilder<TvBloc, TvState>(
          builder: (context, state) {
            if (state is TvLoading) {
              return GridView.builder(
                padding: const EdgeInsets.all(16),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.66, // 2:3 aspect ratio (160:240)
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                itemCount: 4,
                itemBuilder: (context, index) => const ShimmerTvCard(),
              );
            } else if (state is TvSuccess) {
              final tvShows = isNowPlaying ? state.nowPlayingTv : state.popularTv;
              if (tvShows.isEmpty) {
                return const Center(
                  child: Text(
                    'No TV shows found',
                    style: TextStyle(color: Colors.white),
                  ),
                );
              }
              final limitedTvShows = tvShows.take(8).toList();
              return GridView.builder(
                padding: const EdgeInsets.all(16),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.66, // 2:3 aspect ratio (160:240)
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                itemCount: limitedTvShows.length,
                itemBuilder: (context, index) {
                  final tv = limitedTvShows[index];
                  return CategoryTvCard(
                    name: tv.name,
                    imageUrl: tv.posterPath != null
                        ? 'https://image.tmdb.org/t/p/w342${tv.posterPath}'
                        : 'https://via.placeholder.com/160x240',
                    genre: tv.genreIds.isNotEmpty ? getGenre(tv.genreIds.first) : 'Unknown Genre', id: tv.id,
                  );
                },
              );
            } else if (state is TvError) {
              return Center(
                child: Text(
                  state.message,
                  style: const TextStyle(color: Colors.white),
                ),
              );
            }
            return const Center(
              child: Text(
                'Loading TV shows...',
                style: TextStyle(color: Colors.white),
              ),
            );
          },
        ),
      ),
    );
  }
}

class ShimmerTvCard extends StatelessWidget {
  const ShimmerTvCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[800]!,
      highlightColor: Colors.grey[600]!,
      child: SizedBox(
        width: 160,
        height: 240, // Matches 2:3 aspect ratio with width 160
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              height: 180, // Image height adjusted for 2:3 aspect ratio
              width: 160,
              decoration: BoxDecoration(
                color: Colors.grey[800],
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: Column(
                children: [
                  Container(width: 120, height: 16, color: Colors.grey[800]),
                  const SizedBox(height: 2),
                  Container(width: 100, height: 14, color: Colors.grey[800]),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}