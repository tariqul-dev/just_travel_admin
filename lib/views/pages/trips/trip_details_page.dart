import 'dart:convert';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../constants/urls.dart';
import '../../../models/db-models/hotel_model.dart';
import '../../../providers/hotel_provider.dart';
import '../../../providers/room_provider.dart';
import '../hotels/room_details_page.dart';

class TripDetailsPage extends StatelessWidget {
  static const routeName = '/trip-details-page';
  final String id;
  const TripDetailsPage({required this.id, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.read<HotelProvider>().getHotelById(id);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hotel Details'),
      ),
      body: Center(
        child: FutureBuilder<HotelModel?>(
          future: context.read<HotelProvider>().getHotelById(id),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              HotelModel? hotel = snapshot.data;
              return ListView(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListTile(
                      contentPadding: const EdgeInsets.all(0),
                      title: Text(
                        hotel!.name!,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Text(
                        hotel.type!,
                        style: const TextStyle(
                          fontSize: 13,
                        ),
                      ),
                      trailing: IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.edit),
                      ),
                    ),
                  ),
                  CarouselSlider.builder(
                    itemCount: hotel.photos!.length,
                    itemBuilder: (BuildContext context, int itemIndex,
                            int pageViewIndex) =>
                        Image.network(
                      '${baseUrl}uploads/${hotel.photos![itemIndex]}',
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
                      autoPlayAnimationDuration:
                          const Duration(milliseconds: 800),
                      autoPlayCurve: Curves.fastOutSlowIn,
                      enlargeCenterPage: true,
                      scrollDirection: Axis.horizontal,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const Text('About'),
                        Text(hotel.name!),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  // room section
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: hotel.rooms!.isEmpty
                        ? const Text('No room added')
                        : ListView.builder(
                      itemCount: hotel.rooms!.length,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) => ListTile(
                        onTap: () {
                          Navigator.pushNamed(context, RoomDetailsPage.routeName, arguments: hotel.rooms![index]);
                        },

                        contentPadding: const EdgeInsets.all(0),
                        leading: Image.network(
                          '${baseUrl}uploads/${hotel.rooms![index].photos![0]}',
                          height: 100,
                          width: 100,
                          fit: BoxFit.cover,
                        ),
                        title: Text(hotel.rooms![index].title!),
                        subtitle: Text(hotel.rooms![index].status!),
                        trailing:
                        Text(hotel.rooms![index].price!.toString()),
                      ),
                    ),
                  ),

                ],
              );
            } else if (snapshot.hasError) {
              return const Text('Hotel not found');
            }
            //
            return const CircularProgressIndicator();
          },
        ),
      ),
    );
  }
}
