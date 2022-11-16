import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'network_image_loader.dart';

class ProfileCircularImage extends StatelessWidget {
  double radius, height, width;
  final String image;
  ProfileCircularImage(
      {required this.image,
      this.height = 50,
      this.width = 50,
      this.radius = 50,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  CircleAvatar(
      radius: radius,
      child: ClipRRect(
        clipBehavior: Clip.antiAlias,
        borderRadius: BorderRadius.circular(radius),
        child: NetworkImageLoader(
          image: image,
          width: width,
          height: height,
        )
      ),
    );
  }
}
