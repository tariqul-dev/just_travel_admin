import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../apis/image_upload_api.dart';
import '../apis/trip_api.dart';
import '../models/db-models/image_upload_model.dart';
import '../models/db-models/trip_model.dart';

class TripProvider extends ChangeNotifier {
  DateTime? tripStartDate, tripEndDate;
  List<String> tripImageList = [];
  ImageSource _imageSource = ImageSource.camera;
  String? tripImagePath;
  XFile? tripImageFile;
  List<TripModel> tripList = [];
  TripModel? tripModel;
  List<TripModel> hostTripList = [];
  List<TripModel> upNotifiableTripList = [];

  // on init
  void onInit() {
    getAllTrips();
  }

  void reset() {
    tripImageList = [];
    tripStartDate = null;
    tripEndDate = null;
    tripImagePath = null;
    tripImageFile = null;
    notifyListeners();
  }

  void setTripStartDate(DateTime? dateTime) {
    tripStartDate = dateTime;
    if (tripEndDate != null) {
      if (tripStartDate?.compareTo(tripEndDate!) != -1) {
        tripEndDate = null;
      }
    }
    notifyListeners();
  }

  void setTripEndDate(DateTime? dateTime) {
    tripEndDate = dateTime;
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

//create trip

  Future<bool> saveTrip({
    required String placeName,
    required String district,
    required String division,
    required String description,
    required String hotelId,
    required num cost,
    required num travellers,
  }) async {
    final TripModel tripModel = TripModel(
      placeName: placeName,
      description: description,
      district: district,
      division: division,
      startDate: tripStartDate?.millisecondsSinceEpoch,
      endDate: tripEndDate?.millisecondsSinceEpoch,
      photos: tripImageList,
      travellers: travellers,
      cost: cost,
      hotel: hotelId,
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
  // get all trips
  Future<List<TripModel>> getAllTrips() async {
    try {
      tripList = await TripApi.getAllTrips();
      notifyListeners();
      return tripList;
    } catch (e) {
      print('Error: $e');
      return tripList;
    }
  }

  // get notifiable trips
  Future<List<TripModel>> getNotifiableTrips() async {
    try {
      upNotifiableTripList = await TripApi.getNotifiableTrips();
      notifyListeners();
      return upNotifiableTripList;
    } catch (e) {
      print('Error: $e');
      return upNotifiableTripList;
    }
  }

  // get trip by id
  Future<TripModel?> getTripByTripId(String tripId) async {
    tripModel = await TripApi.getTripByTripId(tripId);
    notifyListeners();
    return tripModel;
  }

// get trips host
  Future<List<TripModel>> getTripsByHost(String host) async {
    try {
      hostTripList = await TripApi.getTripsByHost(host);
      notifyListeners();
      return hostTripList;
    } catch (e) {
      print('Error: $e');
      return hostTripList;
    }
  }

// fetching trip by userId tripId
  Future<bool> getTripByUserIdTripId(String userId, String tripId) async {
    TripModel? trip = await TripApi.getTripByUserIdTripId(userId, tripId);
    return trip?.placeName != null;
  }

  // notify users by trip id
  Future<void> notifyUsersByTripId(String tripId, String message) async{
    await TripApi.notifyUsersByTripId(tripId, message);
  }
}
