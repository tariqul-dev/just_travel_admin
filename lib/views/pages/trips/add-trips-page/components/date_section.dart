import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../providers/trip_provider.dart';
import '../../../../../utils/date_picker.dart';
import '../../../../../utils/helper_functions.dart';

class DateSection extends StatelessWidget {
  const DateSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Select Date',
          style: Theme.of(context).textTheme.headline6!.copyWith(
                fontSize: 14,
              ),
        ),
        Row(
          children: [
            Expanded(
              child: Row(
                children: [
                  Text(
                    'Start Date',
                    style: Theme.of(context).textTheme.headline6!.copyWith(
                          fontSize: 12,
                        ),
                  ),
                  TextButton(
                    onPressed: () async {
                      datePicker(
                        context: context,
                        initialDate:
                            DateTime.now().add(const Duration(days: 2)),
                        firstDate: DateTime.now().add(const Duration(days: 2)),
                        lastDate: DateTime(3030),
                        onSelect: (dateTime) {
                          context
                              .read<TripProvider>()
                              .setTripStartDate(dateTime);
                        },
                      );
                    },
                    child: Consumer<TripProvider>(
                      builder: (context, requestTripProvider, child) => Text(
                        requestTripProvider.tripStartDate != null
                            ? getFormattedDateTime(
                                dateTime: requestTripProvider
                                    .tripStartDate!.millisecondsSinceEpoch)
                            : 'Pick Date',
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Row(
                children: [
                  Text(
                    'End Date',
                    style: Theme.of(context).textTheme.headline6!.copyWith(
                          fontSize: 12,
                        ),
                  ),
                  TextButton(
                    onPressed: () async {
                      datePicker(
                        context: context,
                        initialDate:
                            context.read<TripProvider>().tripStartDate != null
                                ? context
                                    .read<TripProvider>()
                                    .tripStartDate!
                                    .add(const Duration(days: 1))
                                : DateTime.now().add(const Duration(days: 1)),
                        firstDate:
                            context.read<TripProvider>().tripStartDate != null
                                ? context
                                    .read<TripProvider>()
                                    .tripStartDate!
                                    .add(const Duration(days: 1))
                                : DateTime.now().add(const Duration(days: 1)),
                        lastDate: DateTime(3030),
                        onSelect: (dateTime) {
                          context.read<TripProvider>().setTripEndDate(dateTime);
                        },
                      );
                    },
                    child: Consumer<TripProvider>(
                      builder: (context, requestTripProvider, child) => Text(
                        requestTripProvider.tripEndDate != null
                            ? getFormattedDateTime(
                                dateTime: requestTripProvider
                                    .tripEndDate!.millisecondsSinceEpoch)
                            : 'Pick Date',
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
