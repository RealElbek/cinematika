import 'package:cinematika/favorites/presentation/pages/collection_details_screen.dart';
import 'package:flutter/material.dart';
import '../../../home/presentation/pages/search_screen.dart';
import '../widgets/collection_grid_item.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

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
        color: const Color(0xFF121212), // Dark background
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Safe area padding for status bar
            Container(
              height: MediaQuery.of(context).padding.top,
              color: const Color(0xFF161616),
            ),
            // Header section with height 120
            Container(
              height: 120,
              color: const Color(0xFF161616),
              child: Padding(
                padding: const EdgeInsets.only(left: 16, bottom: 16),
                child: Align(
                  alignment: Alignment.bottomLeft,
                  child: const Text(
                    'Favorites',
                    style: TextStyle(
                      fontSize: 34,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF2AB156), // Green accent
                    ),
                  ),
                ),
              ),
            ),
            // Grid of collection items
            Padding(
              padding: const EdgeInsets.only(top: 10, left: 15, right: 15),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CollectionGridItem(
                        onTap: (){
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => CollectionDetailScreen()),
                          );
                        },
                        title: 'My Favorite Collection',
                        imageUrls: [
                          'https://image.tmdb.org/t/p/w342/2uNW4WbgBXL25BAbXGLnLqX71Sw.jpg',
                          'https://image.tmdb.org/t/p/w342/h58U7d1OZyuWaCWMYvw4mfnv6H3.jpg',
                          'https://image.tmdb.org/t/p/w342/gv5ByLHZfn7MUKpjJovRTr5URGg.jpg',
                          'https://image.tmdb.org/t/p/w342/dmo6TYuuJgaYinXBPjrgG9mB5od.jpg',
                        ],
                      ),
                      CollectionGridItem(
                        onTap: (){
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => CollectionDetailScreen()),
                          );
                        },
                        title: 'Marvel',
                        imageUrls: [
                          'https://image.tmdb.org/t/p/w342/y4MBh0EjBlMuOzv9axM4qJlmhzz.jpg',
                          'https://image.tmdb.org/t/p/w342/rzRwTcFvttcN1ZpX2xv4j3tSdJu.jpg',
                          'https://image.tmdb.org/t/p/w342/7WsyChQLEftFiDOVTGkv3hFpyyt.jpg',
                          'https://image.tmdb.org/t/p/w342/1g0dhYtq4irTY1GPXvft6k4YLjm.jpg',
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 10,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      CollectionGridItem(
                        onTap: (){
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => CollectionDetailScreen()),
                          );
                        },
                        title: 'DC',
                        imageUrls: [
                          'https://image.tmdb.org/t/p/w342/tnAuB8q5vv7Ax9UAEje5Xi4BXik.jpg',
                          'https://image.tmdb.org/t/p/w342/y78UlBU4Y2HnEuvSW4V0A5DzP3C.jpg',
                          'https://image.tmdb.org/t/p/w342/5UsK3grJvtQrtzEgqNlDljJW96w.jpg',
                          'https://image.tmdb.org/t/p/w342/jcA2QFJ4wuFcG79P97wA7OBLQoL.jpg',
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}



