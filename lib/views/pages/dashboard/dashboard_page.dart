import 'package:flutter/material.dart';
import 'package:just_travel_admin/models/ui/dashboard_item_model.dart';
import 'package:just_travel_admin/views/pages/hotels/hotel-page/hotels_page.dart';
import 'package:just_travel_admin/views/pages/payments/payments_page.dart';
import 'package:just_travel_admin/views/pages/requested_trips/requested_trips_page.dart';
import 'package:just_travel_admin/views/pages/trips/trip-page/trips_page.dart';
import 'package:just_travel_admin/views/pages/users/users_page.dart';
import 'package:just_travel_admin/views/pages/dashboard/components/dashboard_item_view.dart';
import 'package:provider/provider.dart';

import '../../../providers/auth_provider.dart';
import '../launcher_page.dart';
import '../notifiable-trip-page/notifiable-trips_page.dart';

class DashBoardPage extends StatelessWidget {
  static const routeName = '/dashboard';

  const DashBoardPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
        actions: [
          IconButton(onPressed: (){
            context.read<AuthProvider>().signOut().then(
                  (value) => Navigator.pushNamedAndRemoveUntil(
                  context, LauncherPage.routeName, (route) => false),
            );
          }, icon: const Icon(Icons.logout),),
        ],
      ),
      body: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 4,
          mainAxisSpacing: 4,
        ),
        itemCount: dashboardItems.length,
        itemBuilder: (context, index) => DashboardItemView(
          item: dashboardItems[index],
          onPressed: (value) {
            final route = selectedRoute(value);
            Navigator.pushNamed(context, route);
          },
        ),
      ),
    );
  }

  String selectedRoute(String value) {
    String route = '';
    switch (value) {
      case DashboardItem.trips:
        route = TripsPage.routeName;
        break;
      case DashboardItem.hotels:
        route = HotelsPage.routeName;
        break;

      case DashboardItem.reqTrips:
        route = RequestedTripsPage.routeName;
        break;

      case DashboardItem.users:
        route = UsersPage.routeName;
        break;

      // case DashboardItem.setting:
      //   route = SettingsPage.routeName;
      //   break;

      // case DashboardItem.report:
      //   route = ReportsPage.routeName;
      //   break;

        case DashboardItem.payments:
        route = PaymentsPage.routeName;
        break;

        case DashboardItem.notifiableTrips:
        route = NotifiableTripsPage.routeName;
        break;
    }

    return route;
  }
}
