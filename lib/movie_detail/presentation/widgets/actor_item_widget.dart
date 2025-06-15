import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:shimmer/shimmer.dart';
import '../../../core/themes/text_style_helper.dart';
import '../../../login/presentation/widgets/custom_image_view.dart';

class ActorItemWidget extends StatelessWidget {
  final String imagePath;
  final String name;

  const ActorItemWidget({
    this.imagePath = 'assets/images/default_actor.png', // Default placeholder
    this.name = 'Unknown Actor',
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        CachedNetworkImage(
          imageUrl: imagePath,
          imageBuilder: (context, imageProvider) => Container(
            height: 40,
            width: 80,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8), // Rounded corners
              image: DecorationImage(
                image: imageProvider,
                fit: BoxFit.contain,
              ),
            ),
          ),
          placeholder: (context, url) => Shimmer.fromColors(
            baseColor: Colors.grey[850]!,
            highlightColor: Colors.grey[800]!,
            child: Container(
              height: 40,
              width: 80,
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(8), // Match imageBuilder
              ),
            ),
          ),
          errorWidget: (context, url, error) => ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: CustomImageView(
              imagePath: imagePath,
              height: 40,
              width: 80,
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: 8),
          child: Text(
            name,
            style: TextStyleHelper.instance.body15Light.copyWith(
              fontSize: 16, // Slightly bigger standard size
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}