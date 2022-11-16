import 'package:flutter/material.dart';
import 'package:just_travel_admin/providers/trip_provider.dart';
import 'package:just_travel_admin/utils/helper_functions.dart';
import 'package:provider/provider.dart';
import '../../../widgets/custom_form_field.dart';
import '../../../widgets/loading_widget.dart';

sendEmailDialog({
  required BuildContext context,
  required String tripId,
}) {
  TextEditingController messageController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: const Text('Send Notification'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Form(
            key: formKey,
            child: CustomFormField(
              controller: messageController,
              labelText: 'Write message here',
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
            showLoadingDialog(context);
            if (formKey.currentState!.validate()) {
              context
                  .read<TripProvider>()
                  .notifyUsersByTripId(tripId, messageController.text.trim())
                  .then((value) {
                Navigator.pop(context);
                showMsg(context, 'Notified');
                Navigator.pop(context);
              }).onError((error, stackTrace) {
                Navigator.pop(context);
                showMsg(context, 'Failed To Notify users');
              });
            }
          },
          child: const Text('Send'),
        ),
      ],
    ),
  );
}
