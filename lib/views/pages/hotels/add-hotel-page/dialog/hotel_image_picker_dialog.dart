import 'package:flutter/material.dart';
import 'package:just_travel_admin/providers/hotel_provider.dart';
import 'package:provider/provider.dart';

hotelImagePickerDialog(BuildContext context, {int index = -1}) {
  return showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: const Text('Upload Image'),
      content: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () {
                Provider.of<HotelProvider>(context, listen: false)
                    .hotelPickImage(true, index: index)
                    .then(
                      (value) => Navigator.pop(context),
                    );
              },
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: const [
                  Icon(
                    Icons.camera,
                    size: 30,
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text('Camera'),
                ],
              ),
            ),
          ),
          Expanded(
            child: GestureDetector(
              onTap: () {
                Provider.of<HotelProvider>(context, listen: false)
                    .hotelPickImage(false, index: index)
                    .then(
                      (value) => Navigator.pop(context),
                    );
              },
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: const [
                  Icon(
                    Icons.image,
                    size: 30,
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text('Gallery'),
                ],
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
