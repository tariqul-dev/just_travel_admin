import 'package:flutter/material.dart';

class AuthButton extends StatelessWidget {
  final String buttonName;
  final VoidCallback onPressed;
  const AuthButton({required this.buttonName, required this.onPressed, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.all(15),
        shape: const StadiumBorder(),
      ),
      onPressed: onPressed,
      child: Text(
        buttonName,
        style: Theme.of(context).textTheme.titleLarge!.copyWith(
          color: Colors.white70,
        ),
      ),
    );
  }
}
