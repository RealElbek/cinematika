import 'package:flutter/material.dart';
import '../../../home/presentation/pages/search_screen.dart';
import '../../../home/presentation/widgets/search_result_item.dart';
import '../../data/remote/models/movie_item.dart';


const kPrimaryColor = Color(0xFF2AB156);
const kDarkBackground = Color(0xFF121212);
const kHeaderBackground = Color(0xFF161616);
const kSpacingSmall = 8.0;

class CollectionDetailScreen extends StatelessWidget {
  const CollectionDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        scrolledUnderElevation: 0,
        shadowColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.search, color: Colors.white, semanticLabel: 'Search collection'),
            onPressed: () => _navigateToSearch(context),
          ),
        ],
      ),
      body: Container(
        color: kDarkBackground,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: MediaQuery.of(context).padding.top,
              color: kHeaderBackground,
            ),
            _buildHeader(),
            _buildMovieList(),
          ],
        ),
      ),
    );
  }

  void _navigateToSearch(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const SearchScreen()),
    );
  }

  Widget _buildHeader() {
    return Container(
      height: 120,
      color: kHeaderBackground,
      padding: const EdgeInsets.only(left: 16, bottom: 16),
      child: const Align(
        alignment: Alignment.bottomLeft,
        child: Text(
          'My Collections',
          style: TextStyle(
            fontSize: 34,
            fontWeight: FontWeight.w700,
            color: kPrimaryColor,
          ),
          semanticsLabel: 'Collection detail title',
        ),
      ),
    );
  }

  Widget _buildMovieList() {
    final demoMovies = [
      MovieItem(
        id: 634649,
        title: 'Spider-Man',
        genre: 'Action | Fantasy | Adventure',
        posterUrl: 'https://image.tmdb.org/t/p/w342/1g0dhYtq4irTY1GPXvft6k4YLjm.jpg',
        tag: 'MOVIE',
      ),
      MovieItem(
        id: 766507,
        title: 'Predator',
        genre: 'Action | Fantasy | Adventure',
        posterUrl: 'https://image.tmdb.org/t/p/w342/h58U7d1OZyuWaCWMYvw4mfnv6H3.jpg',
        tag: 'MOVIE',
      ),
      MovieItem(
        id: 335983,
        title: 'Venom',
        genre: 'Adventure | Cartoon',
        posterUrl: 'https://image.tmdb.org/t/p/w342/2uNW4WbgBXL25BAbXGLnLqX71Sw.jpg',
        tag: 'MOVIE',
      ),
      MovieItem(
        id: 1230186,
        title: 'The last of Us',
        genre: 'Action | Fantasy | Adventure',
        posterUrl: 'https://image.tmdb.org/t/p/w342/dmo6TYuuJgaYinXBPjrgG9mB5od.jpg',
        tag: 'Movie',
      ),
    ];
    return Expanded(
      child: ListView.builder(
        padding: const EdgeInsets.all(kSpacingSmall),
        itemCount: demoMovies.length,
        itemBuilder: (context, index) {
          final movie = demoMovies[index];
          return SearchResultItem(
            id: movie.id,
            title: movie.title,
            genre: movie.genre,
            posterUrl: movie.posterUrl,
            tag: movie.tag,
          );
        },
      ),
    );
  }
}


