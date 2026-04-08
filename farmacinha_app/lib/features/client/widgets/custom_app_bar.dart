import 'package:flutter/material.dart';
import 'package:farmacia_app/core/palette/pallete.dart';

/// AppBar customizada para o fluxo do cliente.
/// Implementa PreferredSizeWidget para que o Flutter aceite como uma AppBar oficial.
class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  /// Callback opcional para quando o usuário clica no logo/nome da farmácia.
  final VoidCallback? onLogoTap;

  const CustomAppBar({
    super.key,
    this.onLogoTap,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      // Elevação mínima para criar uma separação sutil do conteúdo
      elevation: 1,
      backgroundColor: Pallete.whiteColor,
      
      // Remove o botão de voltar automático caso haja navegação anterior
      automaticallyImplyLeading: false,

      // O título contém a identidade visual da 'Farmácia Americana'
      title: GestureDetector(
        onTap: onLogoTap,
        child: RichText(
          text: const TextSpan(
            children: [
              TextSpan(
                text: 'Farmácia ',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.italic,
                  color: Pallete.primaryRed,
                ),
              ),
              TextSpan(
                text: 'Americana',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.italic,
                  color: Pallete.accentYellow,
                ),
              ),
            ],
          ),
        ),
      ),
      
      // Centraliza o título para um visual mais moderno e equilibrado
      centerTitle: true,
      
      // Deixamos a lista de actions vazia para remover ícones da direita (como o sino)
      actions: const [],
    );
  }

  /// Define a altura padrão da AppBar no Flutter (56.0 pixels)
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}