import 'package:flutter/material.dart';

import '../apis/review_api.dart';
import '../models/db-models/review_model.dart';

class ReviewProvider extends ChangeNotifier {

  List<ReviewModel> reviewList = [];

  /*
  * ============= Insert operation start ============
  * */
  // add new review
  Future<bool> addReview({
    required String tripId,
    required String userId,
    required String review,
  }) async {
    ReviewModel reviewModel =
        ReviewModel(trip: tripId, user: userId, review: review);

    bool isSuccess = await ReviewApi.addReview(reviewModel);
    getAllReviewByTripId(tripId);
    return isSuccess;
  }

  /*
  * ============= Insert operation end ============
  * */

  /*
  * ============= Query operation start ============
  * */

  // get all review by trip id
  Future<void> getAllReviewByTripId(String tripId) async{
    reviewList = await ReviewApi.getAllReviewByTripId(tripId);
    notifyListeners();

  }

  // check eligibility user to review trip
  Future<bool> checkEligibilityReview(String userId, String tripId) async{
    return await ReviewApi.checkEligibilityReview(userId, tripId);
  }

  /*
  * ============= Query operation start ============
  * */

}
