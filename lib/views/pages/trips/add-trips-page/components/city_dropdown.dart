import 'package:flutter/material.dart';
import 'package:just_travel_admin/providers/hotel_provider.dart';
import 'package:provider/provider.dart';

class CityDropDown extends StatelessWidget {
  const CityDropDown({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Row(
      children: [
        const Text('Select City'),
        const SizedBox(
          width: 30,
        ),
        Consumer<HotelProvider>(
          builder: (context, hotelProvider, child) {
            return hotelProvider.cityList.isEmpty
                ? const Text('Loading')
                : DropdownButton<String>(
              hint: const Text('Tap To Select'),
              value: hotelProvider.city,
              items: hotelProvider.cityList
                  .map(
                    (e) => DropdownMenuItem<String>(
                  value: e,
                  child: Text(e),
                ),
              )
                  .toList(),
              onChanged: (value) {
                hotelProvider.setCityFromDropDown(value);
                if (value != null){
                  hotelProvider.getHotelsByCity(hotelProvider.city!);
                }

              },
            );
          },
        ),
      ],
    );
  }
}
