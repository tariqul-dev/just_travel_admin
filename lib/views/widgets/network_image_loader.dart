import 'package:flutter/material.dart';

class NetworkImageLoader extends StatelessWidget {
  final String image;
  double? height, width;
  NetworkImageLoader({required this.image, this.height, this.width, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image.network(
      image,
      height: height,
      width: width,
      fit: BoxFit.cover,
      loadingBuilder: (BuildContext context, Widget child,
          ImageChunkEvent? loadingProgress) {
        if (loadingProgress == null) return child;
        return Center(
          child: CircularProgressIndicator(
            value: loadingProgress.expectedTotalBytes != null
                ? loadingProgress.cumulativeBytesLoaded /
                loadingProgress.expectedTotalBytes!
                : null,
          ),
        );
      },
    );
  }
}
