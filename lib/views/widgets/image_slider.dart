import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:just_travel_admin/utils/constants/urls.dart';

class ImageSlider extends StatelessWidget {
  final List<String> photos;
  const ImageSlider({required this.photos, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CarouselSlider.builder(
      itemCount: photos.length,
      itemBuilder: (BuildContext context, int itemIndex, int pageViewIndex) =>
          Image.network(
        '${baseUrl}uploads/${photos[itemIndex]}',
      ),
      options: CarouselOptions(
        height: 200,
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
