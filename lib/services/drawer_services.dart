import 'package:flutter/material.dart';
import 'package:indian_zaika_vendor/components/main_screen.dart';
import 'package:indian_zaika_vendor/screens/cupons_screen.dart';
import 'package:indian_zaika_vendor/screens/home_screen.dart';
import 'package:indian_zaika_vendor/screens/menu_screen.dart';
import 'package:indian_zaika_vendor/screens/orders_screen.dart';
import 'package:indian_zaika_vendor/screens/reports_screen.dart';
import 'package:indian_zaika_vendor/screens/settings_screen.dart';

class DrawerServices {
  Widget drawerScreen(title, services) {
    if (title == 'Dashboard') {
      return MainScreen();
    }
    if (title == 'Coupons') {
      return CuponsScreen();
    }
    if (title == 'Menu') {
      return MenuScreen();
    }
    if (title == 'Orders') {
      return OrdersScreen();
    }
    if (title == 'Reports') {
      return ReportsScreen();
    }
    if (title == 'Setting') {
      return SettingsScreen();
    }
    return MainScreen();
  }
}
