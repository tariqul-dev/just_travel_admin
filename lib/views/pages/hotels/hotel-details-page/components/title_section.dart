import 'package:flutter/material.dart';
import 'package:just_travel_admin/models/db-models/hotel_model.dart';

class TitleSection extends StatelessWidget {
  final HotelModel hotel;
  const TitleSection({required this.hotel, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListTile(
        contentPadding: const EdgeInsets.all(0),
        title: Text(
          hotel!.name!,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(
          hotel.type!,
          style: const TextStyle(
            fontSize: 13,
          ),
        ),
        trailing: IconButton(
          onPressed: () {},
          icon: const Icon(Icons.edit),
        ),
      ),
    );
  }
}
