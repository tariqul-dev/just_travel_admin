import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

// this function will return formatted date
String getFormattedDateTime({required num dateTime, String pattern = 'dd/MM/yyyy'}) {
  DateTime dt = DateTime.fromMillisecondsSinceEpoch(dateTime as int);
  return DateFormat(pattern).format(dt);
}

//snackbar message
showMsg(BuildContext context, String msg) =>
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(msg),
      ),
    );
