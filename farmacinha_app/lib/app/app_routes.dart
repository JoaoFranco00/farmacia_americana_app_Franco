// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:farmacia_app/features/splash/view/splash_screen.dart';
import 'package:farmacia_app/features/auth/views/welcome_screen.dart';
import 'package:farmacia_app/features/auth/views/login_screen.dart';
import 'package:farmacia_app/features/auth/views/register_screen.dart';
import 'package:farmacia_app/features/client/home_client/view/home_client_screen.dart';
import 'package:farmacia_app/features/attendant/home_attendant/view/attendant_search_screen.dart';
import 'package:farmacia_app/features/attendant/home_attendant/view/home_attendant_screen.dart';
import 'package:farmacia_app/features/attendant/home_attendant/view/attendant_notications_screen.dart';

// ── Rotas das features do cliente  ──────────────────────────────────────
import 'package:farmacia_app/features/client/account/view/account_screen.dart';
import 'package:farmacia_app/features/client/orders/list/view/orders_screen.dart';
import 'package:farmacia_app/features/client/notifications/view/notifications_screen.dart';
import 'package:farmacia_app/features/client/purchase_history/view/purchase_history_screen.dart';
import 'package:farmacia_app/features/client/account/view/personal_data_screen.dart';

// ── Rotas do Gerente ───────────────────────────────────────────────────────────
import 'package:farmacia_app/features/manager/manager_shell_screen.dart';

class AppRoutes {
  // ── Auth ──────────────────────────────────────────────────────────────────
  static const String splash = '/';
  static const String welcome = '/welcome';
  static const String login = '/login';
  static const String register = '/register';

  // ── Homes por perfil ──────────────────────────────────────────────────────
  static const String homeClient = '/home_client';
  static const String homeAttendant = '/home_attendant';
  static const String attendantSearch = '/attendant_search';
  static const String attendantChat = homeAttendant;
    static const String attendantNotifications = '/attendant_notifications';
  static const String homeManager = '/home_manager';

  // ── Features do cliente ───────────────────────────────────────────────────
  static const String account = '/account';
  static const String orders = '/orders';
  static const String notifications = '/notifications';
  static const String purchaseHistory = '/purchase_history';
  static const String personalData = '/personal_data';

  static Map<String, WidgetBuilder> get routes => {
        splash: (_) => SplashScreen(),
        welcome: (_) => WelcomeScreen(),
        login: (_) => LoginScreen(),
        register: (_) => RegisterScreen(),
        homeClient: (_) => HomeClientScreen(),
        homeAttendant: (_) => HomeAttendantScreen(),
        attendantSearch: (_) => AttendantSearchScreen(),
        attendantNotifications: (_) => AttendantNotificationsScreen(),
        account: (_) => AccountScreen(),
        orders: (_) => OrdersScreen(),
        notifications: (_) => NotificationsScreen(),
        purchaseHistory: (_) => PurchaseHistoryScreen(),
        homeManager: (_) => ManagerShellScreen(),
        personalData: (_) => PersonalDataScreen(),
      };
}