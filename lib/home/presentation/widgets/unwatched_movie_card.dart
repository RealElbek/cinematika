import 'package:flutter/material.dart';

class UnwatchedMovieCard extends StatelessWidget {
  final String imageUrl;
  final String percentage;

  const UnwatchedMovieCard({
    super.key,
    required this.imageUrl,
    required this.percentage,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 120,
      height: 58,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(),
      child: Stack(
        children: [
          Positioned(
            left: 0,
            top: 0,
            child: Container(
              width: 120,
              height: 58,
              decoration: ShapeDecoration(
                image: DecorationImage(
                  image: NetworkImage(imageUrl),
                  fit: BoxFit.cover,
                ),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
              ),
            ),
          ),
          Positioned(
            left: 0,
            top: 0,
            child: Container(
              width: 85,
              height: 58,
              decoration: BoxDecoration(color: const Color(0xB5161616)),
            ),
          ),
          Positioned(
            left: 46,
            top: 21,
            child: Text(
              percentage,
              style: TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontFamily: 'SF Pro Display',
                fontWeight: FontWeight.w500,
                shadows: [
                  Shadow(
                    offset: Offset(0, 2),
                    blurRadius: 2,
                    color: Color(0xFF000000).withOpacity(0.83),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}