import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../providers/join_trip_provider.dart';
import '../../../../../utils/constants/urls.dart';
import '../../../../widgets/network_image_loader.dart';
import '../../../../widgets/profile_circular_image.dart';
import '../../../users/profile-page/profile_page.dart';

showTravelersDialog({
  required BuildContext context,
}) =>
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('All Joined Travelers'),
        elevation: 5,
        content: Consumer<JoinTripProvider>(
          builder: (context, joinTripProvider, child) => joinTripProvider
                  .joinedUserList.isEmpty
              ? const Text('No joinedUser found')
              : SizedBox(
                  // height: MediaQuery.of(context).size.height * 0.5,
                  width: MediaQuery.of(context).size.width,
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: joinTripProvider.joinedUserList.length,
                    itemBuilder: (context, index) {
                      final joinedUser = joinTripProvider.joinedUserList[index];
                      final numberOfTravelers =
                          joinTripProvider.numberOfTravelerList[index];
                      return Container(
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        // todo: need to replace ListTile with other widget to fix render error

                        child: ListTile(
                          onTap: () {
                            Navigator.pushNamed(
                              context,
                              ProfilePage.routeName,
                              arguments: joinedUser,
                            );
                          },
                          leading: SizedBox(
                            width: 50,
                            height: 100,
                            child: joinedUser.profileImage != null &&
                                    joinedUser.profileImage!.isNotEmpty
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
                                            '${baseUrl}uploads/${joinedUser.profileImage}',
                                      ),
                                    ),
                                  )
                                : CircleAvatar(
                                    radius: 50,
                                    child: Text(
                                      joinedUser.name!.substring(0, 2),
                                    ),
                                  ),
                          ),
                          title: Text(joinedUser.name!),
                          subtitle: FittedBox(
                            fit: BoxFit.scaleDown,
                            // child: Text('${joinedUser.email?.emailId}'),
                            child: Text('${joinedUser.email!.emailId}'),
                          ),
                          trailing: Text(
                            '$numberOfTravelers',
                            style:
                                Theme.of(context).textTheme.caption!.copyWith(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w800,
                                    ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
        ),
      ),
    );
