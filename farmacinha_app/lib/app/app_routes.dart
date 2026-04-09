// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:farmacia_app/features/splash/view/splash_screen.dart';
import 'package:farmacia_app/features/auth/views/welcome_screen.dart';
import 'package:farmacia_app/features/auth/views/login_screen.dart';
import 'package:farmacia_app/features/auth/views/register_screen.dart';
import 'package:farmacia_app/features/client/home_client/view/home_client_screen.dart';
import 'package:farmacia_app/features/attendant/home_attendant/view/home_attendant_screen.dart';

class AppRoutes {
  static const String splash = '/';
  static const String welcome = '/welcome';
  static const String login = '/login';
  static const String register = '/register';
 static const String homeClient = '/home_client';
  static const String homeAttendant = '/home_attendant';

  static Map<String, WidgetBuilder> get routes => {
        splash: (_) => SplashScreen(),
        welcome: (_) => WelcomeScreen(),
        login: (_) => LoginScreen(),
        register: (_) => RegisterScreen(),
        homeClient: (_) => HomeClientScreen(),
        homeAttendant: (_) => HomeAttendantScreen()
      };
}