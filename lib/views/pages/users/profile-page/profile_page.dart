import 'package:flutter/material.dart';
import 'package:just_travel_admin/models/db-models/user_model.dart';
import 'package:provider/provider.dart';

import '../../../../utils/constants/urls.dart';
import '../../../widgets/profile_circular_image.dart';
import 'components/user_details_row.dart';

class ProfilePage extends StatelessWidget {
  static const routeName = 'users/profile';
  UserModel user;
  ProfilePage({required this.user, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // final userProvider = context.read<UserProvider>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        elevation: 0,
      ),
      body: ListView(
        children: [
          // profile image, name, and email section
          Container(
            height: 300,
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              borderRadius: const BorderRadius.only(
                bottomRight: Radius.circular(20),
                bottomLeft: Radius.circular(20),
              ),
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  user.profileImage == null
                      ? CircleAvatar(
                          radius: 30,
                          child: Text(
                            user.name!.substring(0, 2),
                          ),
                        )
                      : ProfileCircularImage(
                          radius: 70,
                          width: 150,
                          height: 150,
                          image:
                              '${baseUrl}uploads/${user.profileImage}',
                        ),
                  const SizedBox(
                    height: 30,
                  ),
                  Text(
                    user.name!,
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: Colors.white60,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        user!.email!.emailId!,
                        style:
                        Theme.of(context).textTheme.titleMedium!.copyWith(
                          color: Colors.white60,
                        ),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Icon(
                        Icons.verified,
                        size: 20,
                        color: user.email?.isVerified == true
                            ? Colors.green
                            : Colors.red,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),

          // other profile details
          const SizedBox(
            height: 50,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Details',
              style: Theme.of(context).textTheme.headline5!.copyWith(
                    color: Theme.of(context).primaryColor,
                  ),
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          // mobile number
          UserDetailsRow(
            fieldName: 'Mobile Number: ',
            value: user.mobile!.number ?? 'No number added',
          ),
          // city
          UserDetailsRow(
            fieldName: 'Current City: ',
            value: user.district ?? 'No number added',
          ),
          // division
          UserDetailsRow(
            fieldName: 'Current Division: ',
            value: user.division ?? 'No number added',
          ),
        ],
      ),
    );
  }
}
