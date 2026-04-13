import 'package:flutter/material.dart';
import 'package:farmacia_app/core/palette/pallete.dart';

class BiSalesChart extends StatefulWidget {
  final List<Map<String, dynamic>> data;

  const BiSalesChart({super.key, required this.data});

  @override
  State<BiSalesChart> createState() => _BiSalesChartState();
}

class _BiSalesChartState extends State<BiSalesChart> {
  // 0 = Receita, 1 = Pedidos
  int _selectedMode = 0;

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
          // Cabeçalho
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'VENDAS POR PERÍODO',
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w700,
                  color: Pallete.textColor,
                  letterSpacing: 1.2,
                ),
              ),

              // Alternador Receita / Pedidos
              Container(
                padding: const EdgeInsets.all(3),
                decoration: BoxDecoration(
                  color: Pallete.grayColor,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    _ModeButton(
                      label: 'Receita',
                      isSelected: _selectedMode == 0,
                      onTap: () => setState(() => _selectedMode = 0),
                    ),
                    _ModeButton(
                      label: 'Pedidos',
                      isSelected: _selectedMode == 1,
                      onTap: () => setState(() => _selectedMode = 1),
                    ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 20),

          // Gráfico de barras
          SizedBox(
            height: 160,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: widget.data.map((item) {
                final heightFactor = _selectedMode == 0
                    ? item['revenue'] as double
                    : item['orders'] as double;
                final isActive = heightFactor == 1.0;

                return Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 3),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        AnimatedContainer(
                          duration: const Duration(milliseconds: 400),
                          curve: Curves.easeOut,
                          height: 140 * heightFactor,
                          decoration: BoxDecoration(
                            color: isActive
                                ? Pallete.primaryRed
                                : Pallete.accentYellow.withOpacity(0.35),
                            borderRadius: const BorderRadius.vertical(
                              top: Radius.circular(4),
                            ),
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          item['label'],
                          style: TextStyle(
                            fontSize: 9,
                            fontWeight: isActive
                                ? FontWeight.w800
                                : FontWeight.w600,
                            color: isActive
                                ? Pallete.primaryRed
                                : Pallete.textColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}

class _ModeButton extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _ModeButton({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: isSelected ? Pallete.whiteColor : Colors.transparent,
          borderRadius: BorderRadius.circular(6),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.08),
                    blurRadius: 4,
                  )
                ]
              : [],
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w700,
            color: isSelected ? Pallete.primaryRed : Pallete.textColor,
          ),
        ),
      ),
    );
  }
}