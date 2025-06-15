import 'package:cached_network_image/cached_network_image.dart';
import 'package:cinematika/movie_detail/presentation/pages/movie_detail.dart';
import 'package:flutter/material.dart';

class MovieCard extends StatelessWidget {
  final int id;
  final String title;
  final String? percentage;
  final String imageUrl;
  final String genre;
  final void Function(String id)? onTap;

  const MovieCard({
    super.key,
    required this.id,
    required this.title,
    this.percentage,
    required this.imageUrl,
    required this.genre,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (onTap != null) {
          onTap!(id as String);
        } else {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => MovieDetailScreen(movieId: id)),
          );
        }
      },
      child: SizedBox(
        width: 120,
        height: 220,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(5),
                    child: CachedNetworkImage(
                      imageUrl: imageUrl,
                      width: 120,
                      height: 180,
                      fit: BoxFit.cover,
                      placeholder: (context, url) => const Center(child: CircularProgressIndicator()),
                      errorWidget: (context, url, error) => const Icon(Icons.error),
                    ),
                  ),
                  if (percentage != null)
                    Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: Container(
                        height: 58,

                      ),
                    ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Text(
                title,
                style: Theme.of(context).textTheme.titleMedium!.copyWith(fontSize: 14),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Text(
              genre,
              style: Theme.of(context).textTheme.bodySmall!.copyWith(fontSize: 12),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
