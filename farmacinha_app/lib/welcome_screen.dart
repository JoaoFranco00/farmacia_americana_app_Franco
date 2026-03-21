import 'package:flutter/material.dart';
import 'package:farmacia_app/pallete.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Pallete.backgroundColor,
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const SizedBox(height: 60),
                Image.asset(
                  'assets/images/logo.png',
                  width: 260,
                  fit: BoxFit.contain,
                ),
                const SizedBox(
                  child: Column(
                    children: [
                      Text(
                        'Seja Bem Vindo(a)!',
                        style: TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF1A1A1A),
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'Acesse sua conta ou crie sua conta',
                        style: TextStyle(
                          fontSize: 14,
                          color: Pallete.textColor,
                        ),
                      ),
                    ],
                  ),
                ), // placeholder para os próximos commits
                const SizedBox(), // placeholder para os próximos commits
              ],
            ),
          ),
        ),
      ),
    );
  }
}
