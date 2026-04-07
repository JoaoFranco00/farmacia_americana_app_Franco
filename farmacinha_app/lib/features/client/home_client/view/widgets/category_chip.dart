import 'package:flutter/material.dart';
import 'package:farmacia_app/core/palette/pallete.dart';

class CategoryChip extends StatelessWidget {
  /// Rótulo da categoria (ex: "Medicamentos", "Higiene", "Beleza")
  final String label;

  /// URL ou ícone da categoria
  final IconData? icon;

  /// Flag se a categoria está selecionada
  final bool isSelected;

  /// Callback ao clicar no chip
  final VoidCallback onTap;

  /// Quantidade de produtos (opcional)
  final int? productCount;

  const CategoryChip({
    super.key,
    required this.label,
    required this.onTap,
    this.icon,
    this.isSelected = false,
    this.productCount,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 10,
        ),
        decoration: BoxDecoration(
          // Fundo: gradiente se selecionado, cinzento se não
          gradient: isSelected
              ? const LinearGradient(
                  colors: [
                    Pallete.gradient1,
                    Pallete.gradient2,
                    Pallete.gradient3,
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                )
              : null,
          color: isSelected ? null : Pallete.grayColor,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(
            color: isSelected
                ? Pallete.gradient3
                : Pallete.borderColor,
            width: isSelected ? 2 : 1,
          ),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    // ignore: deprecated_member_use
                    color: Pallete.gradient3.withOpacity(0.3),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ]
              : null,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Ícone (se houver)
            if (icon != null) ...[
              Icon(
                icon,
                size: 18,
                color: isSelected
                    ? const Color.fromARGB(255, 50, 50, 50)
                    : Pallete.textColor,
              ),
              const SizedBox(width: 8),
            ],

            // Rótulo
            Text(
              label,
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: isSelected
                    ? const Color.fromARGB(255, 50, 50, 50)
                    : Pallete.textColor,
              ),
            ),

            // Quantidade de produtos (se houver)
            if (productCount != null) ...[
              const SizedBox(width: 6),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 6,
                  vertical: 2,
                ),
                decoration: BoxDecoration(
                  color: isSelected
                      ? Colors.black12
                      : Pallete.borderColor,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  '$productCount',
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: isSelected
                        ? const Color.fromARGB(255, 50, 50, 50)
                        : Pallete.textColor,
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
