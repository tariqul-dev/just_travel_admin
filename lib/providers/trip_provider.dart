import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

import '../apis/image_upload_api.dart';
import '../apis/trip_api.dart';
import '../models/db-models/image_upload_model.dart';
import '../models/db-models/trip_model.dart';

class TripProvider extends ChangeNotifier {
  DateTime? selectedDate;
  List<String> tripImageList = [];
  ImageSource _imageSource = ImageSource.camera;
  String? tripImagePath;
  XFile? tripImageFile;
  List<TripModel> tripList = [];
  TripModel? tripModel;

  void reset(){
    tripImageList = [];
    selectedDate = null;
    tripImagePath = null;
    tripImageFile = null;
    notifyListeners();
  }

  void setDate(DateTime? dateTime) {
    print('date selected provider: $dateTime');
    selectedDate = dateTime;
    print('sele: $selectedDate');
    notifyListeners();
  }

  /*
  * Image picking section start*/
  Future<void> tripPickImage(bool isCamera, {required int index}) async {
    if (isCamera) {
      _imageSource = ImageSource.camera;
    } else {
      _imageSource = ImageSource.gallery;
    }
    tripImageFile =
        await ImagePicker().pickImage(source: _imageSource, imageQuality: 50);
    if (tripImageFile != null) {
      try {
        ImageUploadModel? uploadModel =
            await ImageUploadApi.uploadImage(tripImageFile!.path);
        if (index < 0) {
          tripImageList.add(uploadModel!.image!);
        } else {
          tripImageList[index] = uploadModel!.image!;
        }
        print('images: ${tripImageList}');
        notifyListeners();
      } catch (e) {
        print('trip provider -> image upload: $e');
      }
    }
  }
  /*
  * Image picking section end*/

  /*
  * ============= insert trip ============*/
//create hotel
  Future<bool> saveTrip(
      {required String placeName,
        required String city,
        required String division,
        required num days,
        required String description,
        required String hotelId,

        required num cost,
        required num capacity,
      }) async {
    final TripModel tripModel = TripModel(
      placeName: placeName,
      description: description,
      city: city,
      division: division,
      schedule: selectedDate?.millisecondsSinceEpoch,
      days: days,
      photos: tripImageList,
      capacity: capacity,
      cost: cost,
      hotel: Hotel(hotelId: hotelId ),

    );
    bool isCreated = true;
    await TripApi.createTrip(tripModel);
    if (isCreated) {
      getAllTrips();
    }
    return isCreated;
  }

/*
  * ============= query ============*/
  // get all hotels
  Future<List<TripModel>> getAllTrips() async {
    print('getAllHotels');
    try {
      tripList = await TripApi.getAllTrips();
      notifyListeners();
      return tripList;
    } catch (e) {
      print('Error: $e');
      return tripList;
    }
  }

  // get trip by id
  Future<TripModel?> getTripById(String tripId) async {
    tripModel = await TripApi.getTripById(tripId);
    notifyListeners();
    return tripModel;
  }

}
