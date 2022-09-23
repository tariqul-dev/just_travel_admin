import 'package:flutter/material.dart';
import 'package:just_travel_admin/providers/hotel_provider.dart';
import 'package:just_travel_admin/utils/constants/urls.dart';
import 'package:just_travel_admin/views/pages/hotels/add-hotel-page/dialog/hotel_image_picker_dialog.dart';
import 'package:just_travel_admin/views/widgets/upload_image_card.dart';
import 'package:provider/provider.dart';

class HotelImageSection extends StatelessWidget {
  const HotelImageSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        ElevatedButton.icon(
          icon: const Icon(Icons.add),
          label: const Text('Add Images'),
          onPressed: () {
            hotelImagePickerDialog(context);
          },
        ),
        const SizedBox(
          height: 10,
        ),
        // image upload section
        SizedBox(
          height: 300,
          child: Consumer<HotelProvider>(
            builder: (context, hotelProvider, child) {
              var hotelImageList = hotelProvider.hotelImageList;
              return hotelImageList.isEmpty
                  ? Image.asset(
                      'images/img.png',
                      height: 100,
                      width: 100,
                      fit: BoxFit.cover,
                    )
                  : GridView.builder(
                      itemCount: hotelImageList.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3),
                      itemBuilder: (context, index) => UploadImageCard(
                        child: Consumer<HotelProvider>(
                          builder: (context, hotelProvider, child) =>
                              Image.network(
                            '${baseUrl}uploads/${hotelProvider.hotelImageList[index]}',
                            height: 100,
                            width: 100,
                            fit: BoxFit.cover,
                          ),
                        ),
                        onTap: () {
                          print('index: $index');
                          hotelImagePickerDialog(context, index: index);
                        },
                      ),
                    );
            },
          ),
        ),
      ],
    );
  }
}
