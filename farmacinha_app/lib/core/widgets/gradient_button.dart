import 'package:flutter/material.dart';
import '../palette/pallete.dart';

class GradientButton extends StatelessWidget {
  final VoidCallback? onPressed; // Adicionado para receber a ação da ViewModel

  const GradientButton({super.key, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Pallete.gradient1, Pallete.gradient2, Pallete.gradient3],
          begin: Alignment.bottomLeft,
          end: Alignment.topRight,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: ElevatedButton(
        onPressed: onPressed, // Agora o botão executa a função passada
        style: ElevatedButton.styleFrom(
          fixedSize: const Size(330, 55),
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
        ),
        child: const Text(
          'Entrar',
          style: TextStyle(
            fontSize: 17,
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
