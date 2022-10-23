import 'package:flutter/material.dart';
import 'package:just_travel_admin/models/db-models/hotel_model.dart';
import 'package:just_travel_admin/providers/hotel_provider.dart';
import 'package:provider/provider.dart';

class HotelDropDown extends StatelessWidget {
  const HotelDropDown({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<HotelProvider>(
      builder: (context, provider, child) => provider.city == null
          ? const Text('Please select city to select hotel')
          : Row(
              children: [
                const Text('Select Hotel'),
                const SizedBox(
                  width: 30,
                ),
                Consumer<HotelProvider>(
                    builder: (context, hotelProvider, child) {
                  return hotelProvider.hotelsByCity.isEmpty
                      ? const Text('Loading')
                      : DropdownButton<HotelModel>(
                          hint: const Text('Tap to select'),
                          value: hotelProvider.hotelDropdownItem,
                          items: hotelProvider.hotelsByCity
                              .map(
                                (e) => DropdownMenuItem<HotelModel>(
                                  value: e,
                                  child: Text(e.name!),
                                ),
                              )
                              .toList(),
                          onChanged: (value) {
                            hotelProvider.setHotelFromDropDown(value);
                          },
                        );
                }),
              ],
            ),
    );
  }
}
