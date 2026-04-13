import 'package:flutter/material.dart';
import 'package:farmacia_app/core/palette/pallete.dart';

class BiTopProducts extends StatelessWidget {
  final List<Map<String, dynamic>> products;

  const BiTopProducts({super.key, required this.products});

  // Retorna medalha ou número para o ranking
  String _rankLabel(int index) {
    switch (index) {
      case 0:
        return '🥇';
      case 1:
        return '🥈';
      case 2:
        return '🥉';
      default:
        return '${index + 1}.';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Pallete.whiteColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Pallete.borderColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Título
          const Text(
            'MAIS VENDIDOS DO PERÍODO',
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w700,
              color: Pallete.textColor,
              letterSpacing: 1.2,
            ),
          ),

          const SizedBox(height: 20),

          // Lista de produtos
          Column(
            children: products.asMap().entries.map((entry) {
              final index = entry.key;
              final product = entry.value;
              final units = product['units'] as int;
              final max = product['max'] as int;
              final progress = units / max;
              final isTop3 = index < 3;

              return Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Ranking + nome + unidades
                    Row(
                      children: [
                        SizedBox(
                          width: 28,
                          child: Text(
                            _rankLabel(index),
                            style: TextStyle(
                              fontSize: isTop3 ? 16 : 13,
                              fontWeight: FontWeight.w700,
                              color: Pallete.textColor,
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            product['name'],
                            style: const TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF0F172A),
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Text(
                          '$units un',
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                            color: Pallete.primaryRed,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 8),

                    // Barra de progresso
                    Padding(
                      padding: const EdgeInsets.only(left: 36),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(99),
                        child: LinearProgressIndicator(
                          value: progress,
                          minHeight: 8,
                          backgroundColor:
                              Pallete.primaryRed.withOpacity(0.08),
                          valueColor: AlwaysStoppedAnimation<Color>(
                            isTop3
                                ? Pallete.primaryRed
                                : Pallete.primaryRed.withOpacity(0.5),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}