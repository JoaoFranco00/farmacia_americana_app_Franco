import 'package:flutter/material.dart';

class RegisterViewModel extends ChangeNotifier {
  // Controladores (Encapsulados como final para boa prática de POO)
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  // Estados Privados
  bool _obscurePassword = true;
  bool _obscureConfirm = true;
  bool _acceptedTerms = false;
  bool _isLoading = false; // Estado para feedback visual futuro

  // Getters
  bool get obscurePassword => _obscurePassword;
  bool get obscureConfirm => _obscureConfirm;
  bool get acceptedTerms => _acceptedTerms;
  bool get isLoading => _isLoading;

  //  Métodos de Alternância de Interface  
  
  void togglePasswordVisibility() {
    _obscurePassword = !_obscurePassword;
    notifyListeners();
  }

  void toggleConfirmVisibility() {
    _obscureConfirm = !_obscureConfirm;
    notifyListeners();
  }

  void setAcceptedTerms(bool? value) {
    _acceptedTerms = value ?? false;
    notifyListeners();
  }

  // Métodos de Ação (Lógica de Negócio) 

  Future<void> register() async {
    if (!_acceptedTerms) {
      debugPrint("Erro: Termos não aceitos");
      return;
    }

    if (passwordController.text != confirmPasswordController.text) {
      debugPrint("Erro: As senhas não coincidem");
      return;
    }

    _isLoading = true;
    notifyListeners();

    try {
      final name = nameController.text;
      final email = emailController.text;
      
      // Simulação de delay de rede
      await Future.delayed(const Duration(seconds: 2));
      
      debugPrint("Sucesso: Criando conta para $name ($email)");
      // Aqui entrará a chamada para o Repository/Firebase/API futuramente
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Métodos exigidos pelos SocialButtons (Corrigindo erros de DART)
  void registerWithGoogle() {
    debugPrint("Log: Iniciando fluxo de autenticação com Google");
    // Futura integração com GoogleSignIn
  }

  void registerWithFacebook() {
    debugPrint("Log: Iniciando fluxo de autenticação com Facebook");
    // Futura integração com FacebookAuth
  }

  // Limpeza de Memória
  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }
}