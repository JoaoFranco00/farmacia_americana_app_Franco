// view_model/home_manager_view_model.dart
//
// Por enquanto os dados são estáticos (hardcoded).
// Quando o projeto tiver integração com API, os métodos
// aqui farão as chamadas e retornarão os dados reais.

class HomeManagerViewModel {
  // Dados dos cards KPI
  final String totalSales = 'R\$ 124.500';
  final String totalSalesTrend = '+12,5% vs mês anterior';
  final bool totalSalesPositive = true;

  final String newClients = '842';
  final String newClientsTrend = '+5,2% esta semana';
  final bool newClientsPositive = true;

  final String pendingOrders = '27';
  final String pendingOrdersNote = 'Aguardando faturamento';

  // Nome do gerente logado (futuramente virá do banco de dados)
  final String managerName = 'Diretor';

  String get greeting {
    final hour = DateTime.now().hour;
    if (hour < 12) return 'Bom dia';
    if (hour < 18) return 'Boa tarde';
    return 'Boa noite';
  }
}