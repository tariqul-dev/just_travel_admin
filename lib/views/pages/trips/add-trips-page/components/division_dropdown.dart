import 'package:flutter/material.dart';
import 'package:just_travel_admin/providers/hotel_provider.dart';
import 'package:provider/provider.dart';

class DivisionDropDown extends StatelessWidget {
  const DivisionDropDown({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Text('Select Division'),
        const SizedBox(
          width: 30,
        ),
        Consumer<HotelProvider>(
          builder: (context, hotelProvider, child) {
            return hotelProvider.divisionList.isEmpty
                ? const Text('Loading')
                : DropdownButton<String>(
                    hint: const Text('Tap To Select'),
                    value: hotelProvider.division,
                    items: hotelProvider.divisionList
                        .map(
                          (e) => DropdownMenuItem<String>(
                            value: e,
                            child: Text(e),
                          ),
                        )
                        .toList(),
                    onChanged: (value) {
                      hotelProvider.setDivisionFromDropDown(value);
                    },
                  );
          },
        ),
      ],
    );
  }
}
