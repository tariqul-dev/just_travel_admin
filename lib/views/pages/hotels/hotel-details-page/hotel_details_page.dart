import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:just_travel_admin/models/db-models/room_model.dart';
import 'package:just_travel_admin/providers/room_provider.dart';
import 'package:just_travel_admin/views/pages/hotels/add-hotel-page/components/room_tiles.dart';
import 'package:just_travel_admin/views/pages/hotels/hotel-details-page/components/room_tiles.dart';
import 'package:just_travel_admin/views/pages/hotels/hotel-details-page/components/title_section.dart';
import 'package:just_travel_admin/views/widgets/image_slider.dart';
import 'package:just_travel_admin/views/pages/hotels/room-details-page/room_details_page.dart';
import 'package:provider/provider.dart';
import '../../../../models/db-models/hotel_model.dart';
import '../../../../providers/hotel_provider.dart';
import '../../../../utils/constants/urls.dart';

class HotelDetailsPage extends StatelessWidget {
  static const routeName = '/hotel-details-page';
  final String id;

  const HotelDetailsPage({required this.id, Key? key}) : super(key: key);

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
                  TitleSection(hotel: hotel!),
                  ImageSlider(photos: hotel.photos!),
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
                  HotelDetailsRoomTiles(hotelId: hotel.id!),
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
