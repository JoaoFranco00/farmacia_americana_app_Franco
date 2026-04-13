import 'package:flutter/material.dart';
import 'package:farmacia_app/core/palette/pallete.dart';

class ActivityHistory extends StatelessWidget {
  final List<Map<String, String>> activities;

  const ActivityHistory({
    super.key,
    required this.activities,
  });

  // Retorna a cor do indicador com base no tipo da atividade
  Color _colorForType(String type) {
    switch (type) {
      case 'success':
        return const Color(0xFF10B981); // verde
      case 'warning':
        return const Color(0xFFFAC000); // amarelo
      case 'error':
        return Pallete.primaryRed;      // vermelho
      default:
        return Pallete.textColor;
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
          // Título da seção
          const Text(
            'HISTÓRICO DE ATIVIDADES',
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w700,
              color: Pallete.textColor,
              letterSpacing: 1.2,
            ),
          ),

          const SizedBox(height: 16),

          // Lista de atividades
          Column(
            children: activities.asMap().entries.map((entry) {
              final index = entry.key;
              final activity = entry.value;
              final isLast = index == activities.length - 1;
              final color = _colorForType(activity['type']!);

              return Column(
                children: [
                  Row(
                    children: [
                      // Indicador colorido
                      Container(
                        width: 10,
                        height: 10,
                        decoration: BoxDecoration(
                          color: color,
                          shape: BoxShape.circle,
                        ),
                      ),

                      const SizedBox(width: 12),

                      // Título e horário
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              activity['title']!,
                              style: const TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                                color: Color(0xFF0F172A),
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              activity['time']!,
                              style: const TextStyle(
                                fontSize: 11,
                                color: Pallete.textColor,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  // Divisória entre itens, exceto no último
                  if (!isLast)
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 12),
                      child: Divider(height: 1, color: Pallete.borderColor),
                    ),

                  if (isLast) const SizedBox(height: 4),
                ],
              );
            }).toList(),
          ),

          const SizedBox(height: 16),

          // Botão ver histórico completo
          OutlinedButton(
            onPressed: () {
              // Futuramente: navegar para tela de histórico completo
            },
            style: OutlinedButton.styleFrom(
              minimumSize: const Size(double.infinity, 40),
              side: BorderSide(color: Pallete.primaryRed.withOpacity(0.3)),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: const Text(
              'Ver Histórico Completo',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w700,
                color: Pallete.primaryRed,
              ),
            ),
          ),
        ],
      ),
    );
  }
}