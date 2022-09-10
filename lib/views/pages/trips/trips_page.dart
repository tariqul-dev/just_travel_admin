import 'package:flutter/material.dart';
import 'package:just_travel_admin/views/pages/trips/trip_details_page.dart';
import 'package:provider/provider.dart';
import '../../../models/db-models/trip_model.dart';
import '../../../providers/trip_provider.dart';
import '../../../utils/constants/urls.dart';
import '../../../utils/dialogs/confirm_dialog.dart';
import '../../../utils/helper_functions.dart';
import '../../widgets/loading_widget.dart';
import 'add_trips_page.dart';

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
                      return ListTile(
                        onTap: () {
                          Navigator.pushNamed(
                              context, TripDetailsPage.routeName,
                              arguments: trip.id);
                        },
                        contentPadding: const EdgeInsets.symmetric(vertical: 5),
                        leading: trip.photos != null && trip.photos!.isNotEmpty
                            ? Image.network(
                                '${baseUrl}uploads/${trip.photos![0]}',
                                height: 100,
                                // width: 100,
                                fit: BoxFit.cover,
                              )
                            : Image.asset('images/img.png'),
                        title: Text(trip.placeName!),
                        subtitle: Text(getFormattedDateTime(dateTime: trip.schedule!)),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            // edit button
                            IconButton(
                              onPressed: () {
                                // Navigator.pushNamed(
                                //     context, AddHotelPage.routeName,
                                //     arguments: hotel);
                              },
                              icon: const Icon(Icons.edit),
                            ),

                            //delete button
                            IconButton(
                              onPressed: () {
                                confirmDialog(
                                  context,
                                  'Delete',
                                  (isConfirmed) {
                                    if (isConfirmed) {
                                      showLoadingDialog(context);
                                      // hotelProvider
                                      //     .deleteHotelById(hotel.id!)
                                      //     .then(
                                      // (value) => Navigator.pop(context),
                                      // )
                                      //     .onError(
                                      // (error, stackTrace) => showMsg(
                                      // context, error.toString()),
                                      // );
                                    }
                                  },
                                );
                              },
                              icon: const Icon(
                                Icons.delete,
                                color: Colors.red,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, AddTripsPage.routeName);
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
