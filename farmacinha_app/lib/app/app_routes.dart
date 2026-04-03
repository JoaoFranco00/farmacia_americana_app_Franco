// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:farmacia_app/features/splash/view/splash_screen.dart';
import 'package:farmacia_app/features/auth/views/welcome_screen.dart';
import 'package:farmacia_app/features/auth/views/login_screen.dart';
import 'package:farmacia_app/features/auth/views/register_screen.dart';

class AppRoutes {
  static const String splash = '/';
  static const String welcome = '/welcome';
  static const String login = '/login';
  static const String register = '/register';

  static Map<String, WidgetBuilder> get routes => {
        // Removi o 'const' de todos para evitar o erro de "not a const constructor"
        splash: (_) => SplashScreen(),   
        welcome: (_) => WelcomeScreen(), 
        login: (_) => LoginScreen(),     
        register: (_) => RegisterScreen(), 
      };
}