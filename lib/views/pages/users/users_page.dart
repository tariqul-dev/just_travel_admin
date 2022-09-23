import 'package:flutter/material.dart';

class UsersPage extends StatelessWidget {
  static const routeName = '/users';

  const UsersPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Users'),
      ),
    );
  }
}
