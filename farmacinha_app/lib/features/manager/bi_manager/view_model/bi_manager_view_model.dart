// view_model/bi_manager_view_model.dart
//
// Contém os dados e a lógica da tela de BI.
// Futuramente os dados virão de uma API ou banco de dados.

class BiManagerViewModel {
  // Dados de faturamento por período
  final Map<String, Map<String, dynamic>> billingData = {
    'Diário': {
      'current': 18340.0,
      'previous': 16930.0,
      'label': 'vs. ontem',
    },
    'Semanal': {
      'current': 124500.0,
      'previous': 110200.0,
      'label': 'vs. semana anterior',
    },
    'Mensal': {
      'current': 498000.0,
      'previous': 462000.0,
      'label': 'vs. mês anterior',
    },
  };

  // Dados do gráfico de barras por período
  final Map<String, List<Map<String, dynamic>>> chartData = {
    'Diário': [
      {'label': '08h', 'revenue': 0.30, 'orders': 0.20},
      {'label': '10h', 'revenue': 0.55, 'orders': 0.45},
      {'label': '12h', 'revenue': 1.00, 'orders': 1.00},
      {'label': '14h', 'revenue': 0.75, 'orders': 0.70},
      {'label': '16h', 'revenue': 0.85, 'orders': 0.80},
      {'label': '18h', 'revenue': 0.60, 'orders': 0.55},
      {'label': '20h', 'revenue': 0.40, 'orders': 0.35},
    ],
    'Semanal': [
      {'label': 'SEG', 'revenue': 0.50, 'orders': 0.45},
      {'label': 'TER', 'revenue': 0.72, 'orders': 0.60},
      {'label': 'QUA', 'revenue': 1.00, 'orders': 1.00},
      {'label': 'QUI', 'revenue': 0.65, 'orders': 0.58},
      {'label': 'SEX', 'revenue': 0.80, 'orders': 0.75},
      {'label': 'SAB', 'revenue': 0.38, 'orders': 0.30},
      {'label': 'DOM', 'revenue': 0.25, 'orders': 0.20},
    ],
    'Mensal': [
      {'label': 'JAN', 'revenue': 0.60, 'orders': 0.55},
      {'label': 'FEV', 'revenue': 0.45, 'orders': 0.40},
      {'label': 'MAR', 'revenue': 0.80, 'orders': 0.72},
      {'label': 'ABR', 'revenue': 1.00, 'orders': 1.00},
      {'label': 'MAI', 'revenue': 0.70, 'orders': 0.65},
      {'label': 'JUN', 'revenue': 0.55, 'orders': 0.50},
      {'label': 'JUL', 'revenue': 0.90, 'orders': 0.85},
    ],
  };

  // Dados dos mais vendidos por período
  final Map<String, List<Map<String, dynamic>>> topProductsData = {
    'Diário': [
      {'name': 'Dipirona 500mg', 'units': 142, 'max': 142},
      {'name': 'Soro Fisiológico', 'units': 118, 'max': 142},
      {'name': 'Vitamina C 1g', 'units': 97, 'max': 142},
      {'name': 'Protetor Solar', 'units': 74, 'max': 142},
      {'name': 'Paracetamol 750mg', 'units': 61, 'max': 142},
    ],
    'Semanal': [
      {'name': 'Dipirona 500mg', 'units': 890, 'max': 890},
      {'name': 'Paracetamol 750mg', 'units': 740, 'max': 890},
      {'name': 'Soro Fisiológico', 'units': 620, 'max': 890},
      {'name': 'Vitamina C 1g', 'units': 510, 'max': 890},
      {'name': 'Complexo B', 'units': 430, 'max': 890},
    ],
    'Mensal': [
      {'name': 'Dipirona 500mg', 'units': 3200, 'max': 3200},
      {'name': 'Paracetamol 750mg', 'units': 2800, 'max': 3200},
      {'name': 'Protetor Solar', 'units': 2100, 'max': 3200},
      {'name': 'Vitamina C 1g', 'units': 1900, 'max': 3200},
      {'name': 'Shampoo Anticaspa', 'units': 1500, 'max': 3200},
    ],
  };

  // Períodos disponíveis
  final List<String> periods = ['Diário', 'Semanal', 'Mensal'];

  // Calcula a variação percentual entre atual e anterior
  double getVariation(String period) {
    final data = billingData[period]!;
    final current = data['current'] as double;
    final previous = data['previous'] as double;
    return ((current - previous) / previous) * 100;
  }

  // Calcula o percentual de progresso para a barra comparativa
  double getCurrentProgress(String period) {
    final data = billingData[period]!;
    final current = data['current'] as double;
    final previous = data['previous'] as double;
    final max = current > previous ? current : previous;
    return current / max;
  }

  double getPreviousProgress(String period) {
    final data = billingData[period]!;
    final current = data['current'] as double;
    final previous = data['previous'] as double;
    final max = current > previous ? current : previous;
    return previous / max;
  }

  // Formata valor monetário
  String formatCurrency(double value) {
    if (value >= 1000) {
      return 'R\$ ${(value / 1000).toStringAsFixed(1).replaceAll('.', ',')}mil';
    }
    return 'R\$ ${value.toStringAsFixed(2).replaceAll('.', ',')}';
  }

  // Hora atual formatada
  String get updatedAt {
    final now = DateTime.now();
    final hour = now.hour.toString().padLeft(2, '0');
    final minute = now.minute.toString().padLeft(2, '0');
    return 'Atualizado hoje, $hour:$minute';
  }
}