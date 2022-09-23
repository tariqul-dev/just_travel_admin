import 'package:flutter/material.dart';
import 'package:just_travel_admin/providers/hotel_provider.dart';
import 'package:just_travel_admin/providers/room_provider.dart';
import 'package:just_travel_admin/utils/helper_functions.dart';
import 'package:just_travel_admin/views/pages/hotels/add-hotel-page/components/hotel_image_section.dart';
import 'package:just_travel_admin/views/pages/hotels/add-hotel-page/components/room_tiles.dart';
import 'package:just_travel_admin/views/pages/hotels/add-hotel-page/components/status_dropdown.dart';
import 'package:just_travel_admin/views/pages/hotels/add-hotel-page/dialog/add_room_dialog.dart';
import 'package:just_travel_admin/views/pages/hotels/add-hotel-page/utils/save_button_function.dart';
import 'package:just_travel_admin/views/widgets/custom_form_field.dart';
import 'package:just_travel_admin/views/widgets/loading_widget.dart';
import 'package:provider/provider.dart';

class AddHotelPage extends StatelessWidget {
  static const routeName = '/add_hotel';
  final hotelNameTextController = TextEditingController();
  final hotelCityTextController = TextEditingController();
  final hotelDivisionTextController = TextEditingController();
  final hotelDescriptionTextController = TextEditingController();
  final globalKey = GlobalKey<FormState>();

  AddHotelPage({Key? key}) : super(key: key);
  void reset(BuildContext context) {
    hotelNameTextController.clear();
    hotelCityTextController.clear();
    hotelDivisionTextController.clear();
    hotelDescriptionTextController.clear();
    context.read<HotelProvider>().reset();
    context.read<RoomProvider>().reset();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Hotel'),
        actions: [
          TextButton(
            onPressed: () async {
              if (globalKey.currentState!.validate() &&
                  context.read<HotelProvider>().hotelImageList.isNotEmpty) {
                showLoadingDialog(context);
                saveButtonFunction(
                  context,
                  hotelName: hotelNameTextController.text,
                  city: hotelCityTextController.text,
                  division: hotelDivisionTextController.text,
                  description: hotelDescriptionTextController.text,
                  rooms: context.read<RoomProvider>().roomList,
                  reset: reset,
                );
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
                const Expanded(
                  child: StatusDropdown(),
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
            const RoomTiles(),
            const SizedBox(
              height: 10,
            ),
            // adding hotel images
            const HotelImageSection(),
          ],
        ),
      ),
    );
  }
}
