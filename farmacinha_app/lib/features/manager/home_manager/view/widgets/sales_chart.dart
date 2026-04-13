import 'package:flutter/material.dart';
import 'package:farmacia_app/core/palette/pallete.dart';

class SalesChart extends StatefulWidget {
  const SalesChart({super.key});

  @override
  State<SalesChart> createState() => _SalesChartState();
}

class _SalesChartState extends State<SalesChart> {
  // 0 = Diário, 1 = Mensal
  int _selectedFilter = 0;

  // Dados estáticos para o gráfico
  final List<Map<String, dynamic>> _dailyData = [
    {'label': 'SEG', 'height': 0.50},
    {'label': 'TER', 'height': 0.72},
    {'label': 'QUA', 'height': 1.00}, // barra ativa (maior)
    {'label': 'QUI', 'height': 0.65},
    {'label': 'SEX', 'height': 0.80},
    {'label': 'SAB', 'height': 0.38},
    {'label': 'DOM', 'height': 0.25},
  ];

  final List<Map<String, dynamic>> _monthlyData = [
    {'label': 'JAN', 'height': 0.60},
    {'label': 'FEV', 'height': 0.45},
    {'label': 'MAR', 'height': 0.80},
    {'label': 'ABR', 'height': 1.00},
    {'label': 'MAI', 'height': 0.70},
    {'label': 'JUN', 'height': 0.55},
    {'label': 'JUL', 'height': 0.90},
  ];

  List<Map<String, dynamic>> get _currentData =>
      _selectedFilter == 0 ? _dailyData : _monthlyData;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
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
                'Performance de Vendas',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF0F172A),
                ),
              ),
              // Botões de filtro
              Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: Pallete.grayColor,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    _FilterButton(
                      label: 'Diário',
                      isSelected: _selectedFilter == 0,
                      onTap: () => setState(() => _selectedFilter = 0),
                    ),
                    _FilterButton(
                      label: 'Mensal',
                      isSelected: _selectedFilter == 1,
                      onTap: () => setState(() => _selectedFilter = 1),
                    ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 24),

          // Gráfico de barras
          SizedBox(
            height: 180,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: _currentData.asMap().entries.map((entry) {
                final index = entry.key;
                final data = entry.value;

                // A barra de maior valor fica vermelha, as demais amarelas
                final isActive = data['height'] == 1.00;

                return Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 3),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        AnimatedContainer(
                          duration: const Duration(milliseconds: 400),
                          curve: Curves.easeOut,
                          height: 160 * (data['height'] as double),
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
                          data['label'],
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

class _FilterButton extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _FilterButton({
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
              ? [BoxShadow(color: Colors.black.withOpacity(0.08), blurRadius: 4)]
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