import 'dart:convert';

import 'package:http/http.dart';
import 'package:just_travel_admin/models/db-models/payment_model.dart';

import '../utils/constants/urls.dart';

class PaymentApi {
  // fetch all payment info
  static Future<List<PaymentModel>> fetchAllPaymentInfo() async {
    var request = Request('GET', Uri.parse('${baseUrl}payment'));

    try {
      StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        // print(await response.stream.bytesToString());
        var encodedData = await response.stream.bytesToString();
        var decodedData = jsonDecode(encodedData);

        return List.generate(decodedData.length,
            (index) => PaymentModel.fromJson(decodedData[index]));
      } else {
        throw response.reasonPhrase.toString();
      }
    } catch (e) {
      print('failed because: $e');
      return [];
    }
  }

  // fetch payment info by trip id
  static Future<List<PaymentModel>> fetchPaymentsByTripId(String tripId) async {
    var request = Request('GET', Uri.parse('${baseUrl}payment/trip/get/$tripId'));

    try {
      StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        // print(await response.stream.bytesToString());
        var encodedData = await response.stream.bytesToString();
        var decodedData = jsonDecode(encodedData);

        return List.generate(decodedData.length,
            (index) => PaymentModel.fromJson(decodedData[index]));
      } else {
        throw response.reasonPhrase.toString();
      }
    } catch (e) {
      print('failed because: $e');
      return [];
    }
  }

  // fetch all payment info by user id
  static Future<List<PaymentModel>> fetchPaymentsByUserId(String userId) async {
    var request = Request('GET', Uri.parse('${baseUrl}payment/user/get/$userId'));

    try {
      StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        // print(await response.stream.bytesToString());
        var encodedData = await response.stream.bytesToString();
        var decodedData = jsonDecode(encodedData);

        return List.generate(decodedData.length,
            (index) => PaymentModel.fromJson(decodedData[index]));
      } else {
        throw response.reasonPhrase.toString();
      }
    } catch (e) {
      print('failed because: $e');
      return [];
    }
  }

  // fetch payment info transaction id
  static Future<PaymentModel?> fetchPaymentByTranId(String tranId) async {
    var request = Request('GET', Uri.parse('${baseUrl}payment/$tranId'));

    try {
      StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        // print(await response.stream.bytesToString());
        var encodedData = await response.stream.bytesToString();
        var decodedData = jsonDecode(encodedData);

        return PaymentModel.fromJson(decodedData);
      } else {
        throw response.reasonPhrase.toString();
      }
    } catch (e) {
      print('failed because: $e');
      return null;
    }
  }
}
