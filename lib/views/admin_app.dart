import 'package:flutter/material.dart';
import 'package:just_travel_admin/views/pages/launcher_page.dart';

import '../routes/route_generator.dart';
class AdminApp extends StatelessWidget {
  const AdminApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: LauncherPage.routeName,
      onGenerateRoute: RouteGenerator.onGenerateRoute,
    );
  }
}
