// import 'package:flutter/material.dart';
// import 'package:just_travel_admin/models/db-models/hotel_model.dart';
// import 'package:just_travel_admin/providers/hotel_provider.dart';
// import 'package:provider/provider.dart';
//
// class HotelDropdown extends StatelessWidget {
//   final String city;
//   const HotelDropdown({required this.city, Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(8.0),
//
//       child: FutureBuilder<List<HotelModel>?>(
//         future: context.read<HotelProvider>().getHotelsByCity(city),
//         builder: (context, snapshot) {
//           if (snapshot.hasError) {
//             return const Text('Error');
//           }
//           if (snapshot.hasData) {
//             final hotels = snapshot.data;
//
//             return
//           }
//           return const Center(
//             child: CircularProgressIndicator(),
//           );
//         },
//       ),
//     );
//   }
// }
