import 'dart:convert';

import 'package:http/http.dart';

import '../constants/urls.dart';
import '../models/db-models/trip_model.dart';

class TripApi{
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
  * ========== query ==========*/
  static Future<List<TripModel>> getAllTrips() async {
    print('in api trip');
    var request = Request('GET', Uri.parse('${baseUrl}trips'));
    StreamedResponse response = await request.send();
    print('in api trip');
    if (response.statusCode == 200) {
      var enCodedDate = await response.stream.bytesToString();
      var data = json.decode(enCodedDate);

      List<TripModel> tripModels = List.generate(
        data.length,
            (index) => TripModel.fromJson(data[index]),
      );

      print(tripModels);
      return tripModels;
    } else {
      print(response.reasonPhrase);
      return [];
    }
  }
}