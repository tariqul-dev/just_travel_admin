import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../constants/urls.dart';
import '../../../models/db-models/hotel_model.dart';
import '../../../providers/hotel_provider.dart';
import '../../../providers/trip_provider.dart';
import '../../../utils/date_picker.dart';
import '../../../utils/dialogs/trips/trip_image_picker_dialog.dart';
import '../../../utils/helper_functions.dart';
import '../../widgets/custom_form_field.dart';
import '../../widgets/loading_widget.dart';
import '../../widgets/upload_image_card.dart';

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

  // void set(BuildContext context) {
  //   hotelNameTextController.text = hotelModel!.name!;
  //   hotelCityTextController.text = hotelModel!.city!;
  //   hotelDivisionTextController.text = hotelModel!.division!;
  //   hotelDescriptionTextController.text = hotelModel!.description!;
  //   context.read<HotelProvider>().setSelectedHotelType(hotelModel!.type);
  //   context.read<HotelProvider>().hotelImageList = hotelModel!.photos!;
  //   context.read<RoomProvider>().roomList = hotelModel!.rooms!;
  // }

  @override
  Widget build(BuildContext context) {
    HotelModel? hotelModel;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Trip'),
        actions: [
          TextButton(
            onPressed: () {
              if (globalKey.currentState!.validate() &&
                  context.read<TripProvider>().tripImageList.isNotEmpty &&
                  hotelModel != null) {
                showLoadingDialog(context);
                // print(context.read<RoomProvider>().roomList);
                context
                    .read<TripProvider>()
                    .saveTrip(
                      placeName: placeNameTextController.text,
                      city: cityTextController.text,
                      division: divisionTextController.text,
                      description: descriptionTextController.text,
                      cost: num.parse(costTextController.text),
                      capacity: num.parse(capacityTextController.text),
                      days: num.parse(daysTextController.text),
                      hotelId: hotelModel!.id!,
                    )
                    .then((value) {
                  Navigator.pop(context);
                  if (value) {
                    showMsg(context, 'Trip Inserted Successfully');
                    reset(context);
                  } else {
                    showMsg(context, 'Failed To Create Trip');
                  }
                }).onError((error, stackTrace) {
                  showMsg(context, 'Failed To Create Trip');
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
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Consumer<HotelProvider>(
                builder: (context, provider, child) {
                  return provider.hotelsByCity.isEmpty
                      ? const Text('No hotel found in this city')
                      : DropdownButtonHideUnderline(
                          child: DropdownButtonFormField<HotelModel>(
                            hint: const Text('Select Hotel'),
                            isExpanded: true,
                            icon: const Icon(Icons.arrow_drop_down),
                            value: provider.hotelModel,
                            items: provider.hotelsByCity
                                .map(
                                  (hotel) => DropdownMenuItem<HotelModel>(
                                    value: hotel,
                                    child: Text(hotel.name ?? 'Hotel name'),
                                  ),
                                )
                                .toList(),
                            validator: (value) {
                              if (value == null) {
                                return 'Please select hotel type';
                              }
                              return null;
                            },
                            onChanged: (value) {
                              provider.setHotel(value);
                              hotelModel = value;
                            },
                          ),
                        );
                },
              ),
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
            SizedBox(
              height: 300,
              child: Consumer<TripProvider>(
                builder: (context, tripProvider, child) {
                  var tripImageList = tripProvider.tripImageList;
                  return tripImageList.isEmpty
                      ? Image.asset(
                          'images/img.png',
                          height: 100,
                          width: 100,
                          fit: BoxFit.cover,
                        )
                      : GridView.builder(
                          itemCount: tripImageList.length,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 3),
                          itemBuilder: (context, index) => UploadImageCard(
                            child: Consumer<TripProvider>(
                              builder: (context, provider, child) =>
                                  Image.network(
                                '${baseUrl}uploads/${provider.tripImageList[index]}',
                                height: 100,
                                width: 100,
                                fit: BoxFit.cover,
                              ),
                            ),
                            onTap: () {
                              print('index: $index');
                              tripImagePickerDialog(context, index: index);
                            },
                          ),
                        );
                },
              ),
            ),

            /*
            * ================ adding hotel ================*/

            // Consumer<HotelProvider>(
            //   builder: (context, provider, child) {
            //     HotelModel? hotel = provider.hotelModel;
            //     return hotel == null
            //         ? const Text('Select hotel first')
            //         : Column(
            //             children: [
            //               Padding(
            //                 padding: const EdgeInsets.all(8.0),
            //                 child: ListTile(
            //                   contentPadding: const EdgeInsets.all(0),
            //                   title: Text(
            //                     hotel.name!,
            //                     style: const TextStyle(
            //                       fontSize: 18,
            //                       fontWeight: FontWeight.bold,
            //                     ),
            //                   ),
            //                   subtitle: Text(
            //                     hotel.type!,
            //                     style: const TextStyle(
            //                       fontSize: 13,
            //                     ),
            //                   ),
            //                   trailing: IconButton(
            //                     onPressed: () {},
            //                     icon: const Icon(Icons.edit),
            //                   ),
            //                 ),
            //               ),
            //               hotel.photos == null
            //                   ? Image.asset(
            //                       'images/img.png',
            //                       height: 100,
            //                       width: 100,
            //                       fit: BoxFit.cover,
            //                     )
            //                   : GridView.builder(
            //                       itemCount: hotel.photos!.length,
            //                       gridDelegate:
            //                           const SliverGridDelegateWithFixedCrossAxisCount(
            //                               crossAxisCount: 3),
            //                       itemBuilder: (context, index) =>
            //                           UploadImageCard(
            //                         child: Consumer<HotelProvider>(
            //                           builder:
            //                               (context, hotelProvider, child) =>
            //                                   Image.network(
            //                             '${baseUrl}uploads/${hotelProvider.hotelImageList[index]}',
            //                             height: 100,
            //                             width: 100,
            //                             fit: BoxFit.cover,
            //                           ),
            //                         ),
            //                         onTap: () {
            //                           print('index: $index');
            //                           hotelImagePickerDialog(context,
            //                               index: index);
            //                         },
            //                       ),
            //                     ),
            //               Padding(
            //                 padding: const EdgeInsets.all(8.0),
            //                 child: Column(
            //                   crossAxisAlignment: CrossAxisAlignment.stretch,
            //                   children: [
            //                     const Text('About'),
            //                     Text(hotel.name!),
            //                   ],
            //                 ),
            //               ),
            //               const SizedBox(
            //                 height: 10,
            //               ),
            //               // room section
            //               Padding(
            //                 padding: const EdgeInsets.all(8.0),
            //                 child: hotel.rooms!.isEmpty
            //                     ? const Text('No room added')
            //                     : ListView.builder(
            //                         itemCount: hotel.rooms!.length,
            //                         shrinkWrap: true,
            //                         physics:
            //                             const NeverScrollableScrollPhysics(),
            //                         itemBuilder: (context, index) => ListTile(
            //                           onTap: () {
            //                             // Navigator.pushNamed(
            //                             //     context, RoomDetailsPage.routeName,
            //                             //     arguments: hotel.rooms![index]);
            //                           },
            //                           contentPadding: const EdgeInsets.all(0),
            //                           leading: Image.network(
            //                             '${baseUrl}uploads/${hotel.rooms![index].photos![0]}',
            //                             height: 100,
            //                             width: 100,
            //                             fit: BoxFit.cover,
            //                           ),
            //                           title: Text(hotel.rooms![index].title!),
            //                           subtitle:
            //                               Text(hotel.rooms![index].status!),
            //                           trailing: Text(hotel.rooms![index].price!
            //                               .toString()),
            //                         ),
            //                       ),
            //               ),
            //             ],
            //           );
            //   },
            // ),
          ],
        ),
      ),
    );
  }
}
