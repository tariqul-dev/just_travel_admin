import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../models/db-models/trip_model.dart';
import '../../../providers/trip_provider.dart';
import '../../../utils/constants/urls.dart';
import '../../../utils/helper_functions.dart';
import '../../widgets/network_image_loader.dart';
import '../trips/trip-details-page/trip_details_page.dart';
import 'dialog/send_email_dialog.dart';

class NotifiableTripsPage extends StatelessWidget {
  static const routeName = '/upcoming-trips';

  const NotifiableTripsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Future.delayed(
      Duration.zero,
      () {
        context.read<TripProvider>().getNotifiableTrips();
      },
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Upcoming Trips'),
        actions: [
          IconButton(
            onPressed: () {
              context.read<TripProvider>().getNotifiableTrips();
            },
            icon: const Icon(Icons.refresh),
          ),
        ],
      ),
      body: Center(
        child: Consumer<TripProvider>(
          builder: (context, tripProvider, child) {
            List<TripModel> tripList = tripProvider.upNotifiableTripList;
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
                        child: Card(
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
                            trailing: IconButton(
                              onPressed: () {
                                sendEmailDialog(
                                    context: context, tripId: trip.id!);
                              },
                              icon: const Icon(Icons.email_outlined),
                            ),
                          ),
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
