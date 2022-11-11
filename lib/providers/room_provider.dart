import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:just_travel_admin/apis/room_api.dart';
import 'package:just_travel_admin/models/db-models/room_model.dart';

import '../apis/image_upload_api.dart';
import '../models/db-models/image_upload_model.dart';

class RoomProvider extends ChangeNotifier {
  List<RoomModel> roomList = [];
  List<String> roomImageList = [];
  ImageSource _imageSource = ImageSource.camera;
  String? roomImagePath;
  XFile? roomImageFile;
  RoomModel? room;
  num numberOfTravellers = 1;

  String? selectedRoomStatusGroupValue;
  String? selectedRoomStatus;

  bool isRoomSelected = false;



  // void reset() {
  //   numberOfTravellers = 1;
  //   isRoomSelected = false;
  //   selectedRoomStatusGroupValue = null;
  //   room = null;
  //   roomList = [];
  //   notifyListeners();
  // }







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
        ImageUploadModel? uploadModel =
            await ImageUploadApi.uploadImage(roomImageFile!.path);
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

  void setRoomSelectedStatus(bool status) {
    isRoomSelected = status;
    notifyListeners();
  }

  void setRoomStatus(String value) {
    selectedRoomStatusGroupValue = value;
    notifyListeners();
  }

  void setNumberOfPeople(num value) {
    numberOfTravellers = value;
    notifyListeners();
  }
  void reset() {
    numberOfTravellers = 1;
    selectedRoomStatusGroupValue = null;
    room = null;
    roomList = [];
    roomImageList = [];
    notifyListeners();
  }


  resetImageList() {
    roomImageList = [];
    notifyListeners();
  }

  // store room in roomList
  storeRoom(RoomModel roomModel) {
    roomList.add(roomModel);
    notifyListeners();
  }

/*
  *============================ Room api calling section ============================*/
//  add room
  Future<bool> addRoom(RoomModel room) async {
    try {
      RoomModel? createdRoom = await RoomApi.addRoom(room);

      if (createdRoom != null) {
        roomList.add(createdRoom);
        notifyListeners();
        return true;
      }
      return false;
    } catch (error) {
      print('room creating error: $error');
      return false;
    }
  }

  //  create room
  Future<bool> createRoom(RoomModel room) async {
    try {
      RoomModel? createdRoom = await RoomApi.createRoom(room);

      if (createdRoom != null) {
        roomList.add(createdRoom);
        notifyListeners();
        return true;
      }
      return false;
    } catch (error) {
      print('room creating error: $error');
      return false;
    }
  }

/*
* ============= Query =============*/

// get rooms by hotel id
  Future<List<RoomModel>?> getRoomsByHotelId(String hotelId) async {
    try {
      roomList = await RoomApi.getRoomsByHotelId(hotelId);
      notifyListeners();
      return roomList;
    } catch (e) {
      print('Error: $e');
      return null;
    }
  }

  // get rooms by room id
  Future<RoomModel?> getHotelByRoomId(String id) async {
    try {
      room = await RoomApi.getHotelByRoomId(id);
      notifyListeners();
      return room;
    } catch (e) {
      print('Error: $e');
      return null;
    }
  }

  // get rooms by room id
  Future<RoomModel?> getRoomsByRoomId(String id) async {
    try {
      room = await RoomApi.getRoomByRoomId(id);
      notifyListeners();
      return room;
    } catch (e) {
      print('Error: $e');
      return null;
    }
  }

  // get rooms by hotelId status anc capacity
  Future<void> getRoomsByHotelIdStatusCapacity(String hotelId) async {
    try {
      if (selectedRoomStatusGroupValue != null) {
        roomList = await RoomApi.getRoomsByHotelIdStatusCapacity(
            hotelId, selectedRoomStatusGroupValue!, numberOfTravellers);
        notifyListeners();
      } else {
        throw 'Room status not selected';
      }
    } catch (error) {
      rethrow;
    }
  }




}
