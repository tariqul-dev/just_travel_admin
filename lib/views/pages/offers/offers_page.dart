import 'package:flutter/material.dart';

class OffersPage extends StatelessWidget {
  static const routeName = '/offers';

  const OffersPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Offers'),
      ),
    );
  }
}
