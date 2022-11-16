import 'package:flutter/material.dart';
import 'package:just_travel_admin/models/db-models/user_model.dart';
import 'package:provider/provider.dart';

import '../../../../providers/user_provider.dart';
import '../../../../utils/constants/urls.dart';
import '../../../../utils/helper_functions.dart';
import '../../../widgets/profile_circular_image.dart';
import 'components/p_widget.dart';

class ProfilePage extends StatelessWidget {
  static const routeName = '/profile';
  final UserModel user;
  const ProfilePage({required this.user, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // final userProvider = context.read<UserProvider>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // profile pic, name, email, verified section
              Row(
                children: [
                  Stack(
                    children: [
                      user.profileImage == null
                          ? CircleAvatar(
                              radius: 50,
                              child: Text(
                                user.name!.substring(0, 2),
                                style: Theme.of(context)
                                    .textTheme
                                    .headline4!
                                    .copyWith(
                                      color: Colors.white,
                                    ),
                              ),
                            )
                          : ProfileCircularImage(
                              radius: 55,
                              width: 150,
                              height: 150,
                              image: '${baseUrl}uploads/${user.profileImage}',
                            ),
                    ],
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // user name
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.5,
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: ConstrainedBox(
                            constraints: BoxConstraints(
                              maxWidth: MediaQuery.of(context).size.width * 0.5,
                            ),
                            child: Text(
                              '${user.name}',
                              style: const TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 6,
                      ),
                      // email
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.5,
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: ConstrainedBox(
                            constraints: BoxConstraints(
                              maxWidth: MediaQuery.of(context).size.width * 0.5,
                            ),
                            child: Text(
                              '${user.email!.emailId}',
                              style: const TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                                color: Colors.grey,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      // verified status section
                      Row(
                        children: [
                          const Text('Verified'),
                          const SizedBox(
                            width: 5,
                          ),
                          Icon(
                            Icons.verified,
                            size: 15,
                            color: user.email?.isVerified == true
                                ? Colors.green
                                : Colors.red,
                          ),
                        ],
                      )
                    ],
                  ),
                ],
              ),

              const SizedBox(height: 20),

              ProfileCustomWidgets(
                title: 'About',
                info: user.about ?? 'Write something about you',
                updateKey: 'about',
              ),
              const SizedBox(height: 5),
              ProfileCustomWidgets(
                title: 'Mobile Number',
                info: user.mobile!.number ?? 'Add mobile number',
                updateKey: 'mobile',
              ),
              const SizedBox(height: 5),
              ProfileCustomWidgets(
                title: 'Gender',
                info: user.gender != null
                    ? user.gender![0].toUpperCase() +
                        user.gender!.substring(1).toLowerCase()
                    : 'Select gender',
                updateKey: 'gender',
              ),
              const SizedBox(height: 5),
              ProfileCustomWidgets(
                title: 'Date of Birth',
                info: user.dob != null
                    ? getFormattedDateTime(
                        dateTime: user.dob!, pattern: 'MMM dd yyyy')
                    : 'Add your date of birth',
                updateKey: 'dob',
              ),
              const SizedBox(height: 5),
              ProfileCustomWidgets(
                title: 'Address',
                info: '${user.district}, ${user.division}',
                updateKey: 'address',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
