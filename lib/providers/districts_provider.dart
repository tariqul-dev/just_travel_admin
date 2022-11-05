import 'package:flutter/material.dart';

import '../apis/districts_api.dart';
import '../models/db-models/districts_model.dart';
import '../models/db-models/divisions_model.dart';

class DistrictsProvider extends ChangeNotifier {
  List<DistrictsModel> districtsList = [];
  List<DivisionsModel> divisionsList = [];
  DistrictsModel? district;
  DivisionsModel? division;

  setDistrictFromDropDown(value) {
    district = value;
    notifyListeners();
  }

  setDivisionFromDropDown(value) {
    division = value;
    notifyListeners();
    districtsList = [];
    district = null;
    getDistrictsByDivision();
  }

  void reset() {
    districtsList = [];
    divisionsList = [];
    district = null;
    division = null;
  }

  // get all districts
  Future<void> getAllDistricts() async {
    districtsList = await DistrictsApi.getAllDistricts();
    notifyListeners();
  }

  // get all divisions
  Future<void> getAllDivision() async {
    divisionsList = await DistrictsApi.getAllDivisions();
    notifyListeners();
  }

  // get all districts by division
  Future<void> getDistrictsByDivision() async {
    if (division != null) {
      districtsList =
          await DistrictsApi.getDistrictsByDivision(division!.division!);
      notifyListeners();
    }
  }
}
