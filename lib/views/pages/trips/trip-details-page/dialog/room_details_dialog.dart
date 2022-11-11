import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../models/db-models/room_model.dart';
import '../../../../../models/db-models/trip_model.dart';
import '../../../../../providers/room_provider.dart';
import '../../../../../utils/constants/symbols.dart';
import '../../../../widgets/expandable_text_widget.dart';
import '../../../../widgets/image_grid_view.dart';
import '../../../../widgets/image_slider.dart';

roomDetailsDialog({
  required BuildContext context,
  required String roomId,
  required TripModel trip,
  required Function(RoomModel roomModel) onSelectRoom,
}) async {
  await context.read<RoomProvider>().getRoomsByRoomId(roomId);
  showDialog(
    context: context,
    builder: (context) => Consumer<RoomProvider>(
      builder: (context, roomProvider, child) {
        final room = roomProvider.room;
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          title: room == null
              ? const Text('Error')
              : Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  elevation: 10,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListTile(
// contentPadding: const EdgeInsets.all(0),
                      title: Text(room.title!,
                          style: Theme.of(context).textTheme.headline6),
                      subtitle: Text('Peoples: ${room.maxCapacity}'),
                      trailing: Text(
                        '$currencySymbol${room.price}',
                        style: Theme.of(context).textTheme.caption!.copyWith(
                              fontSize: 18,
                              fontWeight: FontWeight.w800,
                            ),
                      ),
                    ),
                  ),
                ),
          content: room == null
              ? const Text('No room found')
              : Container(
                  width: MediaQuery.of(context).size.width,
                  padding: const EdgeInsets.all(0),
                  child: ListView(
                    padding: const EdgeInsets.all(0),
                    children: [
                      ListTile(
                        title: const Text('Room status'),
                        trailing: Text(
                          room.status!.toUpperCase(),
                          style: Theme.of(context)
                              .textTheme
                              .headline6!
                              .copyWith(fontSize: 14),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        height: 200,
                        width: MediaQuery.of(context).size.width,
                        child: room.photos!.length >= 4
                            ? ImageGridView(
                                imageList: room.photos!,
                              )
                            : ImageSlider(photos: room.photos!),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      ExpandableTextWidget(text: room.description!),
                    ],
                  ),
                ),
          actions: [
            Center(
              child: room?.isAvailable == true ||
                      DateTime.fromMillisecondsSinceEpoch(
                                  trip.startDate!.toInt())
                              .difference(DateTime.now())
                              .inDays >
                          1
                  ? ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                            vertical: 20, horizontal: 30),
                        shape: const StadiumBorder(),
                      ),
                      onPressed: () {
                        onSelectRoom(room!);
                        context
                            .read<RoomProvider>()
                            .setRoomSelectedStatus(true);
                        int count = 0;
                        Navigator.popUntil(context, (route) {
                          return count++ == 3;
                        });
                      },
                      child: const Text('BOOK NOW'),
                    )
                  : const Text('This room is already Booked'),
            ),
          ],
        );
      },
    ),
  );
}
