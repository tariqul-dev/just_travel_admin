import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../models/db-models/room_model.dart';
import '../../../../../models/db-models/trip_model.dart';
import '../../../../../providers/room_provider.dart';
import '../../../../widgets/loading_widget.dart';
import '../../../../widgets/number_of_traveler_picker.dart';

roomSelectionDialog({
  required BuildContext context,
  required String hotelId,
  required TripModel trip,
  required Function(RoomModel roomModel, num numberOfTravellers) onSelectRoom,
}) =>
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Room Selection'),
        // body
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const NumberOfTravelerPicker(),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Room Status',
                  style: Theme.of(context).textTheme.headline6!.copyWith(
                        fontSize: 16,
                      ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Row(
                  children: [
                    Consumer<RoomProvider>(
                      builder: (context, roomProvider, child) => Radio<String>(
                        value: 'ac',
                        groupValue: roomProvider.selectedRoomStatusGroupValue,
                        onChanged: (value) {
                          roomProvider.setRoomStatus(value!);
                        },
                      ),
                    ),
                    const Text('AC'),
                  ],
                ),
                Row(
                  children: [
                    Consumer<RoomProvider>(
                      builder: (context, roomProvider, child) => Radio<String>(
                        value: 'non ac',
                        groupValue: roomProvider.selectedRoomStatusGroupValue,
                        onChanged: (value) {
                          roomProvider.setRoomStatus(value!);
                        },
                      ),
                    ),
                    const Text('Non AC'),
                  ],
                ),
              ],
            ),
          ],
        ),

        //actions buttons
        actions: [
          TextButton(
            onPressed: () {
              context.read<RoomProvider>().reset();
              Navigator.pop(context);
            },
            child: const Text('Cancel'),
          ),
          // ElevatedButton(
          //   onPressed: () {
          //     // context.read<RoomProvider>().getRoomByQuery();
          //     showLoadingDialog(context);
          //     context
          //         .read<RoomProvider>()
          //         .getRoomsByHotelIdStatusCapacity(hotelId)
          //         .then((value) {
          //       Navigator.pop(context);
          //       showRoomsDialog(
          //         context: context,
          //         trip: trip,
          //         onSelectRoom: (roomModel) {
          //           onSelectRoom(roomModel,
          //               context.read<RoomProvider>().numberOfTravellers);
          //         },
          //       );
          //     }).onError((error, stackTrace) {
          //       showMsg(context, error.toString());
          //       Navigator.pop(context);
          //     });
          //   },
          //   child: const Text('Next'),
          // ),
        ],
      ),
    );
