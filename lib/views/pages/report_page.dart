import 'package:flutter/material.dart';

class ReportsPage extends StatelessWidget {
  static const routeName = '/reports';
  const ReportsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reports'),
      ),
    );
  }
}
