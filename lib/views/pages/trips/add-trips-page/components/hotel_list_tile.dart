import 'package:flutter/material.dart';

import '../../../../../models/db-models/hotel_model.dart';
import '../../../../../utils/constants/urls.dart';
import '../../../../widgets/network_image_loader.dart';

class HotelListTile extends StatelessWidget {
  final HotelModel hotel;
  VoidCallback? onTap;
  HotelListTile({required this.hotel, this.onTap, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      leading: SizedBox(
        width: 50,
        height: 100,
        child: hotel.photos == null
            ? Image.asset(
          'images/img.png',
          width: 50,
          height: 100,
        )
            : NetworkImageLoader(
          image:
          '${baseUrl}uploads/${hotel.photos![0]}',
          width: 50,
          height: 100,
        ),
      ),
      title: Text(hotel.name!),
      subtitle: Text('Status: ${hotel.type}'),
      // trailing: Text(
      //   '$currencySymbol${hotel.id  }',
      //   style: Theme.of(context)
      //       .textTheme
      //       .caption!
      //       .copyWith(
      //         fontSize: 12,
      //         fontWeight: FontWeight.w800,
      //       ),
      // ),
    );
  }
}
