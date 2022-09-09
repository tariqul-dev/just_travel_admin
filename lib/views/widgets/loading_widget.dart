import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

showLoadingDialog(BuildContext context) {
  showCupertinoDialog(
    context: context,
    builder: (context) => LoadingAnimationWidget.fourRotatingDots(
      size: 50,
      color: Colors.red,
    ),
  );
}
