// view_model/profile_manager_view_model.dart
//
// Contém os dados e a lógica da tela de Perfil do Gerente.
// Futuramente os dados virão de uma API ou banco de dados.

class ProfileManagerViewModel {
  // Dados do gerente logado (estáticos por enquanto)
  String name = 'João Silva';
  String role = 'Gerente Geral';
  String email = 'joao@farmaciaamericana.com';

  // Histórico de atividades recentes
  final List<Map<String, String>> activityHistory = [
    {
      'title': 'Relatório gerado',
      'time': 'Hoje, 10:32',
      'type': 'success', // verde
    },
    {
      'title': 'Estoque atualizado',
      'time': 'Hoje, 09:15',
      'type': 'warning', // amarelo
    },
    {
      'title': 'Pedido #CK-9279 cancelado',
      'time': 'Ontem, 17:48',
      'type': 'error', // vermelho
    },
    {
      'title': 'Login realizado',
      'time': 'Ontem, 08:00',
      'type': 'success', // verde
    },
  ];
}