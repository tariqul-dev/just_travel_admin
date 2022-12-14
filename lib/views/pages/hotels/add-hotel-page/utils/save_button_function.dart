import 'package:flutter/material.dart';
import 'package:just_travel_admin/models/db-models/room_model.dart';
import 'package:just_travel_admin/providers/hotel_provider.dart';
import 'package:just_travel_admin/utils/helper_functions.dart';
import 'package:provider/provider.dart';

saveButtonFunction(
  BuildContext context, {
  required String hotelName,
  required String district,
  required String division,
  required String description,
  required List<RoomModel> rooms,
  required Function(BuildContext context) reset,
}) async {
  try {
    bool value = await context.read<HotelProvider>().saveHotel(
          hotelName: hotelName,
          district: district,
          division: division,
          description: description,
          rooms: rooms,
        );

    if (value) {
      Navigator.pop(context);
      showMsg(context, 'Hotel Inserted Successfully');
      reset(context);
    } else {
      showMsg(context, 'Failed To Create Hotel');
    }
  } catch (error) {
    showMsg(context, 'Failed To Create Hotel');
    print('Error creating hotel: $error');
    Navigator.pop(context);
  } finally {
    Navigator.pop(context);
  }
}
