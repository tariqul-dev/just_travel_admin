import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import '../../utils/constants/urls.dart';
import 'network_image_loader.dart';

class ImageGridView extends StatelessWidget {
  final List<String> imageList;
  const ImageGridView({required this.imageList, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: StaggeredGrid.count(
        crossAxisCount: 4,
        mainAxisSpacing: 4,
        crossAxisSpacing: 4,
        children: [
          StaggeredGridTile.count(
            crossAxisCellCount: 2,
            mainAxisCellCount: 2,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: NetworkImageLoader(image: '${baseUrl}uploads/${imageList[1]}'),
              // child: Image.network(
              //   '${baseUrl}uploads/${imageList[1]}',
              //   fit: BoxFit.cover,
              // ),
            ),
          ),
          StaggeredGridTile.count(
            crossAxisCellCount: 2,
            mainAxisCellCount: 1,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: NetworkImageLoader(image: '${baseUrl}uploads/${imageList[2]}'),
              // child: Image.network(
              //   '${baseUrl}uploads/${imageList[2]}',
              //   fit: BoxFit.cover,
              // ),
            ),
          ),
          StaggeredGridTile.count(
            crossAxisCellCount: 1,
            mainAxisCellCount: 1,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: NetworkImageLoader(image: '${baseUrl}uploads/${imageList[3]}'),
              // child: Image.network(
              //   '${baseUrl}uploads/${imageList[3]}',
              //   fit: BoxFit.cover,
              // ),
            ),
          ),
          StaggeredGridTile.count(
            crossAxisCellCount: 1,
            mainAxisCellCount: 1,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: NetworkImageLoader(image: '${baseUrl}uploads/${imageList[0]}'),
              // child: Image.network(
              //   '${baseUrl}uploads/${imageList[0]}',
              //   fit: BoxFit.cover,
              // ),
            ),
          ),
        ],
      ),
    );
  }
}
