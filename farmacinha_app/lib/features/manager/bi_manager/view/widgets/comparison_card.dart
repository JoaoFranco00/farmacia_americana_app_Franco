import 'package:flutter/material.dart';
import 'package:farmacia_app/core/palette/pallete.dart';

class ComparisonCard extends StatelessWidget {
  final double currentProgress;
  final double previousProgress;
  final String currentLabel;
  final String previousLabel;

  const ComparisonCard({
    super.key,
    required this.currentProgress,
    required this.previousProgress,
    required this.currentLabel,
    required this.previousLabel,
  });

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
            'COMPARATIVO',
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w700,
              color: Pallete.textColor,
              letterSpacing: 1.2,
            ),
          ),

          const SizedBox(height: 20),

          // Barra do período atual
          _ProgressRow(
            label: 'Período Atual',
            value: currentLabel,
            progress: currentProgress,
            color: Pallete.primaryRed,
          ),

          const SizedBox(height: 16),

          // Barra do período anterior
          _ProgressRow(
            label: 'Período Anterior',
            value: previousLabel,
            progress: previousProgress,
            color: Pallete.accentYellow,
          ),
        ],
      ),
    );
  }
}

class _ProgressRow extends StatelessWidget {
  final String label;
  final String value;
  final double progress;
  final Color color;

  const _ProgressRow({
    required this.label,
    required this.value,
    required this.progress,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Label e valor
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: Color(0xFF0F172A),
              ),
            ),
            Text(
              value,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w700,
                color: color,
              ),
            ),
          ],
        ),

        const SizedBox(height: 8),

        // Barra de progresso
        ClipRRect(
          borderRadius: BorderRadius.circular(99),
          child: LinearProgressIndicator(
            value: progress,
            minHeight: 10,
            backgroundColor: color.withOpacity(0.12),
            valueColor: AlwaysStoppedAnimation<Color>(color),
          ),
        ),
      ],
    );
  }
}