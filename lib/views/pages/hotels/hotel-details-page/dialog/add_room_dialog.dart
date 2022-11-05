import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../models/db-models/room_model.dart';
import '../../../../../providers/hotel_provider.dart';
import '../../../../../providers/room_provider.dart';
import '../../../../../utils/constants/urls.dart';
import '../../../../../utils/helper_functions.dart';
import '../../../../widgets/custom_form_field.dart';
import '../../../../widgets/upload_image_card.dart';
import '../../add-hotel-page/dialog/room_image_picker_dialog.dart';

addRoomDialog(BuildContext context, String hotelId) {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController statusController = TextEditingController();
  final TextEditingController maxCapacityController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController roomNumberController = TextEditingController();

  final globalKey = GlobalKey<FormState>();

  void reset() {
    titleController.clear();
    statusController.clear();
    maxCapacityController.clear();
    descriptionController.clear();
    priceController.clear();
    roomNumberController.clear();
    context.read<RoomProvider>().resetImageList();
  }

  return showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) => AlertDialog(
      title: const Text('Add Room'),
      content: Form(
        key: globalKey,
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              CustomFormField(
                controller: titleController,
                isPrefIcon: false,
                labelText: 'Title',
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Expanded(
                    child: CustomFormField(
                      controller: maxCapacityController,
                      textInputType: TextInputType.number,
                      isPrefIcon: false,
                      labelText: 'Capacity',
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: CustomFormField(
                      controller: statusController,
                      isPrefIcon: false,
                      labelText: 'Status',
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              CustomFormField(
                controller: descriptionController,
                isPrefIcon: false,
                maxLine: 3,
                labelText: 'Description',
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Expanded(
                    child: CustomFormField(
                      controller: roomNumberController,
                      isPrefIcon: false,
                      labelText: 'Room Number',
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: CustomFormField(
                      controller: priceController,
                      textInputType: TextInputType.number,
                      isPrefIcon: false,
                      labelText: 'Price',
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              ElevatedButton.icon(
                icon: const Icon(Icons.add),
                label: const Text('Add Images'),
                onPressed: () {
                  roomImagePickerDialog(context);
                },
              ),
              const SizedBox(
                height: 10,
              ),
              // image upload section
              SizedBox(
                height: 200,
                child: Consumer<RoomProvider>(
                  builder: (context, roomProvider, child) {
                    var roomImageList = roomProvider.roomImageList;
                    return roomImageList.isEmpty
                        ? Image.asset(
                            'images/img.png',
                            height: 100,
                            width: 100,
                            fit: BoxFit.cover,
                          )
                        : GridView.builder(
                            itemCount: roomImageList.length,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                            ),
                            itemBuilder: (context, index) => UploadImageCard(
                              child: Image.network(
                                '${baseUrl}uploads/${roomProvider.roomImageList[index]}',
                                height: 100,
                                width: 100,
                                fit: BoxFit.cover,
                              ),
                              onTap: () {
                                print('index: $index');
                                roomImagePickerDialog(context, index: index);
                              },
                            ),
                          );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      actions: [
        ElevatedButton(
          onPressed: () {
            reset();
            Navigator.pop(context);
          },
          child: const Text('CANCEL'),
        ),
        ElevatedButton(
          onPressed: () {
            if (globalKey.currentState!.validate() &&
                context.read<RoomProvider>().roomImageList.isNotEmpty) {
              RoomModel roomModel = RoomModel(
                title: titleController.text.trim(),
                maxCapacity: int.parse(maxCapacityController.text.trim()),
                status: statusController.text.trim(),
                description: descriptionController.text.trim(),
                roomNumber: roomNumberController.text.trim(),
                price: double.parse(priceController.text.trim()),
                photos: context.read<RoomProvider>().roomImageList,
                hotel: hotelId,
              );

              context.read<RoomProvider>().addRoom(roomModel).then((value) {
                reset();
                Navigator.pop(context);
                showMsg(context, 'Room added successfully');
              }).onError((error, stackTrace) {
                showMsg(context, 'Failed to add room');
              });


            } else {
              showMsg(context, 'Field must not be empty');
            }
          },
          child: const Text('SAVE'),
        ),
      ],
    ),
  );
}
