import 'package:flutter/material.dart';
import 'package:farmacia_app/pallete.dart';
import 'package:farmacia_app/app_routes.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Drogaria Americana Saúde',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light().copyWith(
        scaffoldBackgroundColor: Pallete.backgroundColor,
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFFE31E24)),
      ),
      initialRoute: AppRoutes.splash,
      routes: AppRoutes.routes,
    );
  }
}