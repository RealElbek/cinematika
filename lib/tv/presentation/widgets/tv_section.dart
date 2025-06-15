import 'package:cinematika/core/themes/colors.dart';
import 'package:cinematika/tv/presentation/pages/category_tv_screen.dart';
import 'package:flutter/material.dart';

import '../../../home/presentation/pages/category_movies_screen.dart';

class TvSection extends StatelessWidget {
  final String title;
  final List<Widget> tvShows;
  final bool seeAllVisible;
  final double height;

  const TvSection({
    super.key,
    required this.title,
    required this.tvShows,
    this.seeAllVisible = false,
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
                    bool fetchNowPlaying = title.toLowerCase().contains('Now Playing TV Shows') || title.toLowerCase().contains('Popular TV Shows');
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CategoryTvScreen(isNowPlaying: fetchNowPlaying),
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
              itemCount: tvShows.length,
              itemBuilder: (context, index) => Padding(
                padding: EdgeInsets.only(right: index == tvShows.length - 1 ? 0 : 8),
                child: tvShows[index],
              ),
            ),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}