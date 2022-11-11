import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../models/db-models/room_model.dart';
import '../../../../../models/db-models/trip_model.dart';
import '../../../../../providers/join_trip_provider.dart';

class JoinTravelersCard extends StatelessWidget {
  RoomModel? roomModel;
  final TripModel tripModel;
  VoidCallback? onShowTravelers;
  JoinTravelersCard({ required this.tripModel, required this.roomModel, required this.onShowTravelers, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 100,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
      ),
      child: Card(
        elevation: 10,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Joined Travelers',
                    style: Theme.of(context)
                        .textTheme
                        .headline3!
                        .copyWith(fontSize: 17),
                  ),
                  Row(
                    children: [



                      FutureBuilder(
                        future: context.read<JoinTripProvider>().countUsersInTrip(tripModel.id!),
                        builder: (context, snapshot) {
                          if (snapshot.hasData){
                            return  Text(
                              '${snapshot.data}',
                              style: Theme.of(context)
                                  .textTheme
                                  .headline5!
                                  .copyWith(fontSize: 18, fontWeight: FontWeight.w600),
                            );
                          }

                          if (snapshot.hasError){
                           return Text(
                              'Server Error',
                              style: Theme.of(context)
                                  .textTheme
                                  .headline5!
                                  .copyWith(fontSize: 18, fontWeight: FontWeight.w600),
                            );
                          }

                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        },
                      ),
                    ],
                  ),
                ],
              ),
              Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                        vertical: 20, horizontal: 30),
                    shape: const StadiumBorder(),
                  ),
                  onPressed: onShowTravelers,
                  child: const Text('DETAILS'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
