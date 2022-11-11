import 'package:flutter/material.dart';
import 'package:just_travel_admin/apis/requested_trip_api.dart';
import 'package:just_travel_admin/models/db-models/trip_model.dart';

class RequestedTripProvider extends ChangeNotifier{
  List<TripModel> requestedTripList = [];
  // fetching all requested trips
  Future<void> getAllRequestedTrips() async{
    requestedTripList = await RequestedTripApi.getAllRequestedTrips();
    notifyListeners();
  }
  // accept requested trips
  Future<void> acceptTrip(String tripId) async{
    bool isAccepted = await RequestedTripApi.acceptTrip(tripId);
    if (isAccepted){
      getAllRequestedTrips();
    }
  }
  // reject requested trips
  Future<void> rejectTrip(String tripId) async{
    bool isRejected = await RequestedTripApi.rejectTrip(tripId);
    if (isRejected){
      getAllRequestedTrips();
    }
  }
}