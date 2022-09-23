import 'package:flutter/material.dart';

class UploadImageCard extends StatelessWidget {
  final Widget child;
  final VoidCallback onTap;

  const UploadImageCard({
    required this.child,
    required this.onTap,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: child,
        ),
      ),
    );
  }
}
