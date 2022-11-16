import 'package:flutter/material.dart';
import 'package:just_travel_admin/providers/auth_provider.dart';
import 'package:just_travel_admin/views/pages/dashboard/dashboard_page.dart';
import 'package:just_travel_admin/views/pages/signin/signin_page.dart';
import 'package:provider/provider.dart';

import '../../providers/user_provider.dart';

class LauncherPage extends StatefulWidget {
  static const routeName = '/';

  const LauncherPage({Key? key}) : super(key: key);

  @override
  State<LauncherPage> createState() => _LauncherPageState();
}

class _LauncherPageState extends State<LauncherPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    AuthProvider authProvider = context.read<AuthProvider>();

    UserProvider userProvider = context.read<UserProvider>();
    Future.delayed(
      Duration.zero,
      () async {
        //TODO: fix routing and authentication
        print('launcher page is deciding');
        print('current user: ${authProvider.getCurrentUser()}');
        if (authProvider.getCurrentUser() != null) {
          try {
            await userProvider
                .fetchUserByEmail(authProvider.getCurrentUser()!.email!);
            Navigator.pushNamedAndRemoveUntil(
                context, DashBoardPage.routeName, (route) => false);
          } catch (error) {
            print('error at launcher page: $error');
          }
        } else {
          Navigator.pushNamedAndRemoveUntil(
              context, SignInPage.routeName, (route) => false);
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
