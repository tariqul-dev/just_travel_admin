import 'dart:convert';

import 'package:http/http.dart';

import '../models/db-models/join_model.dart';
import '../models/db-models/review_model.dart';
import '../utils/constants/urls.dart';

class ReviewApi {
  // add new review
  static Future<bool> addReview(ReviewModel reviewModel) async {
    var headers = {'Content-Type': 'application/json'};
    var request = Request('POST', Uri.parse('${baseUrl}review'));
    request.body = json.encode(reviewModel.toJson());
    request.headers.addAll(headers);
    try {
      StreamedResponse response = await request.send();

      if (response.statusCode == 201) {
        // print(await response.stream.bytesToString());
        return true;
      } else {
        throw response.reasonPhrase.toString();
      }
    } catch (e) {
      print('failed because: $e');
      return false;
    }
  }

  // get all review by trip id
  static Future<List<ReviewModel>> getAllReviewByTripId(String tripId) async {
    var request = Request('GET', Uri.parse('${baseUrl}review/$tripId'));

    try {
      StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        List<dynamic> source =
            jsonDecode(await response.stream.bytesToString());

        List<ReviewModel> reviews = List.generate(
          source.length,
          (index) => ReviewModel.fromJson(source[index]),
        );

        return reviews;
      } else {
        throw response.reasonPhrase.toString();
      }
    } catch (e) {
      print('failed because: $e');
      return [];
    }
  }

  // check eligibility user to review trip
  static Future<bool> checkEligibilityReview(
      String userId, String tripId) async {
    var request = Request('GET', Uri.parse('${baseUrl}review/$userId/$tripId'));

    try {
      StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        var source = jsonDecode(await response.stream.bytesToString());

        JoinModel joinModel = JoinModel.fromJson(source);
        print('eligible: $joinModel');
        return true;
      } else {
        throw response.reasonPhrase.toString();
      }
    } catch (e) {
      print('failed because: $e');
      return false;
    }
  }
}
