import 'package:flutter/material.dart';
import 'package:farmacia_app/app/app_routes.dart';
import 'package:farmacia_app/features/auth/view_models/auth_session_view_model.dart';
import 'package:provider/provider.dart';

class WelcomeViewModel extends ChangeNotifier {
  void navigateToLogin(BuildContext context) {
    Navigator.of(context).pushNamed(AppRoutes.login);
  }

  void navigateToRegister(BuildContext context) {
    Navigator.of(context).pushNamed(AppRoutes.register);
  }

  void enterAsGuest(BuildContext context) {
    debugPrint("Entrando como visitante...");
    context.read<AuthSessionViewModel>().enterAsGuest();
    Navigator.pushNamed(context, AppRoutes.homeClient);
  }
}
