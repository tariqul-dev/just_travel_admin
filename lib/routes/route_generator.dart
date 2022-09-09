import 'package:flutter/material.dart';

import '../models/db-models/hotel_model.dart';
import '../views/pages/dashboard_page.dart';
import '../views/pages/error/error_page.dart';
import '../views/pages/hotels/add_hotel_page.dart';
import '../views/pages/hotels/hotel_details_page.dart';
import '../views/pages/hotels/hotels_page.dart';
import '../views/pages/hotels/room_details_page.dart';
import '../views/pages/launcher_page.dart';
import '../views/pages/offers_page.dart';
import '../views/pages/report_page.dart';
import '../views/pages/settings_page.dart';
import '../views/pages/signin_page.dart';
import '../views/pages/trips/add_trips_page.dart';
import '../views/pages/trips/trips_page.dart';
import '../views/pages/users_page.dart';

class RouteGenerator {
  static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    final args = settings.arguments;

    switch (settings.name) {
      case LauncherPage.routeName:
        return MaterialPageRoute(
          builder: (context) => const LauncherPage(),
        );
      case SignInPage.routeName:
        return MaterialPageRoute(
          builder: (context) => SignInPage(),
        );
      case DashBoardPage.routeName:
        return MaterialPageRoute(
          builder: (context) => const DashBoardPage(),
        );

    /*
    * ============= Hotel route start ============*/
      case HotelsPage.routeName:
        return MaterialPageRoute(
          builder: (context) => const HotelsPage(),
        );

      case HotelDetailsPage.routeName:
        return MaterialPageRoute(
          builder: (context) => HotelDetailsPage(id: args as String),
        );
      case AddHotelPage.routeName:
        return MaterialPageRoute(
          builder: (context) => AddHotelPage(
            args: args,
          ),
        );

      case RoomDetailsPage.routeName:
        return MaterialPageRoute(
          builder: (context) => RoomDetailsPage(
            room: args as Rooms,
          ),
        );

    /*
    * ============= Hotel route end ============*/

    /*
    * ============= Trips route start ============*/
      case TripsPage.routeName:
        return MaterialPageRoute(
          builder: (context) => const TripsPage(),
        );

        case AddTripsPage.routeName:
        return MaterialPageRoute(
          builder: (context) => AddTripsPage(),
        );

    /*
    * ============= Trips route end ============*/

      case OffersPage.routeName:
        return MaterialPageRoute(
          builder: (context) => const OffersPage(),
        );
      case ReportsPage.routeName:
        return MaterialPageRoute(
          builder: (context) => const ReportsPage(),
        );
      case SettingsPage.routeName:
        return MaterialPageRoute(
          builder: (context) => const SettingsPage(),
        );

      case UsersPage.routeName:
        return MaterialPageRoute(
          builder: (context) => const UsersPage(),
        );

      default:
        return MaterialPageRoute(
          builder: (context) => const ErrorPage(),
        );
    }
  }
}
