import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:just_travel_admin/models/db-models/room_model.dart';

import '../apis/hotel_api.dart';
import '../apis/image_upload_api.dart';
import '../models/db-models/hotel_model.dart';
import '../models/db-models/image_upload_model.dart';

class HotelProvider extends ChangeNotifier {
  /*
  * Hotels */
  List<HotelModel> hotelList = [];
  List<HotelModel> hotelsByCity = [];
  List<String> hotelTypeList = ['Five Start', 'Normal'];
  List<String> hotelImageList = [];

  String? selectedHotelType;
  ImageSource _imageSource = ImageSource.camera;
  String? hotelImagePath;
  XFile? hotelImageFile;

  HotelModel? hotelModel;
  HotelModel? hotelDropdownItem;

  String? city;

  List<String> divisionList = [];
  String? division;
  List<HotelModel> hotelsByDistrict = [];

  HotelModel? finalSelectedHotel;

/*
  * Image picking section start*/
  Future<void> hotelPickImage(bool isCamera, {required int index}) async {
    if (isCamera) {
      _imageSource = ImageSource.camera;
    } else {
      _imageSource = ImageSource.gallery;
    }
    hotelImageFile =
        await ImagePicker().pickImage(source: _imageSource, imageQuality: 50);
    if (hotelImageFile != null) {
      try {
        // Uint8List imgByte = await hotelImageFile!.readAsBytes();
        ImageUploadModel? uploadModel =
            await ImageUploadApi.uploadImage(hotelImageFile!.path);
        if (index < 0) {
          hotelImageList.add(uploadModel!.image!);
        } else {
          hotelImageList[index] = uploadModel!.image!;
        }
        notifyListeners();
      } catch (e) {
        print('hotel provider -> image upload: $e');
      }
    }
  }

  /*
  * Image picking section end*/

  /*
  * hotel methods*/
  setSelectedHotelType(String? value) {
    selectedHotelType = value;
    notifyListeners();
  }

  setHotelFromDropDown(HotelModel? value) {
    hotelDropdownItem = value;
    notifyListeners();
  }

  setCityFromDropDown(String? value) {
    city = value;
    notifyListeners();
  }

  setDivisionFromDropDown(String? value) {
    division = value;
    notifyListeners();
  }

  // this will select hotel for booking
  setFinalSelectedHotel(HotelModel value) {
    finalSelectedHotel = value;
    notifyListeners();
  }



  setHotel(HotelModel? value) {
    hotelModel = value;
    notifyListeners();
  }

  reset() {
    hotelImageList = [];
    selectedHotelType = null;
    hotelModel = null;

    hotelsByCity = [];

    hotelDropdownItem = null;

    finalSelectedHotel = null;
    hotelsByDistrict = [];

    divisionList = [];
    division = null;

    notifyListeners();
  }

  /*
  *============================ Hotel api calling section ============================*/

  //create hotel
  Future<bool> saveHotel({
    required String hotelName,
    required String district,
    required String division,
    required String description,
    required List<RoomModel> rooms,
  }) async {
    final HotelModel hotelModel = HotelModel(
      name: hotelName,
      district: district,
      division: division,
      description: description,
      photos: hotelImageList,
      type: selectedHotelType,
      rooms: List.generate(rooms.length, (index) => rooms[index].id!),
    );

    bool isCreated = true;
    isCreated = await HotelApi.createHotel(hotelModel);
    if (isCreated) {
      getAllHotels();
    }
    return true;
  }

  // delete hotel by id
  Future<void> deleteHotelById(String id) async {
    await HotelApi.deleteHotelById(id);
    getAllHotels();
    notifyListeners();
  }

  // get all hotels
  Future<List<HotelModel>> getAllHotels() async {
    try {
      hotelList = await HotelApi.getAllHotels();
      // hotelDropdownItem = hotelList[0];
      notifyListeners();
      return hotelList;
    } catch (e) {
      print('Error: $e');
      return hotelList;
    }
  }

  // get hotel by id
  Future<HotelModel?> getHotelById(String hotelId) async {
    hotelModel = await HotelApi.getHotelById(hotelId);
    notifyListeners();
    return hotelModel;
  }

  // get hotels by district
  Future<List<HotelModel>?> getHotelsByDistrict(String district) async {
    try {
      hotelsByDistrict = await HotelApi.getHotelByDistrict(district);
      notifyListeners();
      return hotelsByDistrict;
    } catch (e) {
      print('Error: $e');
      return null;
    }
  }
}
