import 'package:flutter/material.dart';
import 'package:just_travel_admin/views/pages/report_page.dart';
import 'package:just_travel_admin/views/pages/settings_page.dart';
import 'package:just_travel_admin/views/pages/trips/trips_page.dart';
import 'package:just_travel_admin/views/pages/users_page.dart';
import '../../models/ui/dashboard_item_model.dart';
import '../widgets/dashboard_item_view.dart';
import 'hotels/hotels_page.dart';
import 'offers_page.dart';

class DashBoardPage extends StatelessWidget {
  static const routeName = '/dashboard';
  const DashBoardPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
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

      case DashboardItem.offers:
        route = OffersPage.routeName;
        break;

      case DashboardItem.users:
        route = UsersPage.routeName;
        break;

      case DashboardItem.setting:
        route = SettingsPage.routeName;
        break;

      case DashboardItem.report:
        route = ReportsPage.routeName;
        break;
    }

    return route;
  }
}
