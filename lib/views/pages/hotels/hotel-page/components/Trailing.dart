import 'package:flutter/material.dart';
import 'package:just_travel_admin/providers/hotel_provider.dart';
import 'package:just_travel_admin/utils/helper_functions.dart';
import 'package:just_travel_admin/views/pages/hotels/add-hotel-page/add_hotel_page.dart';
import 'package:just_travel_admin/views/widgets/dialogs/confirm_dialog.dart';
import 'package:just_travel_admin/views/widgets/loading_widget.dart';
import 'package:provider/provider.dart';

class Trailing extends StatelessWidget {
  final String hotelId;
  const Trailing({required this.hotelId, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final hotelProvider = context.read<HotelProvider>();
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        // edit button
        IconButton(
          onPressed: () {
            Navigator.pushNamed(context, AddHotelPage.routeName);
          },
          icon: const Icon(Icons.edit),
        ),

        // delete button
        IconButton(
          onPressed: () {
            confirmDialog(
              context,
              'Delete',
              (isConfirmed) {
                if (isConfirmed) {
                  showLoadingDialog(context);
                  hotelProvider
                      .deleteHotelById(hotelId)
                      .then(
                        (value) => Navigator.pop(context),
                      )
                      .onError(
                        (error, stackTrace) =>
                            showMsg(context, error.toString()),
                      );
                }
              },
            );
          },
          icon: const Icon(
            Icons.delete,
            color: Colors.red,
          ),
        ),
      ],
    );
  }
}
