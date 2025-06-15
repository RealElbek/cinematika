import 'package:flutter/material.dart';

import '../../../core/themes/text_style_helper.dart';


class InfoSectionWidget extends StatelessWidget {
  InfoSectionWidget({required this.title, required this.content});

  final String title;
  final Widget content;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title.toUpperCase(),
            style: TextStyleHelper.instance.body13Medium,
          ),
          SizedBox(height: 8),
          content,
        ],
      ),
    );
  }
}
