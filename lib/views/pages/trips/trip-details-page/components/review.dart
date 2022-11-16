import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../models/db-models/user_model.dart';
import '../../../../../providers/review_provider.dart';
import '../../../../../providers/user_provider.dart';
import '../../../../../utils/constants/urls.dart';
import '../../../../../utils/helper_functions.dart';
import '../../../../widgets/network_image_loader.dart';
import '../../../../widgets/profile_circular_image.dart';
import '../dialog/add_review_dialog.dart';

class Review extends StatelessWidget {
  String tripId;
  Review({required this.tripId, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Future.delayed(
      Duration.zero,
      () {
        context.read<ReviewProvider>().getAllReviewByTripId(tripId);
      },
    );

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Package Review',
            style: Theme.of(context).textTheme.headline6,
          ),
          const SizedBox(
            height: 10,
          ),

          // review add button
          Align(
            alignment: Alignment.centerRight,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              ),
              onPressed: () {
                addReviewDialog(context: context, tripId: tripId);
              },
              child: const Text('Add Review'),
            ),
          ),

          Consumer<ReviewProvider>(
            builder: (context, reviewProvider, child) {
              return reviewProvider.reviewList.isEmpty
                  ? const Center(
                      child: Text('Empty Review'),
                    )
                  : ListView.builder(
                      shrinkWrap: true,
                      reverse: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: reviewProvider.reviewList.length,
                      itemBuilder: (context, index) => Container(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            FutureBuilder<UserModel?>(
                              future: context
                                  .read<UserProvider>()
                                  .fetchUserByUserId(
                                      reviewProvider.reviewList[index].user!),
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  final user = snapshot.data;
                                  return ListTile(
                                    leading: SizedBox(
                                      height: 50,
                                      width: 50,
                                      child: user!.profileImage == null
                                          ? CircleAvatar(
                                              radius: 50,
                                              child: Text(
                                                user.name!.substring(0, 2),
                                              ),
                                            )
                                          : ProfileCircularImage(
                                              radius: 50,
                                              width: 50,
                                              height: 50,
                                              image:
                                                  '${baseUrl}uploads/${user.profileImage}',
                                            ),
                                    ),
                                    title: Text(
                                      '${user.name}',
                                      style: Theme.of(context)
                                          .textTheme
                                          .headline6!
                                          .copyWith(
                                            fontSize: 15,
                                            color:
                                                Theme.of(context).primaryColor,
                                          ),
                                    ),
                                    subtitle: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 7),
                                      child: Text(
                                        '${reviewProvider.reviewList[index].review}',
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline5!
                                            .copyWith(
                                              fontSize: 15,
                                            ),
                                      ),
                                    ),
                                    trailing: Text(
                                      getFormattedDateTime(
                                        dateTime: reviewProvider
                                            .reviewList[index].date!,
                                        pattern: 'MMM dd, yyyy',
                                      ),
                                    ),
                                  );
                                }
                                if (snapshot.hasError) {
                                  return const Center(
                                    child: Text('Server Error'),
                                  );
                                }
                                return const Center(
                                  child: CircularProgressIndicator(),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    );
            },
          ),
        ],
      ),
    );
  }
}
