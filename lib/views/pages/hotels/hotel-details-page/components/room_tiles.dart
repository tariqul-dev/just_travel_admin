import 'package:flutter/material.dart';
import 'package:just_travel_admin/models/db-models/room_model.dart';
import 'package:just_travel_admin/providers/room_provider.dart';
import 'package:just_travel_admin/utils/constants/urls.dart';
import 'package:just_travel_admin/views/pages/hotels/room-details-page/room_details_page.dart';
import 'package:provider/provider.dart';

class HotelDetailsRoomTiles extends StatelessWidget {
  final String hotelId;
  const HotelDetailsRoomTiles({required this.hotelId, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<RoomModel>?>(
      future: context.read<RoomProvider>().getRoomsByHotelId(hotelId),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Text('Error');
        }
        if (snapshot.hasData) {
          final rooms = snapshot.data;

          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: rooms!.isEmpty
                ? const Text('No room added')
                : ListView.builder(
                    itemCount: rooms.length,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) => ListTile(
                      onTap: () {
                        Navigator.pushNamed(context, RoomDetailsPage.routeName,
                            arguments: rooms[index].id);
                      },
                      contentPadding: const EdgeInsets.all(0),
                      leading: Image.network(
                        '${baseUrl}uploads/${rooms[index].photos![0]}',
                        height: 100,
                        width: 100,
                        fit: BoxFit.cover,
                      ),
                      title: Text(rooms[index].title!),
                      subtitle: Text(rooms[index].status!),
                      trailing: Text(rooms[index].price!.toString()),
                    ),
                  ),
          );
        }
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}
