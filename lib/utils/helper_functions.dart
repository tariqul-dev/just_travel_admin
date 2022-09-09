import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

// this function will return formatted date
String getFormattedDateTime({required DateTime dateTime, String pattern = 'dd/MM/yyyy'}) =>
    DateFormat(pattern).format(dateTime);

//snackbar message
showMsg(BuildContext context, String msg) =>
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(msg),
      ),
    );
