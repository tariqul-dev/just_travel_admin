import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../providers/review_provider.dart';
import '../../../../../providers/user_provider.dart';
import '../../../../../utils/helper_functions.dart';
import '../../../../widgets/custom_form_field.dart';
import '../../../../widgets/loading_widget.dart';

addReviewDialog({
  required BuildContext context,
  required String tripId,
}) {
  TextEditingController reviewController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: const Text('Add Review'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Form(
            key: formKey,
            child: CustomFormField(
              controller: reviewController,
              labelText: 'Leave a message',
              maxLine: 4,
              isPrefIcon: false,
            ),
          ),
        ],
      ),
      actions: [
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          ),
          onPressed: () {
            if (formKey.currentState!.validate()) {
              showLoadingDialog(context);
              context
                  .read<ReviewProvider>()
                  .addReview(
                      tripId: tripId,
                      userId: context.read<UserProvider>().user!.id!,
                      review: reviewController.text.trim())
                  .then((value) {
                Navigator.pop(context);
                reviewController.text = '';
                Navigator.pop(context);
                showMsg(context, 'Success');
              }).onError((error, stackTrace) {
                Navigator.pop(context);
                showMsg(context, 'Server error');
              });
            }
          },
          child: const Text('Add Review'),
        ),
      ],
    ),
  );
}
