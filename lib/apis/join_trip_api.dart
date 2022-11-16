import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';

import '../models/db-models/join_model.dart';
import '../models/db-models/user_model.dart';
import '../utils/constants/urls.dart';

class JoinTripApi {
  // join trip
  // static Future<bool> joinTrip(
  //     JoinModel joinModel, PaymentModel paymentModel) async {
  //   var headers = {'Content-Type': 'application/json'};
  //   var request = Request('POST', Uri.parse('${baseUrl}join/join'));
  //   var joinJson = {
  //     'joinTrip': joinModel.toJson(),
  //     'payment': paymentModel.toJson(),
  //   };
  //   request.body = json.encode(joinJson);
  //   request.headers.addAll(headers);
  //   try {
  //     StreamedResponse response = await request.send();
  //
  //     if (response.statusCode == 200) {
  //       // print(await response.stream.bytesToString());
  //       return true;
  //     } else {
  //       print(response.reasonPhrase);
  //       throw Error();
  //     }
  //   } catch (e) {
  //     print('failed because: $e');
  //     return false;
  //   }
  // }

  // cancel trip
  static Future<bool> cancelTrip(String userId, String tripId) async {
    var request = Request(
      'PATCH',
      Uri.parse('${baseUrl}join/cancel/$userId/$tripId'),
    );

    try {
      StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        debugPrint(await response.stream.bytesToString());
        return true;
      } else {
        throw response.reasonPhrase.toString();
      }
    } catch (e) {
      print('failed because: $e');
      return false;
    }
  }

  // fetch users in a trip by trip id
  static Future<Map<String, dynamic>> getUsersByTripId(String tripId) async {
    var request =
        Request('GET', Uri.parse('${baseUrl}join/users/trip/$tripId'));

    try {
      StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        var encodedData = await response.stream.bytesToString();
        var decodedData = jsonDecode(encodedData);

        List<UserModel> users = List.generate(decodedData.length,
            (index) => UserModel.fromJson(decodedData[index]['userId']));

        List<num> numberOfTravelers = List.generate(decodedData.length,
            (index) => decodedData[index]['numberOfTravellers']);

        return {
          'users': users,
          'numberOfTravellers': numberOfTravelers,
        };
      } else {
        throw response.reasonPhrase.toString();
      }
    } catch (e) {
      print('failed because: $e');
      return {};
    }
  }

  // fetch join trip info by user id and trip id
  static Future<JoinModel?> getJoinDetailsByUserAndTrip(
    String userId,
    String tripId,
  ) async {
    var request =
        Request('GET', Uri.parse('${baseUrl}join/join/$userId/$tripId'));

    try {
      StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        var encodedData = await response.stream.bytesToString();
        var decodedData = jsonDecode(encodedData);
        JoinModel joinModel = JoinModel.fromJson(decodedData);
        return joinModel;
      } else {
        throw response.reasonPhrase.toString();
      }
    } catch (e) {
      print('failed because: $e');
      return null;
    }
  }

  // count joined users in a trip by trip id
  static Future<num> countUsersInTrip(String tripId) async {
    var request =
        Request('GET', Uri.parse('${baseUrl}join/users/count/trip/$tripId'));

    try {
      StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        num userCount = jsonDecode(await response.stream.bytesToString());
        return userCount;
      } else {
        print(response.reasonPhrase);
        throw Error();
      }
    } catch (e) {
      print('failed because: $e');
      return 0;
    }
  }
}
