import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../providers/user_provider.dart';
import '../dialog/update_dialog.dart';

class ProfileCustomWidgets extends StatelessWidget {
  String title;
  String info;
  String updateKey;

  ProfileCustomWidgets({
    required this.title,
    required this.info,
    required this.updateKey,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        // boxShadow: const [
        //   BoxShadow(
        //       color: Color(0xffC3CED6),
        //       blurRadius: 5,
        //       spreadRadius: 1,
        //       offset: Offset(4, 4)
        //   ),
        // ],
        // color: Colors.white30,
      ),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.grey,
              ),
            ),
            // SizedBox(height: 2,),
            Text(
              info,
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
