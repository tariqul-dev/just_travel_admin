import 'package:flutter/material.dart';
import 'package:just_travel_admin/providers/hotel_provider.dart';
import 'package:just_travel_admin/providers/trip_provider.dart';
import 'package:just_travel_admin/utils/helper_functions.dart';
import 'package:just_travel_admin/views/pages/trips/add-trips-page/components/date_section.dart';
import 'package:just_travel_admin/views/pages/trips/add-trips-page/components/uploaded_images_card.dart';
import 'package:just_travel_admin/views/pages/trips/add-trips-page/dialog/trip_image_picker_dialog.dart';
import 'package:just_travel_admin/views/widgets/custom_form_field.dart';
import 'package:just_travel_admin/views/widgets/division_dropdown.dart';
import 'package:just_travel_admin/views/widgets/loading_widget.dart';
import 'package:provider/provider.dart';

import '../../../../providers/districts_provider.dart';
import '../../../../providers/room_provider.dart';
import '../../../widgets/number_of_traveler_picker.dart';
import '../../../widgets/district_dropdown.dart';
import 'components/hotel_button.dart';
import 'components/hotel_list_tile.dart';
import 'dialog/hotel_details_dialog.dart';

class AddTripsPage extends StatelessWidget {
  static const routeName = '/add_trip';
  final placeNameTextController = TextEditingController();
  final descriptionTextController = TextEditingController();
  final costTextController = TextEditingController();
  final capacityTextController = TextEditingController();
  final globalKey = GlobalKey<FormState>();

  AddTripsPage({Key? key}) : super(key: key);

  Future<bool> reset(BuildContext context) async {
    placeNameTextController.clear();
    descriptionTextController.clear();
    costTextController.clear();
    capacityTextController.clear();
    context.read<HotelProvider>().reset();
    context.read<TripProvider>().reset();
    context.read<RoomProvider>().reset();
    context.read<DistrictsProvider>().reset();

    return true;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => reset(context),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Create New Trip'),
          actions: [
            TextButton(
              onPressed: () {
                onPressed(context);
              },
              child: const Text(
                'Create',
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
                controller: placeNameTextController,
                isPrefIcon: false,
                labelText: 'Place Name',
              ),
              const SizedBox(
                height: 10,
              ),
              // city section
              const DivisionDropDown(),

              const SizedBox(
                height: 10,
              ),
              // division section
              const DistrictDropDown(),

              const SizedBox(
                height: 10,
              ),

              // date section
              const DateSection(),

              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  const Expanded(
                    flex: 2,
                    child: FittedBox(
                        fit: BoxFit.scaleDown, child: NumberOfTravelerPicker()),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Expanded(
                    flex: 1,
                    child: CustomFormField(
                      controller: costTextController,
                      textInputType: TextInputType.number,
                      isPrefIcon: false,
                      labelText: 'Cost',
                    ),
                  ),
                ],
              ),

              const SizedBox(
                height: 10,
              ),

              // hotel section
              const HotelButton(),

              const SizedBox(
                height: 10,
              ),
              Consumer<HotelProvider>(
                builder: (context, hotelProvider, child) {
                  return hotelProvider.finalSelectedHotel == null
                      ? const Text('Select District first then select hotel')
                      : HotelListTile(
                          hotel: hotelProvider.finalSelectedHotel!,
                          onTap: () {
                            hotelDetailsDialog(
                              context: context,
                              hotelId: hotelProvider.finalSelectedHotel!.id!,
                              isBooked: true,
                            );
                          },
                        );
                },
              ),

              const SizedBox(
                height: 10,
              ),
              CustomFormField(
                controller: descriptionTextController,
                isPrefIcon: false,
                maxLine: 3,
                labelText: 'Description',
              ),

              const SizedBox(
                height: 10,
              ),
              // adding tour place images
              ElevatedButton.icon(
                icon: const Icon(Icons.add),
                label: const Text('Add Images'),
                onPressed: () {
                  tripImagePickerDialog(context);
                },
              ),
              const SizedBox(
                height: 10,
              ),
              // image upload section
              const UploadedImagesCard(),
            ],
          ),
        ),
      ),
    );
  }

  void onPressed(BuildContext context) async {
    final tripProvider = context.read<TripProvider>();

    if (globalKey.currentState!.validate() &&
        tripProvider.tripImageList.length > 4) {
      try {
        showLoadingDialog(context);

        final disProvider = context.read<DistrictsProvider>();
        final roomProvider = context.read<RoomProvider>();
        final hotelProvider = context.read<HotelProvider>();
        bool isSuccess = await tripProvider.saveTrip(
          placeName: placeNameTextController.text.trim(),
          district: disProvider.district!.district!,
          division: disProvider.division!.division!,
          description: descriptionTextController.text.trim(),
          cost: num.parse(costTextController.text.trim()),
          travellers: roomProvider.numberOfTravellers,
          hotelId: hotelProvider.finalSelectedHotel!.id!,
        );

        if (isSuccess) {
          // ignore: use_build_context_synchronously
          showMsg(context, 'Trip Created Successfully');

          // ignore: use_build_context_synchronously
          reset(context);
          // ignore: use_build_context_synchronously
          Navigator.pop(context);

          Navigator.pop(context);
        }
      } catch (error) {
        // ignore: use_build_context_synchronously
        Navigator.pop(context);
        showMsg(context, 'Failed To Create Trip');
        debugPrint('error creating trip: $error');
      } finally {
        Navigator.pop(context);
      }
    } else {
      print(tripProvider.tripImageList.isNotEmpty);
      showMsg(context, 'Field must not be empty. Upload at least 5 images');
    }
  }
}
