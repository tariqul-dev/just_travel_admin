import 'dart:convert';

import 'package:http/http.dart';

import '../models/db-models/trip_model.dart';
import '../utils/constants/urls.dart';

class RequestedTripApi {
  // fetching all requested trips
  static Future<List<TripModel>> getAllRequestedTrips() async {
    var request = Request('GET', Uri.parse('${baseUrl}trips/trips/requested'));
    StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var enCodedDate = await response.stream.bytesToString();
      var data = json.decode(enCodedDate);

      List<TripModel> tripModels = List.generate(
        data.length,
        (index) => TripModel.fromJson(data[index]),
      );
      print('jkasd: $tripModels');
      return tripModels;
    } else {
      print(response.reasonPhrase);
      return [];
    }
  }

  // accept trip
  static Future <bool> acceptTrip(String tripId) async{
    var request = Request('PATCH', Uri.parse('${baseUrl}trips/accept/$tripId'));


    StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
      return true;
    }
    else {
      print(response.reasonPhrase);
      return false;
    }

  }

  // reject trip
  static Future <bool> rejectTrip(String tripId) async{
    var request = Request('PATCH', Uri.parse('${baseUrl}trips/reject/$tripId'));


    StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
      return true;
    }
    else {
      print(response.reasonPhrase);
      return false;
    }


  }
}
