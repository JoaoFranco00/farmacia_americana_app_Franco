import 'package:flutter/material.dart';
import 'package:farmacia_app/pallete.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Pallete.backgroundColor,
      body: SafeArea(
        child: SizedBox.expand(),
      ),
    );
  }
}