import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';

class ExpandableTextWidget extends StatelessWidget {
  final String text;
  EdgeInsetsGeometry padding;
  ExpandableTextWidget(
      {required this.text, this.padding = const EdgeInsets.all(8.0), Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: ExpandableText(
        text,
        expandText: 'Read more',
        collapseText: 'Read less',
        maxLines: 4,
        linkColor: Colors.blue,
        animation: true,
        collapseOnTextTap: true,
        style: const TextStyle(
          overflow: TextOverflow.ellipsis,
          height: 1.38,
        ),
      ),
    );
  }
}
