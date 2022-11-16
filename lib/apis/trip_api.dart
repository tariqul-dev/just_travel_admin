import 'dart:convert';

import 'package:http/http.dart';
import '../models/db-models/trip_model.dart';
import '../utils/constants/urls.dart';

class TripApi {
  /*
  * ================== Insert ======================
  * */
  // requesting create hotel to api
  static Future<bool> createTrip(TripModel tripModel) async {
    var headers = {'Content-Type': 'application/json'};
    var request = Request('POST', Uri.parse('${baseUrl}trips/create'));
    request.body = json.encode(tripModel);
    request.headers.addAll(headers);
    try {
      StreamedResponse response = await request.send();
      if (response.statusCode == 201) {
        print('inserted: ${await response.stream.bytesToString()}');
        return true;
      } else {
        print('failed because: ${response.reasonPhrase}');
        return false;
      }
    } catch (e) {
      print('failed because: $e');
      return false;
    }
  }

  /*
  * ================== update ======================
  * */

  /*
  * ========== query ==========*/
  // fetch all trips
  static Future<List<TripModel>> getAllTrips() async {
    var request = Request('GET', Uri.parse('${baseUrl}trips'));
    StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var enCodedDate = await response.stream.bytesToString();
      var data = json.decode(enCodedDate);

      List<TripModel> tripModels = List.generate(
        data.length,
        (index) => TripModel.fromJson(data[index]),
      );
      return tripModels;
    } else {
      print(response.reasonPhrase);
      return [];
    }
  }

  //fetch notifiable trips
  static Future<List<TripModel>> getNotifiableTrips() async {
    var request =
        Request('GET', Uri.parse('${baseUrl}trips/notify/notifiable/trips'));
    StreamedResponse response = await request.send();
    // print('in api trip');
    if (response.statusCode == 200) {
      var enCodedDate = await response.stream.bytesToString();
      var data = json.decode(enCodedDate);

      List<TripModel> tripModels = List.generate(
        data.length,
        (index) => TripModel.fromJson(data[index]),
      );

      return tripModels;
    } else {
      print(response.reasonPhrase);
      return [];
    }
  }

  // fetching trip by trip id
  static Future<TripModel?> getTripByTripId(String tripId) async {
    var request = Request('GET', Uri.parse('${baseUrl}trips/$tripId'));
    StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var enCodedDate = await response.stream.bytesToString();
      var data = json.decode(enCodedDate);
      TripModel trip = TripModel.fromJson(data);
      return trip;
    } else {
      print(response.reasonPhrase);
      return null;
    }
  }

  // get trips by host
  static Future<List<TripModel>> getTripsByHost(String host) async {
    var request = Request('GET', Uri.parse('${baseUrl}trips/host/$host'));
    StreamedResponse response = await request.send();
    // print('in api trip');
    if (response.statusCode == 200) {
      var enCodedDate = await response.stream.bytesToString();
      var data = json.decode(enCodedDate);

      List<TripModel> tripModels = List.generate(
        data.length,
        (index) => TripModel.fromJson(data[index]),
      );

      return tripModels;
    } else {
      print(response.reasonPhrase);
      return [];
    }
  }

  // fetching trip by userId tripId
  static Future<TripModel?> getTripByUserIdTripId(
      String userId, String tripId) async {
    var request = Request('GET', Uri.parse('${baseUrl}join/$userId/$tripId'));

    try {
      StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        var encodedData = await response.stream.bytesToString();
        var decodedData = jsonDecode(encodedData);
        TripModel trip = TripModel.fromJson(decodedData[0]['tripId']);
        // print('trip found');
        return trip;
      } else {
        print(response.reasonPhrase);
        throw Error();
      }
    } catch (e) {
      print('failed because: $e');
      return null;
    }
  }

  // notify users by trip id
  static Future<bool> notifyUsersByTripId(
    String tripId,
    String message,
  ) async {
    var headers = {'Content-Type': 'application/json'};
    var request =
        Request('POST', Uri.parse('${baseUrl}join/notify/$tripId'));
    request.body = json.encode({"message": message});
    request.headers.addAll(headers);

    StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
      return true;
    } else {
      print(response.reasonPhrase);
      return false;
    }
  }
}
