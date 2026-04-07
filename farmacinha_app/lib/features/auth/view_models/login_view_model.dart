import 'package:flutter/material.dart';
import 'package:farmacia_app/app/app_routes.dart';
import 'package:farmacia_app/features/auth/data/mocks/mock_users.dart';
import 'package:farmacia_app/features/auth/data/models/user_model.dart';

class LoginViewModel extends ChangeNotifier {
  // Controles dos campos de texto
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool _isRememberMe = false;
  bool _obscurePassword = true;

  // Getters
  bool get isRememberMe => _isRememberMe;
  bool get obscurePassword => _obscurePassword;

  // Alternar "Salvar Login"
  void toggleRememberMe(bool? value) {
    _isRememberMe = value ?? false;
    notifyListeners();
  }

  // Alternar visibilidade da senha
  void togglePasswordVisibility() {
    _obscurePassword = !_obscurePassword;
    notifyListeners();
  }

  /// Método principal de Login
  Future<void> login(BuildContext context) async {
    // Pegamos os textos, removemos espaços (trim) e padronizamos o email para minúsculo
    final emailInput = emailController.text.trim().toLowerCase();
    final passwordInput = passwordController.text.trim();

    // LOG DE DEBUG: Verifique se esses valores aparecem no seu console ao clicar no botão
    debugPrint("--- TENTATIVA DE LOGIN ---");
    debugPrint("Email digitado: '$emailInput'");
    debugPrint("Senha digitada: '$passwordInput'");

    try {
      // Buscamos a lista de usuários mockados
      final users = MockUsers.getUsers();

      // Tentamos encontrar o usuário que coincida com Email E Senha
      final user = users.firstWhere(
        (u) => u.email.toLowerCase() == emailInput && u.password == passwordInput,
      );

      debugPrint("Usuário encontrado: ${user.name} | Role: ${user.role}");

      // Lógica de Redirecionamento baseada no Role
      if (user.role == UserRole.cliente) {
        // pushReplacementNamed remove a tela de login da pilha (impede voltar)
        Navigator.pushReplacementNamed(context, AppRoutes.homeClient);
      } else {
        // Caso seja Atendente, Farmacêutico ou Dono (Telas ainda não criadas)
        _showErrorSnackBar(
          context, 
          "Acesso para ${user.role.name.toUpperCase()} em desenvolvimento!",
          isWarning: true,
        );
      }
    } catch (e) {
      // Se o firstWhere não encontrar ninguém, ele cai aqui
      debugPrint("ERRO: Usuário não encontrado ou credenciais incorretas.");
      _showErrorSnackBar(context, "E-mail ou senha inválidos!");
    }
  }

  // Helper para mostrar mensagens de erro/aviso
  void _showErrorSnackBar(BuildContext context, String message, {bool isWarning = false}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: isWarning ? Colors.orange : Colors.redAccent,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}