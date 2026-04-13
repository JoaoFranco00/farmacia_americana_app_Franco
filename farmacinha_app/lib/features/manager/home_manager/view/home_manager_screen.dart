import 'package:flutter/material.dart';
import 'package:farmacia_app/core/palette/pallete.dart';
import 'package:farmacia_app/features/manager/home_manager/view/widgets/kpi_card.dart';
import 'package:farmacia_app/features/manager/home_manager/view/widgets/sales_chart.dart';
import 'package:farmacia_app/features/manager/home_manager/view/widgets/best_sellers.dart';
import 'package:farmacia_app/features/manager/home_manager/view/widgets/recent_orders.dart';
import 'package:farmacia_app/features/manager/home_manager/view_model/home_manager_view_model.dart';

class HomeManagerScreen extends StatelessWidget {
  const HomeManagerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = HomeManagerViewModel();

    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: _buildAppBar(),
      body: _buildBody(viewModel),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: Pallete.whiteColor,
      elevation: 0,
      surfaceTintColor: Colors.transparent,
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(1),
        child: Container(height: 1, color: Pallete.borderColor),
      ),
      title: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: Pallete.primaryRed.withOpacity(0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Icon(
              Icons.person_rounded,
              color: Pallete.primaryRed,
              size: 22,
            ),
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'FARMÁCIA AMERICANA',
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w800,
                  color: Pallete.primaryRed,
                  letterSpacing: -0.3,
                ),
              ),
              Text(
                'Painel Administrativo',
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w500,
                  color: Pallete.textColor,
                ),
              ),
            ],
          ),
        ],
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.notifications_outlined, color: Pallete.textColor),
          onPressed: () {},
        ),
        IconButton(
          icon: const Icon(Icons.settings_outlined, color: Pallete.textColor),
          onPressed: () {},
        ),
        const SizedBox(width: 4),
      ],
    );
  }

  Widget _buildBody(HomeManagerViewModel viewModel) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '${viewModel.greeting}, ${viewModel.managerName}',
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w800,
              color: Color(0xFF0F172A),
              letterSpacing: -0.5,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'Visão consolidada da rede Farmácia Americana hoje.',
            style: TextStyle(fontSize: 13, color: Pallete.textColor),
          ),

          const SizedBox(height: 20),

          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.analytics_rounded, size: 20),
              label: const Text(
                'Gerar Relatório Estratégico',
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 14),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Pallete.primaryRed,
                foregroundColor: Pallete.whiteColor,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 2,
                shadowColor: Pallete.primaryRed.withOpacity(0.3),
              ),
            ),
          ),

          const SizedBox(height: 24),

          KpiCard(
            label: 'Total de Vendas',
            value: viewModel.totalSales,
            trend: viewModel.totalSalesTrend,
            isPositiveTrend: viewModel.totalSalesPositive,
            icon: Icons.payments_rounded,
          ),
          const SizedBox(height: 12),
          KpiCard(
            label: 'Novos Clientes',
            value: viewModel.newClients,
            trend: viewModel.newClientsTrend,
            isPositiveTrend: viewModel.newClientsPositive,
            icon: Icons.person_add_rounded,
          ),
          const SizedBox(height: 12),
          KpiCard(
            label: 'Pedidos Pendentes',
            value: viewModel.pendingOrders,
            trend: viewModel.pendingOrdersNote,
            isPositiveTrend: false,
            icon: Icons.pending_actions_rounded,
          ),

          const SizedBox(height: 24),
          const SalesChart(),
          const SizedBox(height: 24),
          const BestSellers(),
          const SizedBox(height: 24),
          const RecentOrders(),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}