import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../apis/image_upload_api.dart';
import '../models/db-models/hotel_model.dart';
import '../models/db-models/image_upload_model.dart';

class RoomProvider extends ChangeNotifier {

  List<Rooms> roomList = [];
  List<String> roomImageList = [];
  ImageSource _imageSource = ImageSource.camera;
  String? roomImagePath;
  XFile? roomImageFile;

/*
  * Image picking section start*/
  Future<void> roomPickImage(bool isCamera, {required int index}) async {
    if (isCamera) {
      _imageSource = ImageSource.camera;
    } else {
      _imageSource = ImageSource.gallery;
    }
    roomImageFile =
    await ImagePicker().pickImage(source: _imageSource, imageQuality: 50);
    if (roomImageFile != null) {
      try {
        ImageUploadModel? uploadModel = await ImageUploadApi.uploadImage(roomImageFile!.path);
        if (index < 0) {

          roomImageList.add(uploadModel!.image!);
        } else {
          roomImageList[index] = uploadModel!.image!;
        }
        notifyListeners();
      } catch (e) {
        print('hotel provider -> image upload: $e');
      }
    }
  }
  /*
  * Image picking section end*/



  reset(){
    roomList = [];
    roomImageList = [];
    notifyListeners();
  }
  resetImageList(){
    roomImageList = [];
    notifyListeners();
  }


  // store room in roomList
  storeRoom(Rooms roomModel){
    roomList.add(roomModel);
    notifyListeners();
  }


  /*
  *============================ Room api calling section ============================*/



}
