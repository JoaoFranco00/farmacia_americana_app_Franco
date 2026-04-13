import 'package:flutter/material.dart';
import 'package:farmacia_app/core/palette/pallete.dart';

class BestSellers extends StatelessWidget {
  const BestSellers({super.key});

  // Dados estáticos dos produtos mais vendidos
  static const List<Map<String, String>> _products = [
    {
      'name': 'Advanced Multi-Vitamin',
      'sold': '142 vendidos',
      'price': 'R\$ 89,90',
    },
    {
      'name': 'Soro Fisiológico Plus',
      'sold': '118 vendidos',
      'price': 'R\$ 12,50',
    },
    {
      'name': 'Protetor Solar FPS 50',
      'sold': '97 vendidos',
      'price': 'R\$ 45,00',
    },
  ];

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
        children: [
          // Cabeçalho
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Mais Vendidos',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF0F172A),
                ),
              ),
              Icon(Icons.filter_list, color: Pallete.textColor),
            ],
          ),

          const SizedBox(height: 20),

          // Lista de produtos
          Column(
            children: _products
                .map((product) => _ProductItem(product: product))
                .toList(),
          ),

          const SizedBox(height: 16),

          // Botão ver todos
          OutlinedButton(
            onPressed: () {},
            style: OutlinedButton.styleFrom(
              minimumSize: const Size(double.infinity, 40),
              side: BorderSide(color: Pallete.primaryRed.withOpacity(0.3)),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: const Text(
              'Ver Todos os Produtos',
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

class _ProductItem extends StatelessWidget {
  final Map<String, String> product;

  const _ProductItem({required this.product});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        children: [
          // Ícone do produto
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: Pallete.grayColor,
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Icon(
              Icons.medication_rounded,
              color: Pallete.primaryRed,
              size: 24,
            ),
          ),

          const SizedBox(width: 14),

          // Nome e quantidade vendida
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product['name']!,
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF0F172A),
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 2),
                Text(
                  product['sold']!,
                  style: const TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w700,
                    color: Pallete.primaryRed,
                  ),
                ),
              ],
            ),
          ),

          // Preço
          Text(
            product['price']!,
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w700,
              color: Color(0xFF0F172A),
            ),
          ),
        ],
      ),
    );
  }
}