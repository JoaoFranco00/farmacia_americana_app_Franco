import 'package:flutter/material.dart';
import 'package:farmacia_app/app/app_routes.dart';

class WelcomeViewModel extends ChangeNotifier {
  void navigateToLogin(BuildContext context) {
    Navigator.of(context).pushNamed(AppRoutes.login);
  }

  void navigateToRegister(BuildContext context) {
    Navigator.of(context).pushNamed(AppRoutes.register);
  }

  void enterAsGuest() {
    // Lógica futura para persistir estado de visitante
    debugPrint("Entrando como visitante...");
  }
}
