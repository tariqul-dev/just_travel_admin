import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:just_travel_admin/providers/auth_provider.dart';
import 'package:just_travel_admin/providers/districts_provider.dart';
import 'package:just_travel_admin/providers/hotel_provider.dart';
import 'package:just_travel_admin/providers/join_trip_provider.dart';
import 'package:just_travel_admin/providers/payment_provider.dart';
import 'package:just_travel_admin/providers/requested_trips_provider.dart';
import 'package:just_travel_admin/providers/room_provider.dart';
import 'package:just_travel_admin/providers/trip_provider.dart';
import 'package:just_travel_admin/providers/user_provider.dart';
import 'package:just_travel_admin/views/admin_app.dart';
import 'package:provider/provider.dart';

void main() async {
  //initializing firebase app
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  // status bar theme
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      // statusBarBrightness: ,
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
    ),
  );

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => AuthProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => UserProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => HotelProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => RoomProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => TripProvider()..getAllTrips(),
        ),
        ChangeNotifierProvider(
          create: (context) => DistrictsProvider(),
        ),

        ChangeNotifierProvider(
          create: (context) => JoinTripProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => RequestedTripProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => PaymentProvider(),
        ),
      ],
      child: const AdminApp(),
    ),
  );
}
