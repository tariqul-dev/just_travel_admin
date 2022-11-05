import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/db-models/districts_model.dart';
import '../../providers/districts_provider.dart';
import '../../providers/hotel_provider.dart';

class DistrictDropDown extends StatelessWidget {
  const DistrictDropDown({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Text('Select District'),
        const SizedBox(
          width: 30,
        ),
        Consumer<DistrictsProvider>(
          builder: (context, districtsProvider, child) {
            return districtsProvider.districtsList.isEmpty
                ? const Text('Loading ...')
                : DropdownButton<DistrictsModel>(
                    hint: const Text('Tap To Select'),
                    value: districtsProvider.district,
                    items: districtsProvider.districtsList
                        .map(
                          (e) => DropdownMenuItem<DistrictsModel>(
                            value: e,
                            child: Text('${e.district}'),
                          ),
                        )
                        .toList(),
                    onChanged: (value) {
                      districtsProvider.setDistrictFromDropDown(value);
                      if (value != null) {
                        //TODO: case insensitive search implementation
                        context
                            .read<HotelProvider>()
                            .getHotelsByDistrict(value.district!);
                      }
                    },
                  );
          },
        ),
      ],
    );
  }
}
