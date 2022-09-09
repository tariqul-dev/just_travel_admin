import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../constants/urls.dart';
import '../../../providers/hotel_provider.dart';
import '../../../utils/dialogs/confirm_dialog.dart';
import '../../../utils/helper_functions.dart';
import '../../widgets/loading_widget.dart';
import 'add_hotel_page.dart';
import 'hotel_details_page.dart';

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
                          leading:
                              hotel.photos != null && hotel.photos!.isNotEmpty
                                  ? Image.network(
                                      '${baseUrl}uploads/${hotel.photos![0]}',
                                      height: 100,
                                      // width: 100,
                                      fit: BoxFit.cover,
                                    )
                                  : Image.asset('images/img.png'),
                          title: Text(hotel.name!),
                          subtitle: Text(hotel.type!),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              // edit button
                              IconButton(
                                onPressed: () {
                                  Navigator.pushNamed(
                                      context, AddHotelPage.routeName,
                                      arguments: hotel);
                                },
                                icon: const Icon(Icons.edit),
                              ),

                              //delete button
                              IconButton(
                                onPressed: () {
                                  confirmDialog(
                                    context,
                                    'Delete',
                                    (isConfirmed) {
                                      if (isConfirmed) {
                                        showLoadingDialog(context);
                                        hotelProvider
                                            .deleteHotelById(hotel.id!)
                                            .then(
                                              (value) => Navigator.pop(context),
                                            )
                                            .onError(
                                              (error, stackTrace) => showMsg(
                                                  context, error.toString()),
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
                          ),
                        );
                      },
                    ),
                  );
          },
        ),
        // child: FutureBuilder<List<HotelModel>>(
        //   future: context.read<HotelProvider>().getAllHotels(),
        //   builder: (context, snapshot) {
        //     if (snapshot.hasData) {
        //       return ListView.builder(
        //         itemCount: snapshot.data?.length,
        //         itemBuilder: (context, index) => ListTile(
        //           title:
        //               Text(snapshot.data![index].name!),
        //         ),
        //       );
        //     } else if (snapshot.hasError) {
        //       return const Text('No hotels');
        //     } else {
        //       return const CircularProgressIndicator();
        //     }
        //   },
        // ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, AddHotelPage.routeName);
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
