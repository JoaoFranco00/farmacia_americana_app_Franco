import 'package:flutter/material.dart';
import 'package:farmacia_app/app/app_routes.dart';

class SplashViewModel extends ChangeNotifier {
  /// Gerencia a inicialização do app e navega para a próxima tela
  Future<void> initializeApp(BuildContext context) async {
    // Simula o tempo de exibição da logo ou carregamento de dados/login
    await Future.delayed(const Duration(seconds: 3));

    if (context.mounted) {
      // Por enquanto, o destino padrão é a WelcomeScreen
      Navigator.of(context).pushReplacementNamed(AppRoutes.welcome);
    }
  }
}
