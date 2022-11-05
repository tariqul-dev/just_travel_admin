import 'dart:convert';

import 'package:http/http.dart';

import '../models/db-models/districts_model.dart';
import '../models/db-models/divisions_model.dart';
import '../utils/constants/urls.dart';

class DistrictsApi {
  static Future<List<DistrictsModel>> getAllDistricts() async {
    var request = Request('GET', Uri.parse('${bdApiUrl}districts'));
    try {
      StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        var enCodedDate = await response.stream.bytesToString();
        var data = json.decode(enCodedDate);

        List<DistrictsModel> districts = List.generate(
          data['data'].length,
          (index) => DistrictsModel.fromJson(data['data'][index]),
        );

        return districts;
      } else {
        throw response.reasonPhrase.toString();
      }
    } catch (error) {
      print('error fetching districts: $error');
      return [];
    }
  }

  static Future<List<DivisionsModel>> getAllDivisions() async {
    var request = Request('GET', Uri.parse('${bdApiUrl}divisions'));
    try {
      StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        var enCodedDate = await response.stream.bytesToString();
        var data = json.decode(enCodedDate);

        List<DivisionsModel> divisions = List.generate(
          data['data'].length,
          (index) => DivisionsModel.fromJson(data['data'][index]),
        );

        return divisions;
      } else {
        throw response.reasonPhrase.toString();
      }
    } catch (error) {
      print('error fetching division: $error');
      return [];
    }
  }

  static Future<List<DistrictsModel>> getDistrictsByDivision(String division) async {
    var request = Request('GET', Uri.parse('${bdApiUrl}division/$division'));
    try {
      StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        var enCodedDate = await response.stream.bytesToString();
        var data = json.decode(enCodedDate);

        List<DistrictsModel> districts = List.generate(
          data['data'].length,
          (index) => DistrictsModel.fromJson(data['data'][index]),
        );

        return districts;
      } else {
        throw response.reasonPhrase.toString();
      }
    } catch (error) {
      print('error fetching districts by division: $error');
      return [];
    }
  }
}
