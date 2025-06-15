import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../../core/themes/colors.dart';
import '../../../core/utils/genre_utils.dart';
import '../../../favorites/presentation/pages/collection_details_screen.dart';
import '../../../favorites/presentation/widgets/search_result_item.dart';
import '../../../movie_detail/presentation/pages/movie_detail.dart';
import '../manager/search/search_bloc.dart';
import '../manager/search/search_event.dart';
import '../manager/search/search_state.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      body: SafeArea(
        child: Column(
          children: [
            // Search Bar
            Container(
              color: const Color(0xFF161616),
              height: 80,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: const Color(0xFF8E8E93).withOpacity(0.12),
                        border: Border.all(color: const Color(0xFF979797)),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: Row(
                        children: [
                          const Icon(Icons.search, color: Colors.white),
                          const SizedBox(width: 8),
                          Expanded(
                            child: TextField(
                              controller: _searchController,
                              decoration: const InputDecoration(
                                hintText: 'Search',
                                hintStyle: TextStyle(color: Colors.grey),
                                border: InputBorder.none,
                              ),
                              style: const TextStyle(color: Colors.white),
                              onChanged: (value) {
                                print('TextField onChanged: $value');
                                context.read<SearchBloc>().add(
                                  SearchQueryChanged(value),
                                );
                              },
                            ),
                          ),
                          if (_searchController.text.isNotEmpty)
                            GestureDetector(
                              onTap: () {
                                print('Clear button tapped');
                                _searchController.clear();
                                context.read<SearchBloc>().add(
                                  SearchQueryChanged(''),
                                );
                              },
                              child: SvgPicture.asset(
                                'assets/icons/clear.svg',
                                width: 25,
                                height: 25,
                                color: Colors.grey,
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  GestureDetector(
                    onTap: () {
                      print('Cancel button tapped');
                      context.read<SearchBloc>().add(SearchQueryChanged(''));
                      Navigator.pop(context);
                    },
                    child: const Text(
                      'Cancel',
                      style: TextStyle(
                        color: Color(0xFF2AB156),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // Search Results or Loading
            Expanded(
              child: BlocBuilder<SearchBloc, SearchState>(
                builder: (context, state) {
                  print('BlocBuilder state: $state');
                  if (state is SearchInitial) {
                    return const Padding(
                      padding: EdgeInsets.all(16),
                      child: Text(
                        'Please enter more than 1 symbol for search',
                        style: TextStyle(color: Color(0xFF6D6D72)),
                      ),
                    );
                  } else if (state is SearchLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is SearchSuccess) {
                    if (state.movies.isEmpty) {
                      return const Center(
                        child: Text(
                          'No movies found',
                          style: TextStyle(color: Colors.white),
                        ),
                      );
                    }
                    return ListView.builder(
                      padding: const EdgeInsets.all(16),
                      itemCount: state.movies.length,
                      itemBuilder: (context, index) {
                        final movie = state.movies[index];
                        print('Rendering movie: ${movie.title}');
                        return SearchResultItem(
                          title: movie.title ?? 'Unknown Title',
                          genre:
                              movie.genreIds.isNotEmpty
                                  ? getGenre(movie.genreIds.first)
                                  : 'Unknown Genre',
                          posterUrl:
                              movie.posterPath != null
                                  ? 'https://image.tmdb.org/t/p/w342${movie.posterPath}'
                                  : 'https://via.placeholder.com/55x120',
                          // Fallback image
                          tag: (movie.voteAverage ?? 0) >= 7.0 ? '4K' : 'MOVIE',
                          id: movie.id,
                        );
                      },
                    );
                  } else if (state is SearchError) {
                    return Center(
                      child: Text(
                        'Error: ${state.message}',
                        style: const TextStyle(color: Colors.white),
                      ),
                    );
                  }
                  return const Center(
                    child: Text(
                      'Unexpected state',
                      style: TextStyle(color: Colors.white),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}


