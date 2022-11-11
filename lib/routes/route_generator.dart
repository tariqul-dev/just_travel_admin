import 'package:flutter/material.dart';
import 'package:just_travel_admin/models/db-models/hotel_model.dart';
import 'package:just_travel_admin/models/db-models/room_model.dart';
import 'package:just_travel_admin/models/db-models/user_model.dart';
import 'package:just_travel_admin/views/pages/dashboard/dashboard_page.dart';
import 'package:just_travel_admin/views/pages/error/error_page.dart';
import 'package:just_travel_admin/views/pages/hotels/add-hotel-page/add_hotel_page.dart';
import 'package:just_travel_admin/views/pages/hotels/hotel-details-page/hotel_details_page.dart';
import 'package:just_travel_admin/views/pages/hotels/hotel-page/hotels_page.dart';
import 'package:just_travel_admin/views/pages/hotels/room-details-page/room_details_page.dart';
import 'package:just_travel_admin/views/pages/launcher_page.dart';
import 'package:just_travel_admin/views/pages/payments/payments_page.dart';
import 'package:just_travel_admin/views/pages/reports/report_page.dart';
import 'package:just_travel_admin/views/pages/requested_trips/requested_trips_page.dart';
import 'package:just_travel_admin/views/pages/requested_trips/requested_trips_page.dart';
import 'package:just_travel_admin/views/pages/settings/settings_page.dart';
import 'package:just_travel_admin/views/pages/signin/signin_page.dart';
import 'package:just_travel_admin/views/pages/trips/add-trips-page/add_trips_page.dart';
import 'package:just_travel_admin/views/pages/trips/trip-details-page/trip_details_page.dart';
import 'package:just_travel_admin/views/pages/trips/trip-page/trips_page.dart';
import 'package:just_travel_admin/views/pages/users/profile-page/profile_page.dart';
import 'package:just_travel_admin/views/pages/users/users_page.dart';

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
          builder: (context) => TripDetailsPage(id: args as String),
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
    * ============= Report route Start ============*/
      case ReportsPage.routeName:
        return MaterialPageRoute(
          builder: (context) => const ReportsPage(),
        );
      /*
    * ============= Settings route Start ============*/
      case SettingsPage.routeName:
        return MaterialPageRoute(
          builder: (context) => const SettingsPage(),
        );
      /*
    * ============= User route Start ============*/
    /*
    * ============= Settings route Start ============*/
      case PaymentsPage.routeName:
        return MaterialPageRoute(
          builder: (context) => const PaymentsPage(),
        );
      /*
    * ============= User route Start ============*/
      case UsersPage.routeName:
        return MaterialPageRoute(
          builder: (context) => const UsersPage(),
        );

      case ProfilePage.routeName:
        return MaterialPageRoute(
          builder: (context) =>  ProfilePage(user: args as UserModel),
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
