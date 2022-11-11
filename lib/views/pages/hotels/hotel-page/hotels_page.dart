import 'package:flutter/material.dart';
import 'package:just_travel_admin/providers/districts_provider.dart';
import 'package:just_travel_admin/providers/hotel_provider.dart';
import 'package:just_travel_admin/utils/constants/urls.dart';
import 'package:just_travel_admin/views/pages/hotels/add-hotel-page/add_hotel_page.dart';
import 'package:just_travel_admin/views/pages/hotels/hotel-details-page/hotel_details_page.dart';
import 'package:just_travel_admin/views/pages/hotels/hotel-page/components/Trailing.dart';
import 'package:provider/provider.dart';

import '../../../widgets/network_image_loader.dart';

class HotelsPage extends StatelessWidget {
  static const routeName = '/hotels';

  const HotelsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.read<HotelProvider>().getAllHotels();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hotels'),
        actions: [
          IconButton(
            onPressed: () {
              context.read<HotelProvider>().getAllHotels();
            },
            icon: const Icon(Icons.refresh),
          ),
        ],
      ),
      body: Center(
        child: Consumer<HotelProvider>(
          builder: (context, hotelProvider, child) {
            return hotelProvider.hotelList.isEmpty
                ? const Text('No hotel added')
                : Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: ListView.builder(
                      // reverse: true,

                      itemCount: hotelProvider.hotelList.length,
                      itemBuilder: (context, index) {
                        final hotel = hotelProvider.hotelList[index];

                        return ListTile(
                          onTap: () {
                            Navigator.pushNamed(
                                context, HotelDetailsPage.routeName,
                                arguments: hotel.id);
                          },
                          contentPadding:
                              const EdgeInsets.symmetric(vertical: 5),
                          leading: SizedBox(
                            width: 50,
                            height: 100,
                            child:
                                hotel.photos != null && hotel.photos!.isNotEmpty
                                    ? NetworkImageLoader(
                                        image:
                                            '${baseUrl}uploads/${hotel.photos![0]}',
                                        width: 50,
                                        height: 100,
                                      )
                                    : Image.asset(
                                        'images/img.png',
                                        width: 50,
                                        height: 100,
                                      ),
                          ),

                          title: Text(hotel.name!),
                          subtitle: Text(hotel.type!),
                          // trailing: Trailing(
                          //   hotelId: hotel.id!,
                          // ),
                        );
                      },
                    ),
                  );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.read<DistrictsProvider>().getAllDivision();
          Navigator.pushNamed(context, AddHotelPage.routeName);
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
