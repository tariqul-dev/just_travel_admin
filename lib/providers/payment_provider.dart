import 'package:flutter/material.dart';
import 'package:just_travel_admin/apis/payment_api.dart';
import 'package:just_travel_admin/models/db-models/payment_model.dart';

class PaymentProvider extends ChangeNotifier{
  List<PaymentModel> allPaymentList = [];
  // fetch all payment info
  Future<void> fetchAllPaymentInfo() async{
      allPaymentList = await PaymentApi.fetchAllPaymentInfo();
      notifyListeners();
  }
}