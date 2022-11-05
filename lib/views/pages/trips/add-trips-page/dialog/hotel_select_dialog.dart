import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../models/db-models/hotel_model.dart';
import '../../../../../providers/hotel_provider.dart';

Future<void> hotelSelectDialog(BuildContext context) => showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Select Hotel'),
        content: Consumer<HotelProvider>(
          builder: (context, provider, child) {
            return provider.hotelsByDistrict.isEmpty
                ? const Text('No hotel found in this city')
                : DropdownButtonHideUnderline(
                    child: DropdownButtonFormField<HotelModel>(
                      hint: const Text('Select Hotel'),
                      isExpanded: true,
                      icon: const Icon(Icons.arrow_drop_down),
                      value: provider.hotelModel,
                      items: provider.hotelsByDistrict
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
                        // hotelModel = value;
                      },
                    ),
                  );
          },
        ),
        actions: [
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
