import 'package:flutter/material.dart';
import 'package:just_travel_admin/providers/hotel_provider.dart';
import 'package:provider/provider.dart';

class StatusDropdown extends StatelessWidget {
  const StatusDropdown({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: Consumer<HotelProvider>(builder: (context, provider, child) {
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
    );
  }
}
