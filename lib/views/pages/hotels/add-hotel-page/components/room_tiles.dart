import 'package:flutter/material.dart';
import 'package:just_travel_admin/providers/room_provider.dart';
import 'package:just_travel_admin/utils/constants/urls.dart';
import 'package:provider/provider.dart';

class RoomTiles extends StatelessWidget {
  const RoomTiles({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<RoomProvider>(
      builder: (context, roomProvider, child) {
        return roomProvider.roomList.isEmpty
            ? const Text('No room added')
            : ListView.builder(
                itemCount: roomProvider.roomList.length,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) => ListTile(
                  contentPadding: const EdgeInsets.all(0),
                  leading: Image.network(
                    '${baseUrl}uploads/${roomProvider.roomList[index].photos![0]}',
                    height: 100,
                    width: 100,
                    fit: BoxFit.cover,
                  ),
                  title: Text(roomProvider.roomList[index].title!),
                  subtitle: Text(roomProvider.roomList[index].status!),
                  trailing: Text(roomProvider.roomList[index].price!.toString()),
                ),
              );
      },
    );
  }
}
