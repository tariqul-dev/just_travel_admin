import 'package:flutter/material.dart';
import 'package:just_travel_admin/providers/hotel_provider.dart';
import 'package:just_travel_admin/providers/trip_provider.dart';
import 'package:just_travel_admin/utils/helper_functions.dart';
import 'package:just_travel_admin/views/pages/trips/add-trips-page/components/city_dropdown.dart';
import 'package:just_travel_admin/views/pages/trips/add-trips-page/components/date_section.dart';
import 'package:just_travel_admin/views/pages/trips/add-trips-page/components/division_dropdown.dart';
import 'package:just_travel_admin/views/pages/trips/add-trips-page/components/hotel_dropdown.dart';
import 'package:just_travel_admin/views/pages/trips/add-trips-page/components/uploaded_images_card.dart';
import 'package:just_travel_admin/views/pages/trips/add-trips-page/dialog/trip_image_picker_dialog.dart';
import 'package:just_travel_admin/views/widgets/custom_form_field.dart';
import 'package:just_travel_admin/views/widgets/loading_widget.dart';
import 'package:provider/provider.dart';

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
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => reset(context),
      child: Scaffold(
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
              // city section
              const CityDropDown(),

              const SizedBox(
                height: 10,
              ),
              // division section
              const DivisionDropDown(),

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

              // date section
              const DateSection(),

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
              const HotelDropDown(),

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
        context.read<TripProvider>().tripImageList.isNotEmpty) {
      showLoadingDialog(context);

      try {
        // await hotelSelectDialog(context);

        bool isSuccess = await tripProvider.saveTrip(
          placeName: placeNameTextController.text,
          city: context.read<HotelProvider>().city!,
          division: context.read<HotelProvider>().division!,
          description: descriptionTextController.text,
          cost: num.parse(costTextController.text),
          capacity: num.parse(capacityTextController.text),
          hotelId: context.read<HotelProvider>().hotelDropdownItem!.id!,
        );

        if (!isSuccess) {
          return;
        }
        // ignore: use_build_context_synchronously
        showMsg(context, 'Trip Inserted Successfully');
        // ignore: use_build_context_synchronously
        reset(context);
      } catch (error) {
        showMsg(context, 'Failed To Create Trip');
        context.read<HotelProvider>().reset();
        print('error saving trip: $error');
      } finally {
        Navigator.pop(context);
        Navigator.pop(context);
      }
    } else {
      showMsg(context, 'Field must not be empty');
    }
  }
}
