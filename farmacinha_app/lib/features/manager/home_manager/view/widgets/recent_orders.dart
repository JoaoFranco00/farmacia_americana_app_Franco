import 'package:flutter/material.dart';
import 'package:farmacia_app/core/palette/pallete.dart';

class RecentOrders extends StatefulWidget {
  const RecentOrders({super.key});

  @override
  State<RecentOrders> createState() => _RecentOrdersState();
}

class _RecentOrdersState extends State<RecentOrders> {
  final TextEditingController _searchController = TextEditingController();

  final List<Map<String, String>> _orders = [
    {
      'id': '#CK-9281',
      'client': 'Ricardo Oliveira',
      'status': 'ENVIADO',
      'value': 'R\$ 452,00',
    },
    {
      'id': '#CK-9280',
      'client': 'Ana Julia Santos',
      'status': 'PROCESSANDO',
      'value': 'R\$ 129,90',
    },
    {
      'id': '#CK-9279',
      'client': 'Marcos Pereira',
      'status': 'PENDENTE',
      'value': 'R\$ 78,50',
    },
  ];

  List<Map<String, String>> get _filteredOrders {
    final query = _searchController.text.toLowerCase();
    if (query.isEmpty) return _orders;
    return _orders.where((order) {
      return order['id']!.toLowerCase().contains(query) ||
          order['client']!.toLowerCase().contains(query);
    }).toList();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Pallete.whiteColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Pallete.borderColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Cabeçalho e busca
          Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Pedidos Recentes',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF0F172A),
                  ),
                ),
                const SizedBox(height: 14),

                // Campo de busca
                TextField(
                  controller: _searchController,
                  onChanged: (_) => setState(() {}),
                  decoration: InputDecoration(
                    hintText: 'Buscar ID ou Cliente...',
                    hintStyle: TextStyle(
                      fontSize: 13,
                      color: Pallete.textColor.withOpacity(0.6),
                    ),
                    prefixIcon: const Icon(
                      Icons.search,
                      color: Pallete.textColor,
                      size: 20,
                    ),
                    filled: true,
                    fillColor: Pallete.grayColor,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none,
                    ),
                    contentPadding: const EdgeInsets.symmetric(vertical: 10),
                  ),
                ),
              ],
            ),
          ),

          // Lista de pedidos
          const Divider(height: 1, color: Pallete.borderColor),
          ..._filteredOrders.map((order) => _OrderItem(order: order)),

          // Botão ver histórico
          InkWell(
            onTap: () {},
            borderRadius: const BorderRadius.vertical(
              bottom: Radius.circular(16),
            ),
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 16),
              decoration: BoxDecoration(
                color: Pallete.grayColor,
                borderRadius: const BorderRadius.vertical(
                  bottom: Radius.circular(16),
                ),
              ),
              child: const Center(
                child: Text(
                  'Ver Histórico Completo',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    color: Pallete.primaryRed,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _OrderItem extends StatelessWidget {
  final Map<String, String> order;

  const _OrderItem({required this.order});

  Color _statusColor(String status) {
    switch (status) {
      case 'ENVIADO':
        return const Color(0xFF10B981);
      case 'PROCESSANDO':
        return const Color(0xFFFAC000);
      default:
        return const Color(0xFF64748B);
    }
  }

  @override
  Widget build(BuildContext context) {
    final statusColor = _statusColor(order['status']!);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: Pallete.borderColor)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // ID e nome do cliente
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                order['id']!,
                style: const TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                  color: Pallete.primaryRed,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                order['client']!,
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF0F172A),
                ),
              ),
            ],
          ),

          // Status e valor
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: statusColor.withOpacity(0.12),
                  borderRadius: BorderRadius.circular(99),
                ),
                child: Text(
                  order['status']!,
                  style: TextStyle(
                    fontSize: 9,
                    fontWeight: FontWeight.w700,
                    color: statusColor,
                  ),
                ),
              ),
              const SizedBox(height: 4),
              Text(
                order['value']!,
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