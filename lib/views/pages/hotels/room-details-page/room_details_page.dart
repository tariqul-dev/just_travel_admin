import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:just_travel_admin/models/db-models/room_model.dart';
import 'package:just_travel_admin/providers/room_provider.dart';
import 'package:just_travel_admin/utils/constants/symbols.dart';
import 'package:just_travel_admin/utils/constants/urls.dart';
import 'package:just_travel_admin/utils/helper_functions.dart';
import 'package:just_travel_admin/views/widgets/expandable_text_widget.dart';
import 'package:just_travel_admin/views/widgets/image_grid_view.dart';
import 'package:provider/provider.dart';

class RoomDetailsPage extends StatelessWidget {
  static const routeName = '/room-details-page';
  final String roomId;

  const RoomDetailsPage({required this.roomId, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Room Details'),
      ),
      body: FutureBuilder<RoomModel?>(
        future: context.read<RoomProvider>().getRoomsByRoomId(roomId),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Text('Error');
          }
          if (snapshot.hasData) {
            final room = snapshot.data;

            return Container(
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.all(0),
              child: ListView(
                padding: const EdgeInsets.all(0),
                children: [
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    elevation: 10,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListTile(
                        // contentPadding: const EdgeInsets.all(0),
                        title: Text(room!.title!,
                            style: Theme.of(context).textTheme.headline6),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(room!.status!),
                            Text('Capacity ${room.maxCapacity}'),
                          ],
                        ),
                        trailing: Text(
                          '$currencySymbol${room.price!}',
                          style:
                              Theme.of(context).textTheme.titleMedium!.copyWith(
                                    fontWeight: FontWeight.w700,
                                  ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 200,
                    width: MediaQuery.of(context).size.width,
                    child: ImageGridView(
                      imageList: room!.photos!,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  ExpandableTextWidget(text: room.description!),
                ],
              ),
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
