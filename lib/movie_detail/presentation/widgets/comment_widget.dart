import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../core/themes/text_style_helper.dart';
import '../../../login/presentation/widgets/custom_image_view.dart';

class CommentWidget extends StatelessWidget {
  final String userImage;
  final String userName;
  final String date;
  final String commentText;

  const CommentWidget({
    this.userImage = '/mgNCdh78RtrS3LctrrhD4bUQuQ6.jpg', // Default placeholder
    this.userName = 'Anonymous',
    this.date = 'Unknown Date',
    this.commentText = 'No comment available',
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 24),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(top: 4),
            child: CachedNetworkImage(
              imageUrl: "https://image.tmdb.org/t/p/w500$userImage",
              height: 23,
              width: 23,
              // radius: BorderRadius.circular(11.5),
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(left: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        userName,
                        style: TextStyleHelper.instance.body15Medium,
                      ),
                      Text(
                        date,
                        style: TextStyleHelper.instance.body12,
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 8),
                    child: Text(
                      commentText,
                      style: TextStyleHelper.instance.body13Light.copyWith(
                        height: 1.15,
                      ),
                    ),
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