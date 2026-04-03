import 'package:flutter/material.dart';

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

  Future<void> login() async {
    final email = emailController.text;
    final password = passwordController.text;
    
    // Variável utilizada para evitar Warnings de POO
    debugPrint("Tentativa de login - Usuário: $email | Senha: $password");
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}