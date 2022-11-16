import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../apis/image_upload_api.dart';
import '../apis/user_api.dart';
import '../models/db-models/image_upload_model.dart';
import '../models/db-models/user_model.dart';

class UserProvider extends ChangeNotifier {
  UserModel? user;
  List<UserModel> userList = [];
  String? genderGroupValue;
  DateTime? dob;

  ImageSource _imageSource = ImageSource.camera;
  String? userImagePath;
  XFile? userImageFile;

  void onInit(){
    fetchAllUsers();
  }

  void reset() {
    userImagePath = null;
    userImageFile = null;
  }


  void setGenderGroupValue(String value) {
    genderGroupValue = value;
    notifyListeners();
  }

  void setDob(DateTime dateTime){
    dob = dateTime;
    notifyListeners();
  }


/*
  * Image picking section start*/
  Future<ImageUploadModel?> userPickImage(bool isCamera) async {
    if (isCamera) {
      _imageSource = ImageSource.camera;
    } else {
      _imageSource = ImageSource.gallery;
    }
    userImageFile =
        await ImagePicker().pickImage(source: _imageSource, imageQuality: 50);
    if (userImageFile != null) {
      try {
        ImageUploadModel? uploadModel =
            await ImageUploadApi.uploadImage(userImageFile!.path);
        userImagePath = uploadModel!.image;

        print('picked image: $userImagePath');
        notifyListeners();
        return uploadModel;
      } catch (e) {
        print('user provider -> image upload: $e');
      }
    }
    return null;
  }
  /*
  * Image picking section end*/

  /*
  * Database query*/

  // fetch user by email
  Future<void> fetchUserByEmail(String email) async {
    user = await UserApi.fetchUserByEmail(email);
    notifyListeners();
  }

  // fetch user by user id
  Future<UserModel?> fetchUserByUserId(String userId) async {
    return await UserApi.fetchUserByUserId(userId);
  }

  // update user
  Future<void> updateUser(Map<String, dynamic> map, String userId) async {
    user = await UserApi.updateUser(map, userId);
    notifyListeners();
  }

  // fetching all users
  Future<void> fetchAllUsers() async{
    userList = await UserApi.fetchAllUsers();
    notifyListeners();
  }


}
