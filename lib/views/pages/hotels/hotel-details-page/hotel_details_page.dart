import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:just_travel_admin/providers/room_provider.dart';
import 'package:just_travel_admin/views/pages/hotels/hotel-details-page/components/room_tiles.dart';
import 'package:just_travel_admin/views/pages/hotels/hotel-details-page/components/title_section.dart';
import 'package:just_travel_admin/views/widgets/image_slider.dart';
import 'package:provider/provider.dart';
import '../../../../models/db-models/hotel_model.dart';
import '../../../../providers/hotel_provider.dart';

class HotelDetailsPage extends StatelessWidget {
  static const routeName = '/hotel-details-page';
  final String id;

  const HotelDetailsPage({required this.id, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.read<HotelProvider>().getHotelById(id);
    return WillPopScope(
      onWillPop: () async{
        context.read<RoomProvider>().reset();
        return true;
      },
      child: Scaffold(
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
                    // hotel title section
                    TitleSection(hotel: hotel!),

                    // image slider
                    ImageSlider(photos: hotel.photos!),

                    // hotel about
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text('About', style: Theme.of(context).textTheme.headline6!.copyWith(
                            fontSize: 14
                          ),),
                          ExpandableText(
                            hotel.description!, expandText: 'Read More',
                            collapseText: 'Read less',
                            maxLines: 3,

                          ),
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
      ),
    );
  }
}
