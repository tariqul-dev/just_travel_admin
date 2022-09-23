import 'package:flutter/material.dart';

confirmDialog(
    BuildContext context, String title, Function(bool isConfirmed) onConfirm) {
  return showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) => AlertDialog(
      title: Text(title),
      content: const Text('Are you sure?'),
      actions: [
        ElevatedButton(
          onPressed: () {
            onConfirm(false);
            Navigator.pop(context);
          },
          child: const Text('CANCEL'),
        ),
        ElevatedButton(
          onPressed: () {
            onConfirm(true);
            Navigator.pop(context);
          },
          child: const Text('CONFIRM'),
        ),
      ],
    ),
  );
}
