import 'package:flutter/material.dart';
import 'package:farmacia_app/pallete.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Pallete.backgroundColor,
      body: const SafeArea(
        child: SizedBox.expand(),
      ),
    );
  }
}