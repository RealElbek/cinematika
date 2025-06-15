import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/locator.dart';
import '../../../home/presentation/pages/search_screen.dart';
import '../../domain/entities/tv_entity.dart';
import '../manager/tv_bloc.dart';
import '../widgets/tv_card.dart';
import '../widgets/tv_section.dart';
import '../../../core/utils/genre_utils.dart';

class TvScreen extends StatelessWidget {
  const TvScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
      getIt<TvBloc>()
        ..add(FetchTvData()),
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          actions: [
            IconButton(
              icon: const Icon(Icons.search, color: Colors.white),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SearchScreen()),
                );
              },
            ),
          ],
        ),
        body: Container(
          color: Colors.black,
          child: Column(
            children: [
              Container(
                height: MediaQuery
                    .of(context)
                    .padding
                    .top,
                color: const Color(0xFF161616),
              ),
              Container(
                height: 120,
                color: const Color(0xFF161616),
                child: const Padding(
                  padding: EdgeInsets.only(left: 16, bottom: 16),
                  child: Align(
                    alignment: Alignment.bottomLeft,
                    child: Text(
                      'TV Shows',
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
                child: BlocBuilder<TvBloc, TvState>(
                  builder: (context, state) {
                    if (state is TvLoading) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (state is TvSuccess) {
                      return ListView(
                        padding: EdgeInsets.zero,
                        children: [
                          const SizedBox(height: 20),
                          TvSection(
                            seeAllVisible: true,
                            title: 'Now Playing TV Shows',
                            tvShows: state.nowPlayingTv.map((tv) {
                              return TvCard(
                                name: tv.name,
                                imageUrl: 'https://image.tmdb.org/t/p/w342${tv
                                    .posterPath}',
                                genre: getGenre(tv.genreIds.first), id: tv.id,
                              );
                            }).toList(),
                          ),
                          TvSection(
                            seeAllVisible: true,
                            title: 'Popular TV Shows',
                            tvShows: state.popularTv.map((tv) {
                              return TvCard(
                                name: tv.name,
                                imageUrl: 'https://image.tmdb.org/t/p/w342${tv
                                    .posterPath}',
                                genre: getGenre(tv.genreIds.first), id: tv.id,
                              );
                            }).toList(),
                          ),
                        ],
                      );
                    } else if (state is TvError) {
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
