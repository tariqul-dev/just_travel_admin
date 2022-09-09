import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../constants/urls.dart';
import '../../../models/db-models/hotel_model.dart';
import '../../../providers/hotel_provider.dart';
import '../../../providers/room_provider.dart';
import '../../../utils/dialogs/hotel_room/add_room_dialog.dart';
import '../../../utils/dialogs/hotel_room/hotel_image_picker_dialog.dart';
import '../../../utils/helper_functions.dart';
import '../../widgets/custom_form_field.dart';
import '../../widgets/loading_widget.dart';
import '../../widgets/upload_image_card.dart';

class AddHotelPage extends StatelessWidget {
  static const routeName = '/add_hotel';
  final hotelNameTextController = TextEditingController();
  final hotelCityTextController = TextEditingController();
  final hotelDivisionTextController = TextEditingController();
  final hotelDescriptionTextController = TextEditingController();
  final globalKey = GlobalKey<FormState>();
  bool isEdit = false;
  HotelModel? hotelModel;
  Object? args;
  AddHotelPage({this.args, Key? key}) : super(key: key);

  void reset(BuildContext context) {
    hotelNameTextController.clear();
    hotelCityTextController.clear();
    hotelDivisionTextController.clear();
    hotelDescriptionTextController.clear();
    context.read<HotelProvider>().reset();
    context.read<RoomProvider>().reset();
    // context.read<HotelProvider>().hotelImagePath = null;
    // context.read<HotelProvider>().setSelectedHotelType(null);
    // context.read<HotelProvider>().hotelImageList = [];
  }

  void set(BuildContext context) {
    hotelNameTextController.text = hotelModel!.name!;
    hotelCityTextController.text = hotelModel!.city!;
    hotelDivisionTextController.text = hotelModel!.division!;
    hotelDescriptionTextController.text = hotelModel!.description!;
    context.read<HotelProvider>().setSelectedHotelType(hotelModel!.type);
    context.read<HotelProvider>().hotelImageList = hotelModel!.photos!;
    context.read<RoomProvider>().roomList = hotelModel!.rooms!;
  }

  @override
  Widget build(BuildContext context) {
    // late HotelModel hotelModel;
    // print('catched hotel: ${ModalRoute.of(context)!.settings.arguments}');
    // if (ModalRoute.of(context)!.settings.arguments != null){
    //   hotelModel = ModalRoute.of(context)!.settings.arguments as HotelModel;
    //   isEdit = true;
    //   set(context, hotelModel);
    //
    // }

    Future.delayed(
      Duration.zero,
      () {
        if (args != null) {
          hotelModel = args as HotelModel;
          isEdit = true;
          set(context);
        } else {
          reset(context);
        }
      },
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(isEdit ? 'Edit' : 'Add Hotel'),
        actions: [
          TextButton(
            onPressed: () {
              if (globalKey.currentState!.validate() &&
                  context.read<HotelProvider>().hotelImageList.isNotEmpty) {
                showLoadingDialog(context);
                // print(context.read<RoomProvider>().roomList);
                context
                    .read<HotelProvider>()
                    .saveHotel(
                      hotelName: hotelNameTextController.text,
                      city: hotelCityTextController.text,
                      division: hotelDivisionTextController.text,
                      description: hotelDescriptionTextController.text,
                      rooms: context.read<RoomProvider>().roomList,
                    )
                    .then((value) {
                  Navigator.pop(context);
                  if (value) {
                    showMsg(context, 'Hotel Inserted Successfully');
                    reset(context);
                  } else {
                    showMsg(context, 'Failed To Create Hotel');
                  }
                }).onError((error, stackTrace) {
                  showMsg(context, 'Failed To Create Hotel');
                  Navigator.pop(context);
                });
              } else {
                showMsg(context, 'Field must not be empty');
              }
            },
            child: const Text(
              'Save',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
              ),
            ),
          ),
        ],
      ),
      body: Form(
        key: globalKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            CustomFormField(
              controller: hotelNameTextController,
              isPrefIcon: false,
              labelText: 'Hotel Name',
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Expanded(
                  flex: 2,
                  child: CustomFormField(
                    controller: hotelCityTextController,
                    isPrefIcon: false,
                    labelText: 'City',
                  ),
                ),
                const SizedBox(
                  width: 15,
                ),
                Expanded(
                  child: DropdownButtonHideUnderline(
                    child: Consumer<HotelProvider>(
                        builder: (context, provider, child) {
                      return DropdownButtonFormField<String>(
                        hint: const Text('Status'),
                        isExpanded: true,
                        icon: const Icon(Icons.arrow_drop_down),
                        value: provider.selectedHotelType,
                        items: provider.hotelTypeList
                            .map(
                              (hotelType) => DropdownMenuItem<String>(
                                value: hotelType,
                                child: Text(hotelType),
                              ),
                            )
                            .toList(),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please select hotel type';
                          }
                          return null;
                        },
                        onChanged: provider.setSelectedHotelType,
                      );
                    }),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            CustomFormField(
              controller: hotelDivisionTextController,
              isPrefIcon: false,
              labelText: 'Division',
            ),
            const SizedBox(
              height: 10,
            ),
            CustomFormField(
              controller: hotelDescriptionTextController,
              isPrefIcon: false,
              maxLine: 3,
              labelText: 'Description',
            ),
            const SizedBox(
              height: 10,
            ),
            // Add room button
            ElevatedButton.icon(
              icon: const Icon(Icons.add),
              label: const Text('Add Rooms'),
              onPressed: () {
                addRoomDialog(context);
              },
            ),
            const SizedBox(
              height: 10,
            ),

            Consumer<RoomProvider>(
              builder: (context, roomProvider, child) {
                var roomList = roomProvider.roomList;
                return roomList.isEmpty
                    ? const Text('No room added')
                    : ListView.builder(
                        itemCount: roomList.length,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) => ListTile(
                          contentPadding: const EdgeInsets.all(0),
                          leading: Image.network(
                            '${baseUrl}uploads/${roomList[index].photos![0]}',
                            height: 100,
                            width: 100,
                            fit: BoxFit.cover,
                          ),
                          title: Text(roomList[index].title!),
                          subtitle: Text(roomList[index].status!),
                          trailing: Text(roomList[index].price!.toString()),
                        ),
                      );
              },
            ),

            const SizedBox(
              height: 10,
            ),

            // adding hotel images
            ElevatedButton.icon(
              icon: const Icon(Icons.add),
              label: const Text('Add Images'),
              onPressed: () {
                hotelImagePickerDialog(context);
              },
            ),
            const SizedBox(
              height: 10,
            ),
            // image upload section
            SizedBox(
              height: 300,
              child: Consumer<HotelProvider>(
                builder: (context, hotelProvider, child) {
                  var hotelImageList = hotelProvider.hotelImageList;
                  return hotelImageList.isEmpty
                      ? Image.asset(
                          'images/img.png',
                          height: 100,
                          width: 100,
                          fit: BoxFit.cover,
                        )
                      : GridView.builder(
                          itemCount: hotelImageList.length,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 3),
                          itemBuilder: (context, index) => UploadImageCard(
                            child: Consumer<HotelProvider>(
                              builder: (context, hotelProvider, child) =>
                                  Image.network(
                                '${baseUrl}uploads/${hotelProvider.hotelImageList[index]}',
                                height: 100,
                                width: 100,
                                fit: BoxFit.cover,
                              ),
                            ),
                            onTap: () {
                              print('index: $index');
                              hotelImagePickerDialog(context, index: index);
                            },
                          ),
                        );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
