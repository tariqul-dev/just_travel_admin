import 'package:flutter/material.dart';
import 'package:just_travel_admin/models/db-models/trip_model.dart';
import 'package:just_travel_admin/providers/hotel_provider.dart';
import 'package:just_travel_admin/providers/trip_provider.dart';
import 'package:just_travel_admin/utils/constants/urls.dart';
import 'package:just_travel_admin/utils/helper_functions.dart';
import 'package:just_travel_admin/views/pages/trips/add-trips-page/add_trips_page.dart';
import 'package:just_travel_admin/views/pages/trips/trip-details-page/trip_details_page.dart';
import 'package:just_travel_admin/views/widgets/dialogs/confirm_dialog.dart';
import 'package:just_travel_admin/views/widgets/loading_widget.dart';
import 'package:provider/provider.dart';

import '../../../../providers/districts_provider.dart';
import '../../../widgets/network_image_loader.dart';

class TripsPage extends StatelessWidget {
  static const routeName = '/trips';

  const TripsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Trips'),
        actions: [
          IconButton(
            onPressed: () {
              context.read<TripProvider>().getAllTrips();
            },
            icon: const Icon(Icons.refresh),
          ),
        ],
      ),
      body: Center(
        child: Consumer<TripProvider>(
          builder: (context, tripProvider, child) {
            List<TripModel> tripList = tripProvider.tripList;
            return tripList.isEmpty
                ? const Text('No Trip added')
                : ListView.builder(
                    itemCount: tripList.length,
                    itemBuilder: (context, index) {
                      TripModel trip = tripList[index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                        ),
                        child: ListTile(
                          onTap: () {
                            Navigator.pushNamed(
                                context, TripDetailsPage.routeName,
                                arguments: trip.id);
                          },
                          contentPadding:
                              const EdgeInsets.symmetric(vertical: 5),
                          leading: SizedBox(
                            width: 50,
                            height: 100,
                            child:
                                trip.photos != null && trip.photos!.isNotEmpty
                                    ? NetworkImageLoader(
                                        image:
                                            '${baseUrl}uploads/${trip.photos![0]}',
                                        width: 50,
                                        height: 100,
                                      )
                                    : Image.asset(
                                        'images/img.png',
                                        width: 50,
                                        height: 100,
                                      ),
                          ),
                          title: Text(trip.placeName!),
                          subtitle: Row(
                            children: [
                              Text(
                                getFormattedDateTime(
                                    dateTime: trip.startDate!,
                                    pattern: 'MMM dd yyyy'),
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              Text(
                                getFormattedDateTime(
                                    dateTime: trip.endDate!,
                                    pattern: 'MMM dd yyyy'),
                              ),
                            ],
                          ),
                          // trailing: Row(
                          //   mainAxisSize: MainAxisSize.min,
                          //   children: [
                          //     // edit button
                          //     IconButton(
                          //       onPressed: () {
                          //         // Navigator.pushNamed(
                          //         //     context, AddHotelPage.routeName,
                          //         //     arguments: hotel);
                          //       },
                          //       icon: const Icon(Icons.edit),
                          //     ),
                          //
                          //     //delete button
                          //     IconButton(
                          //       onPressed: () {
                          //         confirmDialog(
                          //           context,
                          //           'Delete',
                          //           (isConfirmed) {
                          //             if (isConfirmed) {
                          //               showLoadingDialog(context);
                          //               // hotelProvider
                          //               //     .deleteHotelById(hotel.id!)
                          //               //     .then(
                          //               // (value) => Navigator.pop(context),
                          //               // )
                          //               //     .onError(
                          //               // (error, stackTrace) => showMsg(
                          //               // context, error.toString()),
                          //               // );
                          //             }
                          //           },
                          //         );
                          //       },
                          //       icon: const Icon(
                          //         Icons.delete,
                          //         color: Colors.red,
                          //       ),
                          //     ),
                          //   ],
                          // ),
                        ),
                      );
                    },
                  );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.read<DistrictsProvider>().getAllDivision();
          Navigator.pushNamed(context, AddTripsPage.routeName);

          Navigator.pushNamed(context, AddTripsPage.routeName);
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
