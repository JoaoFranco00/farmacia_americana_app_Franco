import 'package:flutter/material.dart';
import 'package:farmacia_app/core/palette/pallete.dart';
import 'package:farmacia_app/features/client/home_client/view_model/home_client_view_model.dart';
import 'package:farmacia_app/features/client/home_client/view/widgets/product_card.dart';
import 'package:farmacia_app/features/client/widgets/custom_app_bar.dart';
import 'package:farmacia_app/features/client/widgets/custom_bottom_nav_bar.dart';
import 'package:farmacia_app/features/client/home_client/view/widgets/banner_carousel.dart';
import 'package:farmacia_app/features/client/home_client/view/widgets/category_grid.dart';
// IMPORT DA NOVA VIEW DE DETALHES
import 'package:farmacia_app/features/client/product_detail/view/product_detail_view.dart';

// ── Suas telas ────────────────────────────────────────────────────────────────
import 'package:farmacia_app/features/client/account/view/account_screen.dart';
import 'package:farmacia_app/features/client/notifications/view/notifications_screen.dart';
import 'package:farmacia_app/features/client/notifications/view_model/notifications_view_model.dart';

class HomeClientScreen extends StatefulWidget {
  const HomeClientScreen({super.key});

  @override
  State<HomeClientScreen> createState() => _HomeClientScreenState();
}

class _HomeClientScreenState extends State<HomeClientScreen> {
  final HomeClientViewModel viewModel = HomeClientViewModel();
  final NotificationsViewModel notificationsViewModel = NotificationsViewModel();
  int _currentTabIndex = 0;

  @override
  void dispose() {
    viewModel.dispose();
    notificationsViewModel.dispose();
    super.dispose();
  }

  // Navega para a tela correspondente ao tab selecionado
  void _onTabTapped(int index) {
    setState(() => _currentTabIndex = index);

    switch (index) {
      case 0:
        break;

      case 1:
        debugPrint('Abrir Chat');
        break;

      case 2:
        debugPrint('Abrir Carrinho');
        break;

      case 3:
        Navigator.of(
          context,
        ).push(MaterialPageRoute(builder: (_) => const AccountScreen()));
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Pallete.backgroundColor,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: ListenableBuilder(
          listenable: notificationsViewModel,
          builder: (context, _) => CustomAppBar(
            onMenuTap: () => debugPrint('Abrir Drawer'),
            onNotificationTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder:
                      (_) =>
                          NotificationsScreen(viewModel: notificationsViewModel),
                ),
              );
            },
            onLogoTap: () => debugPrint('Logo clicada'),
            unreadCount: notificationsViewModel.unreadCount,
          ),
        ),
      ),
      body: ListenableBuilder(
        listenable: viewModel,
        builder: (context, _) {
          if (viewModel.isLoading) {
            return const Center(
              child: CircularProgressIndicator(
                strokeWidth: 3,
                valueColor: AlwaysStoppedAnimation(Pallete.primaryRed),
              ),
            );
          }

          if (viewModel.errorMessage != null) {
            return _buildErrorState();
          }

          return RefreshIndicator(
            onRefresh: () async => viewModel.clearFilters(),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildSearchBar(),
                  BannerCarousel(
                    banners: viewModel.banners,
                    onTap: (id) => debugPrint('Banner $id clicado'),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: Text(
                      'Categorias',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 50, 50, 50),
                      ),
                    ),
                  ),
                  CategoryGrid(
                    categories: viewModel.categories,
                    onCategoryTap: (id) => viewModel.selectCategory(id),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                    child: Text(
                      'Destaques para você',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 50, 50, 50),
                      ),
                    ),
                  ),
                  if (viewModel.filteredProducts.isNotEmpty)
                    _buildProductsGrid()
                  else
                    _buildEmptyState(),
                  const SizedBox(height: 30),
                ],
              ),
            ),
          );
        },
      ),
      bottomNavigationBar: CustomBottomNavBar(
        currentIndex: _currentTabIndex,
        onTap: _onTabTapped,
      ),
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        decoration: BoxDecoration(
          color: Pallete.whiteColor,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Pallete.borderColor),
        ),
        child: TextField(
          controller: viewModel.searchController,
          decoration: const InputDecoration(
            hintText: 'Buscar na Farmácia Americana...',
            border: InputBorder.none,
            icon: Icon(Icons.search, color: Pallete.textColor),
          ),
        ),
      ),
    );
  }

  Widget _buildProductsGrid() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
          childAspectRatio: 0.7,
        ),
        itemCount: viewModel.filteredProducts.length,
        itemBuilder: (context, index) {
          final product = viewModel.filteredProducts[index];
          return ProductCard(
            imageUrl: product.imageUrl,
            productName: product.name,
            price: product.price,
            rating: product.rating,
            reviewCount: product.reviewCount,
            isOnPromotion: product.isOnPromotion,
            discountPercentage: product.discountPercentage,
            onTap: () {
              viewModel.viewProductDetail(product);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProductDetailView(product: product),
                ),
              );
            },
            onAddToCart: () => viewModel.addToCart(product),
          );
        },
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 40),
        child: Column(
          children: [
            const Icon(Icons.search_off, size: 60, color: Pallete.borderColor),
            const SizedBox(height: 16),
            const Text(
              'Nenhum produto encontrado',
              style: TextStyle(color: Pallete.textColor, fontSize: 16),
            ),
            TextButton(
              onPressed: () => viewModel.clearFilters(),
              child: const Text(
                'Limpar busca',
                style: TextStyle(color: Pallete.primaryRed),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildErrorState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.error_outline, size: 60, color: Pallete.primaryRed),
          const SizedBox(height: 16),
          Text(viewModel.errorMessage ?? 'Ocorreu um erro inesperado'),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () => viewModel.clearFilters(),
            child: const Text('Tentar novamente'),
          ),
        ],
      ),
    );
  }
}
