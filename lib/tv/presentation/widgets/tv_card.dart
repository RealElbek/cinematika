import 'package:cached_network_image/cached_network_image.dart';
import 'package:cinematika/tv/presentation/pages/tv_detail.dart';
import 'package:flutter/material.dart';

import '../../../movie_detail/presentation/pages/movie_detail.dart';

class TvCard extends StatelessWidget {
  final int id; // Add this
  final String name;
  final String imageUrl;
  final String genre;

  const TvCard({
    super.key,
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.genre,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => TvDetailScreen(tvId: id)),
        );
      },
      child: SizedBox(
        width: 120,
        height: 180,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(5),
                child: CachedNetworkImage(
                  imageUrl: imageUrl,
                  width: 120,
                  height: 180,
                  fit: BoxFit.cover,
                  placeholder: (context, url) =>
                  const Center(child: CircularProgressIndicator()),
                  errorWidget: (context, url, error) =>
                  const Icon(Icons.error),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Text(
                name,
                style: Theme.of(context)
                    .textTheme
                    .titleMedium!
                    .copyWith(fontSize: 14),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Text(
              genre,
              style: Theme.of(context)
                  .textTheme
                  .bodySmall!
                  .copyWith(fontSize: 12),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
