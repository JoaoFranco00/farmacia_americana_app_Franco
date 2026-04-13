import 'package:flutter/material.dart';
import 'package:farmacia_app/core/palette/pallete.dart';

class StockProductCard extends StatelessWidget {
  final String name;
  final String category;
  final int quantity;
  final double price;
  final bool isLowStock;

  const StockProductCard({
    super.key,
    required this.name,
    required this.category,
    required this.quantity,
    required this.price,
    required this.isLowStock,
  });

  // Retorna o ícone conforme a categoria do produto
  IconData _iconForCategory(String category) {
    switch (category) {
      case 'Medicamento':
        return Icons.medication_rounded;
      case 'Higiene':
        return Icons.soap_rounded;
      case 'Vitaminas':
        return Icons.eco_rounded;
      default:
        return Icons.inventory_2_rounded;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Pallete.whiteColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          // Borda vermelha para estoque baixo, cinza para normal
          color: isLowStock
              ? Pallete.primaryRed.withOpacity(0.4)
              : Pallete.borderColor,
          width: isLowStock ? 1.5 : 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Ícone do produto + alerta de estoque baixo
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: Pallete.accentYellow.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(
                  _iconForCategory(category),
                  color: Pallete.primaryRed,
                  size: 24,
                ),
              ),

              // Ícone de alerta quando estoque está baixo
              if (isLowStock)
                Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: Pallete.primaryRed.withOpacity(0.08),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: const Icon(
                    Icons.warning_amber_rounded,
                    color: Pallete.primaryRed,
                    size: 16,
                  ),
                ),
            ],
          ),

          const SizedBox(height: 12),

          // Nome do produto
          Text(
            name,
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w700,
              color: Color(0xFF0F172A),
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),

          const SizedBox(height: 4),

          // Categoria
          Text(
            category,
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w600,
              color: Pallete.textColor,
            ),
          ),

          const Spacer(),

          const Divider(height: 16, color: Pallete.borderColor),

          // Quantidade e preço
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Quantidade — vermelho se baixo, verde se normal
              Text(
                'Qtd: $quantity',
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                  color: isLowStock
                      ? Pallete.primaryRed
                      : const Color(0xFF10B981),
                ),
              ),

              // Preço
              Text(
                'R\$ ${price.toStringAsFixed(2).replaceAll('.', ',')}',
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF0F172A),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}