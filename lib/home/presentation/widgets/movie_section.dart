import 'package:flutter/material.dart';

import '../../../core/themes/colors.dart';
import '../pages/category_movies_screen.dart';
class MovieSection extends StatelessWidget {
  final String title;
  final List<Widget> movies;
  final bool seeAllVisible;
  final double height;

  const MovieSection({
    super.key,
    required this.title,
    required this.movies,
    required this.seeAllVisible,
    this.height = 220,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: Theme.of(context).textTheme.titleMedium,
              ),
              if (seeAllVisible)
                InkWell(
                  onTap: () {
                    bool fetchNowPlaying = title.toLowerCase().contains('New movies') || title.toLowerCase().contains('Popular movies');
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CategoryMoviesScreen(isNewMovies: fetchNowPlaying),
                      ),
                    );
                  },
                  child: Text(
                    'See all',
                    style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                      fontSize: 15,
                      color: AppColors.primary,
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 8),
          SizedBox(
            height: height,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: movies.length,
              itemBuilder: (context, index) => Padding(
                padding: EdgeInsets.only(right: index == movies.length - 1 ? 0 : 8),
                child: movies[index],
              ),
            ),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}