import 'package:flutter/material.dart';

import '../apis/join_trip_api.dart';
import '../models/db-models/join_model.dart';
import '../models/db-models/room_model.dart';
import '../models/db-models/trip_model.dart';
import '../models/db-models/user_model.dart';

class JoinTripProvider extends ChangeNotifier {
  List<num> numberOfTravelerList = [];
  List<UserModel> joinedUserList = [];

  num? totalCost;
  bool isJoined = false;

  void reset() {
    totalCost = null;
    notifyListeners();
  }

  // calculating total cost
  void costCalculate(TripModel trip, num numberOfTravellers, RoomModel? room) {
    if (room == null) {
      totalCost = trip.cost;
    } else {
      totalCost = ((trip.cost! * numberOfTravellers) + room.price!);
    }

    notifyListeners();
  }

  /*
   =============================== DB query =========================
  * */
  // join trip
  // Future<void> joinTrip({
  //   required TripModel trip,
  //   required RoomModel room,
  //   required UserModel user,
  //   required num numberOfTravellers,
  //   required PaymentModel paymentModel,
  // }) async {
  //   JoinModel joinModel = JoinModel(
  //     tripId: trip.id,
  //     roomId: room.id,
  //     userId: user.id,
  //     numberOfTravellers: numberOfTravellers,
  //     startDate: trip.startDate,
  //     endDate: trip.endDate,
  //     totalCost: totalCost,
  //   );
  //   print('trip join: $joinModel');
  //   isJoined = await JoinTripApi.joinTrip(joinModel, paymentModel);
  //   notifyListeners();
  // }

  // cancel trip
  Future<bool> cancelTrip(String userId, String tripId) async{
      return await JoinTripApi.cancelTrip(userId, tripId);
  }

  // fetch users in a trip by trip id
  Future<void> getUsersByTripId(String tripId) async {
    Map<String, dynamic> map = await JoinTripApi.getUsersByTripId(tripId);
    if (map.isNotEmpty) {
      joinedUserList = map['users'];
      numberOfTravelerList = map['numberOfTravellers'];
    }else{
      numberOfTravelerList = [];
      joinedUserList = [];
    }
    notifyListeners();
  }

  // count users in a trip by trip id
  Future<num> countUsersInTrip(String tripId) async {
    return await JoinTripApi.countUsersInTrip(tripId);
  }

  // fetch join trip info by user id and trip id
  Future<JoinModel?> getJoinDetailsByUserAndTrip(
    String userId,
    String tripId,
  ) async {
    return await JoinTripApi.getJoinDetailsByUserAndTrip(userId, tripId);
  }
}
