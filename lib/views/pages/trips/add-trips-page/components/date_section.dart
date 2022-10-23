import 'package:flutter/material.dart';
import 'package:just_travel_admin/providers/trip_provider.dart';
import 'package:just_travel_admin/utils/date_picker.dart';
import 'package:just_travel_admin/utils/helper_functions.dart';
import 'package:provider/provider.dart';

class DateSection extends StatelessWidget {
  const DateSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
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
                  context.read<TripProvider>().setTripStartDate(dateTime);
                },
              );
            },
            child: Consumer<TripProvider>(
              builder: (context, tripProvider, child) => Text(
                tripProvider.tripStartDate != null
                    ? getFormattedDateTime(
                        dateTime:
                            tripProvider.tripStartDate!.millisecondsSinceEpoch)
                    : 'Select Start Date',
              ),
            ),
          ),
        ),
        Expanded(
          child: TextButton(
            onPressed: () async {
              datePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime.now(),
                lastDate: DateTime(3030),
                onSelect: (dateTime) {
                  context.read<TripProvider>().setTripEndDate(dateTime);
                },
              );
            },
            child: Consumer<TripProvider>(
              builder: (context, tripProvider, child) => Text(
                tripProvider.tripEndDate != null
                    ? getFormattedDateTime(
                        dateTime:
                            tripProvider.tripEndDate!.millisecondsSinceEpoch)
                    : 'Select End Date',
              ),
            ),
          ),
        ),
      ],
    );
  }
}
