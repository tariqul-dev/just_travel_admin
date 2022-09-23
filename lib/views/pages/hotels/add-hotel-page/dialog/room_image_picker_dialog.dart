import 'package:flutter/material.dart';
import 'package:just_travel_admin/providers/room_provider.dart';
import 'package:provider/provider.dart';

roomImagePickerDialog(BuildContext context, {int index = -1}) {
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
                Provider.of<RoomProvider>(context, listen: false)
                    .roomPickImage(true, index: index)
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
                Provider.of<RoomProvider>(context, listen: false)
                    .roomPickImage(false, index: index)
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
