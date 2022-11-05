import 'package:flutter/material.dart';
import 'package:just_travel_admin/providers/districts_provider.dart';
import 'package:just_travel_admin/providers/hotel_provider.dart';
import 'package:just_travel_admin/providers/room_provider.dart';
import 'package:just_travel_admin/utils/helper_functions.dart';
import 'package:just_travel_admin/views/pages/hotels/add-hotel-page/components/hotel_image_section.dart';
import 'package:just_travel_admin/views/pages/hotels/add-hotel-page/components/room_tiles.dart';
import 'package:just_travel_admin/views/pages/hotels/add-hotel-page/components/status_dropdown.dart';
import 'package:just_travel_admin/views/pages/hotels/add-hotel-page/dialog/add_room_dialog.dart';
import 'package:just_travel_admin/views/pages/hotels/add-hotel-page/utils/save_button_function.dart';
import 'package:just_travel_admin/views/widgets/custom_form_field.dart';
import 'package:just_travel_admin/views/widgets/district_dropdown.dart';
import 'package:just_travel_admin/views/widgets/division_dropdown.dart';
import 'package:just_travel_admin/views/widgets/loading_widget.dart';
import 'package:provider/provider.dart';

class AddHotelPage extends StatelessWidget {
  static const routeName = '/add_hotel';
  final hotelNameTextController = TextEditingController();
  final hotelDescriptionTextController = TextEditingController();
  final globalKey = GlobalKey<FormState>();

  AddHotelPage({Key? key}) : super(key: key);

  Future<bool> reset(BuildContext context) async {
    hotelNameTextController.clear();
    hotelDescriptionTextController.clear();
    context.read<HotelProvider>().reset();
    context.read<DistrictsProvider>().reset();
    context.read<RoomProvider>().reset();
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => reset(context),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Create Hotel'),
          actions: [
            TextButton(
              onPressed: () async {
                if (globalKey.currentState!.validate() &&
                    context.read<HotelProvider>().hotelImageList.isNotEmpty) {
                  final disProvider = context.read<DistrictsProvider>();
                  showLoadingDialog(context);
                  saveButtonFunction(
                    context,
                    hotelName: hotelNameTextController.text,
                    district: disProvider.district!.district!,
                    division: disProvider.division!.division!,
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
              const DivisionDropDown(),

              const SizedBox(
                height: 10,
              ),

              const DistrictDropDown(),
              const SizedBox(
                height: 10,
              ),

              const StatusDropdown(),

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
      ),
    );
  }
}
