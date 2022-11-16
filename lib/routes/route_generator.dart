import 'package:flutter/material.dart';

import '../models/db-models/user_model.dart';
import '../views/pages/dashboard/dashboard_page.dart';
import '../views/pages/error/error_page.dart';
import '../views/pages/hotels/add-hotel-page/add_hotel_page.dart';
import '../views/pages/hotels/hotel-details-page/hotel_details_page.dart';
import '../views/pages/hotels/hotel-page/hotels_page.dart';
import '../views/pages/hotels/room-details-page/room_details_page.dart';
import '../views/pages/launcher_page.dart';
import '../views/pages/notifiable-trip-page/notifiable-trips_page.dart';
import '../views/pages/payments/payments_page.dart';
import '../views/pages/reports/report_page.dart';
import '../views/pages/requested_trips/requested_trips_page.dart';
import '../views/pages/settings/settings_page.dart';
import '../views/pages/signin/signin_page.dart';
import '../views/pages/trips/add-trips-page/add_trips_page.dart';
import '../views/pages/trips/trip-details-page/trip_details_page.dart';
import '../views/pages/trips/trip-page/trips_page.dart';
import '../views/pages/users/profile-page/profile_page.dart';
import '../views/pages/users/users_page.dart';

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
          builder: (context) => AddHotelPage(),
        );

      case RoomDetailsPage.routeName:
        return MaterialPageRoute(
          builder: (context) => RoomDetailsPage(roomId: args as String),
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
      case TripDetailsPage.routeName:
        return MaterialPageRoute(
          builder: (context) => TripDetailsPage(tripId: args as String),
        );

      /*
    * ============= Trips route end ============*/

      /*
    * ============= Requested trip route Start ============*/
      case RequestedTripsPage.routeName:
        return MaterialPageRoute(
          builder: (context) => const RequestedTripsPage(),
        );

      /*
    * ============= Requested trip route end ============*/

      /*
    * ============= Notifiable trip route Start ============*/
      case NotifiableTripsPage.routeName:
        return MaterialPageRoute(
          builder: (context) => const NotifiableTripsPage(),
        );

      /*
    * ============= Upcoming route end ============*/

      /*
    * ============= report route Start ============*/
      case ReportsPage.routeName:
        return MaterialPageRoute(
          builder: (context) => const ReportsPage(),
        );

      /*
    * ============= report route end ============*/

      /*
    * ============= Settings route Start ============*/
      case SettingsPage.routeName:
        return MaterialPageRoute(
          builder: (context) => const SettingsPage(),
        );
      /*
    * ============= Settings route end ============*/
      /*
    * ============= Payment route Start ============*/
      case PaymentsPage.routeName:
        return MaterialPageRoute(
          builder: (context) => const PaymentsPage(),
        );

      /*
    * ============= Payment route end ============*/

      /*
    * ============= User route Start ============*/
      case UsersPage.routeName:
        return MaterialPageRoute(
          builder: (context) => const UsersPage(),
        );

      case ProfilePage.routeName:
        return MaterialPageRoute(
          builder: (context) => ProfilePage(user: args as UserModel),
        );

      /*
    * ============= User route end ============*/

      default:
        return MaterialPageRoute(
          builder: (context) => const ErrorPage(),
        );
    }
  }
}
