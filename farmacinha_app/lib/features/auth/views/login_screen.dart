import 'package:flutter/material.dart';
import 'package:farmacia_app/core/widgets/gradient_button.dart';
import 'package:farmacia_app/core/widgets/social.button.dart';
import 'package:farmacia_app/core/widgets/login_field.dart';
import 'package:farmacia_app/core/widgets/password_field.dart';
import 'package:farmacia_app/core/palette/pallete.dart';
import 'package:farmacia_app/features/auth/view_models/login_view_model.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // Instanciando a ViewModel (em um app real, usaríamos injeção de dependência)
  final LoginViewModel viewModel = LoginViewModel();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListenableBuilder(
        listenable: viewModel,
        builder: (context, _) {
          return SingleChildScrollView(
            child: Center(
              child: Column(
                children: [
                  const SizedBox(height: 140),
                  const Text(
                    'Login',
                    style: TextStyle(
                      fontSize: 50,
                      color: Color.fromARGB(255, 233, 206, 120),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 50),

                  const LoginField(
                    hintText: 'Email',
                    // controller: viewModel.emailController, // Adicione o controller no seu LoginField
                  ),
                  const SizedBox(height: 16),

                  PasswordField(
                    controller: viewModel.passwordController,
                    obscureText: viewModel.obscurePassword,
                    onToggleVisibility: viewModel.togglePasswordVisibility,
                  ),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 35),
                    child: Row(
                      children: [
                        SizedBox(
                          height: 40,
                          width: 36,
                          child: Checkbox(
                            side: const BorderSide(color: Pallete.borderColor),
                            value: viewModel.isRememberMe,
                            activeColor: const Color.fromARGB(
                              255,
                              233,
                              206,
                              120,
                            ),
                            onChanged: viewModel.toggleRememberMe,
                          ),
                        ),
                        const SizedBox(width: 2),
                        const Text(
                          'Salvar Login',
                          style: TextStyle(
                            fontSize: 14,
                            color: Pallete.textColor,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 30),
                  const GradientButton(), // Aqui você pode passar o viewModel.login no onPressed futuro

                  const SizedBox(height: 52),
                  const Text(
                    'ou',
                    style: TextStyle(
                      fontSize: 17,
                      color: Color.fromARGB(126, 36, 36, 36),
                    ),
                  ),
                  const SizedBox(height: 20),

                  SocialButton(
                    iconName: 'g_logo',
                    label: 'Entrar com Google',
                    iconColor: Pallete.googleLogo,
                    textColor: Pallete.textColor,
                    horizontalPadding: 80.0,
                    onPressed: () {},
                  ),
                  const SizedBox(height: 25),
                  SocialButton(
                    iconName: 'f_logo',
                    iconColor: Pallete.facebookLogo,
                    label: 'Entrar com Facebook',
                    textColor: Pallete.textColor,
                    onPressed: () {},
                  ),
                  const SizedBox(height: 25),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
