import 'package:flutter/material.dart';
import 'package:farmacia_app/app/app_routes.dart';
import 'package:farmacia_app/features/auth/data/mocks/mock_users.dart';
import 'package:farmacia_app/features/auth/data/models/user_model.dart';
import 'package:farmacia_app/features/auth/view_models/auth_session_view_model.dart';
import 'package:provider/provider.dart';

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
    final emailInput = emailController.text.trim().toLowerCase();
    final passwordInput = passwordController.text.trim();

    debugPrint('--- TENTATIVA DE LOGIN ---');
    debugPrint("Email digitado: '$emailInput'");
    debugPrint("Senha digitada: '$passwordInput'");

    final users = MockUsers.getUsers();
    User? authenticatedUser;

    for (final user in users) {
      if (user.email.toLowerCase() == emailInput &&
          user.password == passwordInput) {
        authenticatedUser = user;
        break;
      }
    }

    if (authenticatedUser == null) {
      debugPrint('ERRO: Usuário não encontrado ou credenciais incorretas.');
      _showErrorSnackBar(context, 'E-mail ou senha inválidos!');
      return;
    }

    debugPrint(
      'Usuário encontrado: ${authenticatedUser.name} | Role: ${authenticatedUser.role}',
    );

    try {
      context.read<AuthSessionViewModel>().login(authenticatedUser);

      if (authenticatedUser.role == UserRole.cliente) {
        Navigator.pushNamedAndRemoveUntil(
          context,
          AppRoutes.homeClient,
          (route) => false,
        );
      } else if (authenticatedUser.role == UserRole.atendente) {
        Navigator.pushNamedAndRemoveUntil(
          context,
          AppRoutes.homeAttendant,
          (route) => false,
        );
      } else if (authenticatedUser.role == UserRole.gerente) {
        Navigator.pushNamedAndRemoveUntil(
          context,
          AppRoutes.homeManager,
          (route) => false,
        );
      } else {
        _showErrorSnackBar(
          context,
          'Acesso para ${authenticatedUser.role.name.toUpperCase()} em desenvolvimento!',
          isWarning: true,
        );
      }
    } catch (e, s) {
      debugPrint('ERRO DE NAVEGAÇÃO: $e');
      debugPrint('$s');
      _showErrorSnackBar(
        context,
        'Falha ao abrir a tela do perfil ${authenticatedUser.role.name}.',
      );
    }
  }

  // Helper para mostrar mensagens de erro/aviso
  void _showErrorSnackBar(
    BuildContext context,
    String message, {
    bool isWarning = false,
  }) {
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
