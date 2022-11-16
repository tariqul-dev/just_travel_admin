import 'package:flutter/material.dart';
import 'package:just_travel_admin/models/db-models/user_model.dart';
import 'package:just_travel_admin/providers/user_provider.dart';
import 'package:just_travel_admin/views/pages/users/profile-page/profile_page.dart';
import 'package:provider/provider.dart';

import '../../../utils/constants/urls.dart';
import '../../../utils/helper_functions.dart';
import '../../widgets/network_image_loader.dart';
import '../../widgets/profile_circular_image.dart';

class UsersPage extends StatelessWidget {
  static const routeName = '/users';

  const UsersPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Future.delayed(
      Duration.zero,
      () {
        context.read<UserProvider>().onInit();
      },
    );
    return Scaffold(
      appBar: AppBar(
        title: const Text('Users'),
      ),
      body: Center(
        child: Consumer<UserProvider>(
          builder: (context, userProvider, child) {
            // List<UserModel> userList = userProvider.userList;
            return userProvider.userList.isEmpty
                ? const Text('No Trip added')
                : ListView.builder(
                    itemCount: userProvider.userList.length,
                    itemBuilder: (context, index) {
                      UserModel user = userProvider.userList[index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                        ),
                        child: ListTile(
                          onTap: () {
                            Navigator.pushNamed(
                              context,
                              ProfilePage.routeName,
                              arguments: user,
                            );
                          },
                          contentPadding:
                              const EdgeInsets.symmetric(vertical: 5),
                          leading: SizedBox(
                              width: 50,
                              height: 100,
                              child: user.profileImage != null &&
                                      user.profileImage!.isNotEmpty
                                  ? CircleAvatar(
                                      radius: 60,
                                      child: ClipRRect(
                                        clipBehavior: Clip.antiAlias,
                                        borderRadius: BorderRadius.circular(60),
                                        child: ProfileCircularImage(
                                          radius: 60,
                                          width: 50,
                                          height: 50,
                                          image:
                                              '${baseUrl}uploads/${user.profileImage}',
                                        ),
                                      ),
                                    )
                                  : CircleAvatar(
                                      radius: 50,
                                      child: Text(
                                        user.name!.substring(0, 2),
                                      ),
                                    )),
                          title: Text(user.name!),
                          subtitle: Text(user.email!.emailId!),
                          // trailing: Row(
                          //   mainAxisSize: MainAxisSize.min,
                          //   children: [
                          //     // edit button
                          //     IconButton(
                          //       onPressed: () {
                          //         // Navigator.pushNamed(
                          //         //     context, AddHotelPage.routeName,
                          //         //     arguments: hotel);
                          //       },
                          //       icon: const Icon(Icons.edit),
                          //     ),
                          //
                          //     //delete button
                          //     IconButton(
                          //       onPressed: () {
                          //         confirmDialog(
                          //           context,
                          //           'Delete',
                          //           (isConfirmed) {
                          //             if (isConfirmed) {
                          //               showLoadingDialog(context);
                          //               // hotelProvider
                          //               //     .deleteHotelById(hotel.id!)
                          //               //     .then(
                          //               // (value) => Navigator.pop(context),
                          //               // )
                          //               //     .onError(
                          //               // (error, stackTrace) => showMsg(
                          //               // context, error.toString()),
                          //               // );
                          //             }
                          //           },
                          //         );
                          //       },
                          //       icon: const Icon(
                          //         Icons.delete,
                          //         color: Colors.red,
                          //       ),
                          //     ),
                          //   ],
                          // ),
                        ),
                      );
                    },
                  );
          },
        ),
      ),
    );
  }
}
