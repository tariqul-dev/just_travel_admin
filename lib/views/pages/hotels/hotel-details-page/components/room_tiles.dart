import 'package:flutter/material.dart';
import 'package:just_travel_admin/models/db-models/room_model.dart';
import 'package:just_travel_admin/providers/room_provider.dart';
import 'package:just_travel_admin/utils/constants/symbols.dart';
import 'package:just_travel_admin/utils/constants/urls.dart';
import 'package:just_travel_admin/views/pages/hotels/hotel-details-page/dialog/add_room_dialog.dart';
import 'package:just_travel_admin/views/pages/hotels/room-details-page/room_details_page.dart';
import 'package:provider/provider.dart';

import '../../../../widgets/network_image_loader.dart';

class HotelDetailsRoomTiles extends StatelessWidget {
  final String hotelId;
  const HotelDetailsRoomTiles({required this.hotelId, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Future.delayed(
      Duration.zero,
      () {
        context.read<RoomProvider>().getRoomsByHotelId(hotelId);
      },
    );
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Rooms',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              IconButton(
                onPressed: () {
                  addRoomDialog(context, hotelId);
                },
                icon: const Icon(Icons.add),
              ),
            ],
          ),
          Consumer<RoomProvider>(
            builder: (context, provider, child) {
              return provider.roomList.isEmpty
                  ? const Text('No room added')
                  : ListView.builder(
                      itemCount: provider.roomList.length,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) => ListTile(
                        onTap: () {
                          Navigator.pushNamed(
                              context, RoomDetailsPage.routeName,
                              arguments: provider.roomList[index].id);
                        },
                        contentPadding: const EdgeInsets.all(0),
                        leading: SizedBox(
                          width: 50,
                          height: 100,
                          child: NetworkImageLoader(
                            image:
                                '${baseUrl}uploads/${provider.roomList[index].photos![0]}',
                            width: 50,
                            height: 100,
                          ),
                        ),
                        title: Text(provider.roomList[index].title!),
                        subtitle: Text(provider.roomList[index].status!),
                        trailing: Text(
                            '$currencySymbol${provider.roomList[index].price}'),
                      ),
                    );
            },
          ),
          // FutureBuilder<List<RoomModel>?>(
          //   future: context.read<RoomProvider>().getRoomsByHotelId(hotelId),
          //   builder: (context, snapshot) {
          //     if (snapshot.hasError) {
          //       return const Text('Error');
          //     }
          //     if (snapshot.hasData) {
          //       final rooms = snapshot.data;
          //
          //       return Padding(
          //         padding: const EdgeInsets.all(8.0),
          //         child: rooms!.isEmpty
          //             ? const Text('No room added')
          //             : ListView.builder(
          //                 itemCount: rooms.length,
          //                 shrinkWrap: true,
          //                 physics: const NeverScrollableScrollPhysics(),
          //                 itemBuilder: (context, index) => ListTile(
          //                   onTap: () {
          //                     Navigator.pushNamed(
          //                         context, RoomDetailsPage.routeName,
          //                         arguments: rooms[index].id);
          //                   },
          //                   contentPadding: const EdgeInsets.all(0),
          //
          //                   leading: SizedBox(
          //                       width: 50,
          //                       height: 100,
          //                       child: NetworkImageLoader(
          //                         image:
          //                             '${baseUrl}uploads/${rooms[index].photos![0]}',
          //                         width: 50,
          //                         height: 100,
          //                       )),
          //                   // leading: Image.network(
          //                   //   '${baseUrl}uploads/${rooms[index].photos![0]}',
          //                   //   height: 100,
          //                   //   width: 100,
          //                   //   fit: BoxFit.cover,
          //                   // ),
          //                   title: Text(rooms[index].title!),
          //                   subtitle: Text(rooms[index].status!),
          //                   trailing:
          //                       Text('$currencySymbol${rooms[index].price}'),
          //                 ),
          //               ),
          //       );
          //     }
          //     return const Center(
          //       child: CircularProgressIndicator(),
          //     );
          //   },
          // ),
        ],
      ),
    );
  }
}
