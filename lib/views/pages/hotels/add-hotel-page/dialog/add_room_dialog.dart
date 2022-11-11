import 'package:flutter/material.dart';
import 'package:just_travel_admin/models/db-models/hotel_model.dart';
import 'package:just_travel_admin/models/db-models/room_model.dart';
import 'package:just_travel_admin/models/db-models/room_model.dart';
import 'package:just_travel_admin/providers/hotel_provider.dart';
import 'package:just_travel_admin/providers/room_provider.dart';
import 'package:just_travel_admin/utils/constants/urls.dart';
import 'package:just_travel_admin/utils/helper_functions.dart';
import 'package:just_travel_admin/views/widgets/custom_form_field.dart';
import 'package:just_travel_admin/views/widgets/upload_image_card.dart';
import 'package:provider/provider.dart';
import 'room_image_picker_dialog.dart';

addRoomDialog(BuildContext context, {int index = -1}) {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController maxCapacityController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController roomNumberController = TextEditingController();

  final globalKey = GlobalKey<FormState>();

  void reset() {
    titleController.clear();
    maxCapacityController.clear();
    descriptionController.clear();
    priceController.clear();
    roomNumberController.clear();
    context.read<RoomProvider>().resetImageList();
    Navigator.pop(context);
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
                    child:  Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Room Status',
                          style: Theme.of(context).textTheme.headline6!.copyWith(
                            fontSize: 16,
                          ),
                        ),
                        Row(
                          children: [
                            Consumer<RoomProvider>(
                              builder: (context, roomProvider, child) => Radio<String>(
                                value: 'ac',
                                groupValue: roomProvider.selectedRoomStatusGroupValue,
                                onChanged: (value) {
                                  roomProvider.setRoomStatus(value!);
                                },
                              ),
                            ),
                            const Text('AC'),
                          ],
                        ),
                        Row(
                          children: [
                            Consumer<RoomProvider>(
                              builder: (context, roomProvider, child) => Radio<String>(
                                value: 'non ac',
                                groupValue: roomProvider.selectedRoomStatusGroupValue,
                                onChanged: (value) {
                                  roomProvider.setRoomStatus(value!);
                                },
                              ),
                            ),
                            const Text('Non AC'),
                          ],
                        ),
                      ],
                    ),
                    // child: CustomFormField(
                    //   controller: statusController,
                    //   isPrefIcon: false,
                    //   labelText: 'Status',
                    // ),
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
                                    crossAxisCount: 3),
                            itemBuilder: (context, index) => UploadImageCard(
                              child: Consumer<HotelProvider>(
                                builder: (context, hotelProvider, child) =>
                                    Image.network(
                                  '${baseUrl}uploads/${roomProvider.roomImageList[index]}',
                                  height: 100,
                                  width: 100,
                                  fit: BoxFit.cover,
                                ),
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
                status: context.read<RoomProvider>().selectedRoomStatusGroupValue,
                description: descriptionController.text.trim(),
                roomNumber: roomNumberController.text.trim(),
                price: double.parse(priceController.text.trim()),
                photos: context.read<RoomProvider>().roomImageList,
              );

              context.read<RoomProvider>().createRoom(roomModel);
              // context.read<RoomProvider>().storeRoom(roomModel);

              // print('room: $roomModel');

              reset();
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
