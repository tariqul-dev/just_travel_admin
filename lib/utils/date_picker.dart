import 'package:flutter/material.dart';

datePicker({
  required BuildContext context,
  required DateTime initialDate,
  required DateTime firstDate,
  required DateTime lastDate,
  required Function(DateTime? dateTime) onSelect,
}) async {
  DateTime? selectedDate = await showDatePicker(
    context: context,
    initialDate: initialDate,
    firstDate: firstDate,
    lastDate: lastDate,
  );
  if (selectedDate != null) {
    onSelect(selectedDate);
  } else {
    onSelect(null);
  }
}
