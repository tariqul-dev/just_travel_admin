import 'package:flutter/material.dart';

class DashboardItem{
  IconData icon;
  String title;

  DashboardItem({required this.icon, required this.title});

  static const String trips = 'Trips';
  static const String hotels = 'Hotels';
  static const String offers = 'Offers';
  static const String users = 'Users';
  static const String setting = 'Setting';
  static const String report = 'Report';
}

final List<DashboardItem> dashboardItems = [
  DashboardItem(icon: Icons.card_giftcard, title: DashboardItem.trips),
  DashboardItem(icon: Icons.category, title: DashboardItem.hotels),
  DashboardItem(icon: Icons.monetization_on, title: DashboardItem.offers),
  DashboardItem(icon: Icons.person, title: DashboardItem.users),
  DashboardItem(icon: Icons.settings, title: DashboardItem.setting),
  DashboardItem(icon: Icons.area_chart, title: DashboardItem.report),
];