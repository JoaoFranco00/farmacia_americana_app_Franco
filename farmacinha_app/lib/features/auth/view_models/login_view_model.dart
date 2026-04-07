import 'package:flutter/material.dart';
import 'package:farmacia_app/app/app_routes.dart';
import 'package:farmacia_app/features/auth/data/mocks/mock_users.dart';
import 'package:farmacia_app/features/auth/data/models/user_model.dart';

class LoginViewModel extends ChangeNotifier {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool _isRememberMe = false;
  bool _obscurePassword = true;

  bool get isRememberMe => _isRememberMe;
  bool get obscurePassword => _obscurePassword;

  void toggleRememberMe(bool? value) {
    _isRememberMe = value ?? false;
    notifyListeners();
  }

  void togglePasswordVisibility() {
    _obscurePassword = !_obscurePassword;
    notifyListeners();
  }

  Future<void> login(BuildContext context) async {
    final email = emailController.text.trim();
    final password = passwordController.text.trim();

    debugPrint("Tentativa de login - Usuário: $email");

    try {
      // Busca o usuário no Mock seguindo as credenciais
      final user = MockUsers.getUsers().firstWhere(
        (u) => u.email.toLowerCase() == email.toLowerCase() && u.password == password,
      );

      // Redirecionamento baseado no Role
      // Apenas o cliente vai para a HomeClient por enquanto
      if (user.role == UserRole.cliente) {
        Navigator.pushReplacementNamed(context, AppRoutes.homeClient);
      } else {
        // Para os outros cargos, podemos exibir um alerta ou log enquanto as telas não existem
        debugPrint("Usuário ${user.name} logado como ${user.role}. Tela em desenvolvimento.");
        
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Acesso para ${user.role.name} ainda em desenvolvimento!"),
            backgroundColor: Colors.orange,
          ),
        );
      }
    } catch (e) {
      // Se o firstWhere não encontrar ninguém, ele lança um erro
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("E-mail ou senha inválidos!"),
          backgroundColor: Colors.redAccent,
        ),
      );
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}