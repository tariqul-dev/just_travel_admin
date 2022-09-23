import 'dart:convert';

import 'package:http/http.dart';
import '../models/db-models/hotel_model.dart';
import '../utils/constants/urls.dart';

class HotelApi {
  // requesting create hotel to api
  static Future<bool> createHotel(HotelModel hotelModel) async {
    var headers = {'Content-Type': 'application/json'};
    var request = Request('POST', Uri.parse('${baseUrl}hotels/create'));
    request.body = json.encode(hotelModel);
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

  // Delete
  static Future<void> deleteHotelById(String id) async {
    var request = Request('DELETE', Uri.parse('${baseUrl}hotels/delete/$id'));
    StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
    } else {
      print(response.reasonPhrase);
    }
  }

  /*
  *
  *========================= Query methods =============================*/

  // requesting fetching all hotels from api
  static Future<List<HotelModel>> getAllHotels() async {
    var request = Request('GET', Uri.parse('${baseUrl}hotels'));
    StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var enCodedDate = await response.stream.bytesToString();
      var data = json.decode(enCodedDate);

      List<HotelModel> hotelModel = List.generate(
        data.length,
        (index) => HotelModel.fromJson(data[index]),
      );
      return hotelModel;
    } else {
      print(response.reasonPhrase);
      return [];
    }
  }

  // fetching hotel by hotel id
  static Future<HotelModel?> getHotelById(String hotelId) async {
    var request = Request('GET', Uri.parse('${baseUrl}hotels/$hotelId'));
    StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var enCodedDate = await response.stream.bytesToString();
      var data = json.decode(enCodedDate);
      HotelModel hotel = HotelModel.fromJson(data);
      print('hotelApi: $hotel');
      return hotel;
    } else {
      print(response.reasonPhrase);
      return null;
    }
  }

  // fetching hotel by hotel city
  static Future<List<HotelModel>> getHotelByCity(String city) async {
    var request = Request('GET', Uri.parse('${baseUrl}hotels/city/$city'));
    StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var enCodedDate = await response.stream.bytesToString();
      var data = json.decode(enCodedDate);
      List<HotelModel> hotelModel = List.generate(
        data.length,
        (index) => HotelModel.fromJson(data[index]),
      );

      print('hotelApi: $hotelModel');
      return hotelModel;
    } else {
      print(response.reasonPhrase);
      return [];
    }
  }
}
