import 'dart:convert';

import 'package:http/http.dart';

import '../models/db-models/user_model.dart';
import '../utils/constants/urls.dart';

class UserApi {
  //create user
  static Future<UserModel?> createUser(UserModel user) async {
    var headers = {'Content-Type': 'application/json'};
    var request = Request('POST', Uri.parse('${baseUrl}users/create'));
    request.body = json.encode(user);
    request.headers.addAll(headers);

    try {
      StreamedResponse response = await request.send();
      var enCodedDate = await response.stream.bytesToString();
      print('Created data: $enCodedDate');
      if (response.statusCode == 201) {
        // var enCodedDate = await response.stream.bytesToString();
        var data = json.decode(enCodedDate);
        UserModel user = UserModel.fromJson(data);
        print('create user: $user');
        return user;
      } else {
        throw response.reasonPhrase.toString();
      }
    } catch (error) {
      print('create user error: $error');
      return null;
    }
  }

  // update user
  static Future<UserModel?> updateUser(
      Map<String, dynamic> map, String userId) async {
    var headers = {'Content-Type': 'application/json'};
    var request = Request('PATCH', Uri.parse('${baseUrl}users/$userId'));
    request.body = json.encode(map);
    // {
    //   "email.isVerified": true
    // }
    request.headers.addAll(headers);

    try {
      StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        var enCodedDate = await response.stream.bytesToString();
        var data = json.decode(enCodedDate);
        UserModel user = UserModel.fromJson(data);
        print('updateUser user: $user');
        return user;
      } else {
        throw Error();
      }
    } catch (error) {
      print('create user error: $error');
      return null;
    }
  }

  // fetching all users
  static Future<List<UserModel>> fetchAllUsers() async {
    var request = Request('GET', Uri.parse('${baseUrl}users'));

    try {
      StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        var enCodedDate = await response.stream.bytesToString();
        var data = json.decode(enCodedDate);
        List<UserModel> users = List.generate(data.length, (index) => UserModel.fromJson(data[index]));
        return users;
      } else {
        throw Error();
      }
    } catch (error) {
      print('create user error: $error');
      return [];
    }
  }

  // fetching user by email
  static Future<UserModel?> fetchUserByEmail(String email) async {
    try {
      var request =
          Request('GET', Uri.parse('${baseUrl}users/email/?email=$email'));

      StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        var enCodedDate = await response.stream.bytesToString();
        var data = json.decode(enCodedDate);
        UserModel user = UserModel.fromJson(data);
        return user;
      } else {
        throw response.reasonPhrase.toString();
      }
    } catch (error) {
      print('user error: $error');
      return null;
    }
  }

  // fetching user by user id
  static Future<UserModel?> fetchUserByUserId(String userId) async {
    try {
      var request = Request('GET', Uri.parse('${baseUrl}users/get/$userId'));

      // var request = http.Request('GET', Uri.parse('http://localhost:5000/users/get/635102d39811b1c64ab0bac7'));

      StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        var enCodedDate = await response.stream.bytesToString();
        var data = json.decode(enCodedDate);
        UserModel user = UserModel.fromJson(data);
        return user;
      } else {
        throw response.reasonPhrase.toString();
      }
    } catch (error) {
      print('user error: $error');
      return null;
    }
  }
}
