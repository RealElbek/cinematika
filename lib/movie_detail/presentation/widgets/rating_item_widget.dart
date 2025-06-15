import 'package:flutter/material.dart';

import '../../../core/themes/text_style_helper.dart';
import '../../../login/presentation/widgets/custom_image_view.dart';

class RatingItemWidget extends StatelessWidget {
  RatingItemWidget({this.imagePath, this.title, this.value});

  String? imagePath;
  String? title;
  String? value;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        CustomImageView(imagePath: imagePath, height: 28, width: 28),
        Padding(
          padding: EdgeInsets.only(top: 4),
          child: Text(title ?? '', style: TextStyleHelper.instance.label10),
        ),
        Padding(
          padding: EdgeInsets.only(top: 4),
          child: Text(
            value ?? '',
            style: TextStyleHelper.instance.title17SemiBold.copyWith(
              color: Color(0xFF8E8E93),
            ),
          ),
        ),
      ],
    );
  }
}
