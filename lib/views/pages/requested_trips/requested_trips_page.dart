import 'package:flutter/material.dart';
import 'package:just_travel_admin/models/db-models/trip_model.dart';
import 'package:just_travel_admin/providers/requested_trips_provider.dart';
import 'package:provider/provider.dart';

import '../../../utils/constants/urls.dart';
import '../../../utils/helper_functions.dart';
import '../../widgets/dialogs/confirm_dialog.dart';
import '../../widgets/loading_widget.dart';
import '../../widgets/network_image_loader.dart';
import '../trips/trip-details-page/trip_details_page.dart';

class RequestedTripsPage extends StatelessWidget {
  static const routeName = '/requested_trips';

  const RequestedTripsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Future.delayed(
      Duration.zero,
      () {
        context.read<RequestedTripProvider>().getAllRequestedTrips();
      },
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Requested Trips'),
      ),
      body: Center(
        child: Consumer<RequestedTripProvider>(
          builder: (context, reqTripProvider, child) {
            List<TripModel> tripList = reqTripProvider.requestedTripList;
            return tripList.isEmpty
                ? const Text('No Trip added')
                : ListView.builder(
                    itemCount: tripList.length,
                    itemBuilder: (context, index) {
                      TripModel trip = tripList[index];
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ListTile(
                          onTap: () {
                            Navigator.pushNamed(
                                context, TripDetailsPage.routeName,
                                arguments: trip.id);
                          },
                          contentPadding: const EdgeInsets.symmetric(vertical: 5),
                          leading: SizedBox(
                            width: 50,
                            height: 100,
                            child: trip.photos != null && trip.photos!.isNotEmpty
                                ? NetworkImageLoader(
                                    image: '${baseUrl}uploads/${trip.photos![0]}',
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
                          subtitle: Text(
                              getFormattedDateTime(dateTime: trip.startDate!)),
                          trailing: trip.status == 'pending'
                              ? Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    IconButton(
                                      onPressed: () {
                                        context
                                            .read<RequestedTripProvider>()
                                            .rejectTrip(trip.id!);
                                      },
                                      icon: const Icon(Icons.cancel),
                                      color: Colors.red,
                                      tooltip: 'Reject',
                                    ),
                                    IconButton(
                                      onPressed: () {
                                        context
                                            .read<RequestedTripProvider>()
                                            .acceptTrip(trip.id!);
                                      },
                                      icon: const Icon(Icons.beenhere_outlined),
                                      color: Colors.green,
                                      tooltip: 'Accept',
                                    ),
                                  ],
                                )
                              : Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text('${trip.status}'),
                              ),

                          // TextButton(
                          //   onPressed: () {
                          //     if (trip.status == 'accepted'){
                          //       context.read<RequestedTripProvider>().rejectTrip(trip.id!);
                          //     }else{
                          //       context.read<RequestedTripProvider>().acceptTrip(trip.id!);
                          //     }
                          //   },
                          //   child: Text('${trip.status}'),
                          // ),
                        ),
                      );
                    },
                  );
          },
        ),
      ),
    );
  }
}
