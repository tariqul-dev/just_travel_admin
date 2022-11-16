import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../models/db-models/room_model.dart';
import '../../../../models/db-models/trip_model.dart';
import '../../../../providers/hotel_provider.dart';
import '../../../../providers/join_trip_provider.dart';
import '../../../../providers/room_provider.dart';
import '../../../../providers/trip_provider.dart';
import '../../../widgets/expandable_text_widget.dart';
import '../../../widgets/image_grid_view.dart';
import 'components/cover_photo.dart';
import 'components/hotel_list_tile.dart';
import 'components/join_card.dart';
import 'components/review.dart';
import 'components/trip_title_card.dart';
import 'dialog/show_travelers_dialog.dart';

// ignore: must_be_immutable
class TripDetailsPage extends StatelessWidget {
  static const routeName = '/request-trips-page/host-trip-details-page';
  final String tripId;
  TripDetailsPage({required this.tripId, Key? key}) : super(key: key);
  RoomModel? roomModel;
  num? numberOfTravellers;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        context.read<TripProvider>().reset();
        context.read<JoinTripProvider>().reset();
        context.read<RoomProvider>().reset();
        context.read<HotelProvider>().reset();
        return true;
      },
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          title: const Text('Details'),
          elevation: 0,
        ),
        body: SafeArea(
          child: Center(
            child: FutureBuilder<TripModel?>(
              future: context.read<TripProvider>().getTripByTripId(tripId),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  TripModel? trip = snapshot.data;
                  // context.read<JoinTripProvider>().costCalculate(trip!, 1, null);
                  context.read<HotelProvider>().getHotelById(trip!.hotel!);
                  return ListView(
                    padding: const EdgeInsets.all(0),
                    children: [
                      // cover image
                      CoverPhoto(imagePath: trip.photos![0]),

                      // trip title card
                      TripTitleCard(trip: trip),

                      // trip plan
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'Trip Plan',
                          style: Theme.of(context).textTheme.headline6,
                        ),
                      ),
                      ExpandableTextWidget(text: trip.description!),

                      //  trip images grid
                      ImageGridView(imageList: trip.photos!),

                      // hotel
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Text(
                              'Hotel Details',
                              style: Theme.of(context).textTheme.headline6,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            HotelListTile(
                              trip: trip,
                              onSelectRoom: (roomModel, numberOfTravellers) {
                                this.roomModel = roomModel;
                                this.numberOfTravellers = numberOfTravellers;
                                context.read<JoinTripProvider>().costCalculate(
                                    trip, numberOfTravellers, roomModel);
                              },
                              // onSelectRoom: (roomModel, t) {
                              //
                              // },
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                          ],
                        ),
                      ),

                      // JOIN Card
                      JoinTravelersCard(
                        tripModel: trip,
                        roomModel: roomModel,
                        onShowTravelers: () {
                          context
                              .read<JoinTripProvider>()
                              .getUsersByTripId(trip.id!);
                          showTravelersDialog(context: context);
                        },
                      ),

                      // package review
                      Review(tripId: tripId),
                    ],
                  );
                } else if (snapshot.hasError) {
                  return const Text('Trip not found');
                }

                return const CircularProgressIndicator();
              },
            ),
          ),
        ),
      ),
    );
  }
}
