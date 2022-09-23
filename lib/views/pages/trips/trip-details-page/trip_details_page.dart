import 'dart:convert';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:just_travel_admin/models/db-models/trip_model.dart';
import 'package:just_travel_admin/providers/trip_provider.dart';
import 'package:provider/provider.dart';
import '../../../../utils/constants/urls.dart';

class TripDetailsPage extends StatelessWidget {
  static const routeName = '/trip-details-page';
  final String id;

  const TripDetailsPage({required this.id, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.read<TripProvider>().getTripById(id);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Trip Details'),
      ),
      body: Center(
        child: FutureBuilder<TripModel?>(
          future: context.read<TripProvider>().getTripById(id),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              TripModel? trip = snapshot.data;
              return ListView(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListTile(
                      contentPadding: const EdgeInsets.all(0),
                      title: Text(
                        trip!.placeName!,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Text(
                        trip.city!,
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
                    itemCount: trip.photos!.length,
                    itemBuilder: (BuildContext context, int itemIndex,
                            int pageViewIndex) =>
                        Image.network(
                      '${baseUrl}uploads/${trip.photos![itemIndex]}',
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
                        Text(trip.description!),
                      ],
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
