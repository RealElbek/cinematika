import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerMovieCard extends StatelessWidget {
  const ShimmerMovieCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[800]!,
      highlightColor: Colors.grey[600]!,
      child: SizedBox(
        width: 160,
        height: 350,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              height: 245,
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