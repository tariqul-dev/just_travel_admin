import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';

// this function will return formatted date
String getFormattedDateTime(
    {required num dateTime, String pattern = 'dd/MM/yyyy'}) {
  DateTime dt = DateTime.fromMillisecondsSinceEpoch(dateTime as int);
  return DateFormat(pattern).format(dt);
}

//show toast message
showMsg(BuildContext context, String msg) =>
    Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        fontSize: 16.0
    );
