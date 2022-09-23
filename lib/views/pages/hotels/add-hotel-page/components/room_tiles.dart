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
        var roomList = roomProvider.roomList;
        return roomList.isEmpty
            ? const Text('No room added')
            : ListView.builder(
                itemCount: roomList.length,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) => ListTile(
                  contentPadding: const EdgeInsets.all(0),
                  leading: Image.network(
                    '${baseUrl}uploads/${roomList[index].photos![0]}',
                    height: 100,
                    width: 100,
                    fit: BoxFit.cover,
                  ),
                  title: Text(roomList[index].title!),
                  subtitle: Text(roomList[index].status!),
                  trailing: Text(roomList[index].price!.toString()),
                ),
              );
      },
    );
  }
}
