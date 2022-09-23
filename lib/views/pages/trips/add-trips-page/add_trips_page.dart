import 'package:flutter/material.dart';
import 'package:just_travel_admin/models/db-models/hotel_model.dart';
import 'package:just_travel_admin/providers/hotel_provider.dart';
import 'package:just_travel_admin/providers/trip_provider.dart';
import 'package:just_travel_admin/utils/constants/urls.dart';
import 'package:just_travel_admin/utils/date_picker.dart';
import 'package:just_travel_admin/utils/helper_functions.dart';
import 'package:just_travel_admin/views/pages/trips/add-trips-page/components/hotel_dropdown.dart';
import 'package:just_travel_admin/views/pages/trips/add-trips-page/components/uploaded_images_card.dart';
import 'package:just_travel_admin/views/pages/trips/add-trips-page/dialog/hotel_select_dialog.dart';
import 'package:just_travel_admin/views/pages/trips/add-trips-page/dialog/trip_image_picker_dialog.dart';
import 'package:just_travel_admin/views/widgets/custom_form_field.dart';
import 'package:just_travel_admin/views/widgets/loading_widget.dart';
import 'package:just_travel_admin/views/widgets/upload_image_card.dart';
import 'package:provider/provider.dart';

class AddTripsPage extends StatelessWidget {
  static const routeName = '/add_trip';
  final placeNameTextController = TextEditingController();
  final cityTextController = TextEditingController();
  final divisionTextController = TextEditingController();
  final descriptionTextController = TextEditingController();
  final daysTextController = TextEditingController();
  final costTextController = TextEditingController();
  final capacityTextController = TextEditingController();
  final globalKey = GlobalKey<FormState>();

  AddTripsPage({Key? key}) : super(key: key);

  void reset(BuildContext context) {
    placeNameTextController.clear();
    cityTextController.clear();
    divisionTextController.clear();
    descriptionTextController.clear();
    daysTextController.clear();
    costTextController.clear();
    capacityTextController.clear();
    context.read<HotelProvider>().reset();
    context.read<TripProvider>().reset();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Trip'),
        actions: [
          TextButton(
            onPressed: () {
              onPressed(context);
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
              controller: placeNameTextController,
              isPrefIcon: false,
              labelText: 'Place Name',
            ),
            const SizedBox(
              height: 10,
            ),
            CustomFormField(
              controller: cityTextController,
              isPrefIcon: false,
              labelText: 'City',
              onEditingComplete: () {
                context
                    .read<HotelProvider>()
                    .getHotelsByCity(cityTextController.text);
              },
            ),

            const SizedBox(
              height: 10,
            ),
            CustomFormField(
              controller: divisionTextController,
              isPrefIcon: false,
              labelText: 'Division',
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

            Row(
              children: [
                Expanded(
                  child: TextButton(
                    onPressed: () async {
                      datePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime.now(),
                        lastDate: DateTime(3030),
                        onSelect: (dateTime) {
                          context.read<TripProvider>().setDate(dateTime);
                        },
                      );
                    },
                    child: Consumer<TripProvider>(
                      builder: (context, tripProvider, child) => Text(
                        tripProvider.selectedDate != null
                            ? getFormattedDateTime(
                                dateTime: tripProvider
                                    .selectedDate!.millisecondsSinceEpoch)
                            : 'Select Date',
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: CustomFormField(
                    controller: daysTextController,
                    textInputType: TextInputType.number,
                    isPrefIcon: false,
                    labelText: 'Days',
                  ),
                ),
              ],
            ),

            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Expanded(
                  flex: 1,
                  child: CustomFormField(
                    controller: capacityTextController,
                    textInputType: TextInputType.number,
                    isPrefIcon: false,
                    labelText: 'Capacity',
                  ),
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
    );
  }

  void onPressed(BuildContext context) async {
    final tripProvider = context.read<TripProvider>();

    if (globalKey.currentState!.validate() &&
        context.read<TripProvider>().tripImageList.isNotEmpty) {
      showLoadingDialog(context);

      try {
        await hotelSelectDialog(context);

        bool isSuccess = await tripProvider.saveTrip(
          placeName: placeNameTextController.text,
          city: cityTextController.text,
          division: divisionTextController.text,
          description: descriptionTextController.text,
          cost: num.parse(costTextController.text),
          capacity: num.parse(capacityTextController.text),
          days: num.parse(daysTextController.text),
          hotelId: context.read<HotelProvider>().hotelModel!.id!,
        );

        if (!isSuccess) {
          return;
        }
        showMsg(context, 'Trip Inserted Successfully');
        reset(context);
      } catch (error) {
        showMsg(context, 'Failed To Create Trip');
        context.read<HotelProvider>().reset();
        print('error saving trip: $error');
      } finally {
        Navigator.pop(context);
      }
    } else {
      showMsg(context, 'Field must not be empty');
    }
  }
}
