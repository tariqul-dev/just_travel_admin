import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import '../../utils/constants/urls.dart';
import 'network_image_loader.dart';

class ImageSlider extends StatelessWidget {
  final List<String> photos;
  double height;
  ImageSlider({required this.photos, this.height = 200, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CarouselSlider.builder(
      itemCount: photos.length,
      itemBuilder: (
          BuildContext context,
          int itemIndex,
          int pageViewIndex,
          ) {
        return ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: NetworkImageLoader(
            image: '${baseUrl}uploads/${photos[itemIndex]}',
            height: height,
            width: MediaQuery.of(context).size.width,
          ),
          // child: Image.network(
          //   '${baseUrl}uploads/${photos[itemIndex]}',
          //   fit: BoxFit.cover,
          //   height: height,
          //   width: MediaQuery.of(context).size.width,
          // ),
        );
      },
      options: CarouselOptions(
        height: height,
        aspectRatio: 16 / 9,
        viewportFraction: 0.7,
        initialPage: 0,
        enableInfiniteScroll: true,
        reverse: false,
        autoPlay: true,
        autoPlayInterval: const Duration(seconds: 3),
        autoPlayAnimationDuration: const Duration(milliseconds: 800),
        autoPlayCurve: Curves.fastOutSlowIn,
        enlargeCenterPage: true,
        scrollDirection: Axis.horizontal,
      ),
    );
  }
}
