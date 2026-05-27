import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:farmacia_app/app/app_routes.dart';
import 'package:farmacia_app/features/client/search/data/models/search_result_arguments.dart';
import '../view_model/search_result_view_model.dart';
import 'package:farmacia_app/features/client/widgets/custom_app_bar.dart';
import 'package:farmacia_app/features/client/widgets/custom_bottom_nav_bar.dart';
import 'package:farmacia_app/features/client/home_client/view/widgets/product_card.dart';

class SearchResultScreen extends StatelessWidget {
  final String? query;
  final SearchResultArguments? arguments;

  const SearchResultScreen({super.key, this.query, this.arguments});

  @override
  Widget build(BuildContext context) {
    final effectiveArguments = arguments ?? _argumentsFrom(context);

    return ChangeNotifierProvider(
      create: (_) => SearchResultViewModel(
        initialQuery: effectiveArguments.query,
        initialCategoryId: effectiveArguments.categoryId,
        initialCategoryName: effectiveArguments.categoryName,
      ),
      child: Scaffold(
        appBar: CustomAppBar(
          onMenuTap: () => Navigator.pop(context),
          onNotificationTap: () =>
              Navigator.pushNamed(context, AppRoutes.notifications),
          showBackButton: true,
        ),
        body: Consumer<SearchResultViewModel>(
          builder: (context, viewModel, child) {
            if (viewModel.isLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (viewModel.filteredProducts.isEmpty) {
              return _buildEmptyState();
            }

            return SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    viewModel.resultsTitle,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),

                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 15,
                          crossAxisSpacing: 15,
                          childAspectRatio: 0.68,
                        ),
                    itemCount: viewModel.filteredProducts.length,
                    itemBuilder: (context, index) {
                      final product = viewModel.filteredProducts[index];
                      return ProductCard(
                        productName: product.name,
                        price: product.price,
                        imageUrl: product.imageUrl,
                        rating: product.rating,
                        reviewCount: product.reviewCount,
                        isOnPromotion: product.isOnPromotion,
                        discountPercentage: product.discountPercentage,
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            AppRoutes.productDetail,
                            arguments: product,
                          );
                        },
                        onAddToCart: () =>
                            viewModel.addToCart(context, product),
                      );
                    },
                  ),

                  if (viewModel.similarProducts.isNotEmpty) ...[
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 25),
                      child: Divider(),
                    ),
                    const Text(
                      "Itens Semelhantes",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    SizedBox(
                      height: 280,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: viewModel.similarProducts.length,
                        itemBuilder: (context, index) {
                          final product = viewModel.similarProducts[index];
                          return Container(
                            width: 170,
                            margin: const EdgeInsets.only(right: 12),
                            child: ProductCard(
                              productName: product.name,
                              price: product.price,
                              imageUrl: product.imageUrl,
                              rating: product.rating,
                              reviewCount: product.reviewCount,
                              isOnPromotion: product.isOnPromotion,
                              discountPercentage: product.discountPercentage,
                              onTap: () {
                                Navigator.pushNamed(
                                  context,
                                  AppRoutes.productDetail,
                                  arguments: product,
                                );
                              },
                              onAddToCart: () =>
                                  viewModel.addToCart(context, product),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ],
              ),
            );
          },
        ),
        bottomNavigationBar: CustomBottomNavBar(
          currentIndex: 0,
          onTap: (index) {
            if (index == 0) Navigator.pushNamed(context, AppRoutes.homeClient);
            if (index == 2) Navigator.pushNamed(context, AppRoutes.cart);
          },
        ),
      ),
    );
  }

  SearchResultArguments _argumentsFrom(BuildContext context) {
    if (query != null) {
      return SearchResultArguments.query(query!);
    }

    final routeArguments = ModalRoute.of(context)?.settings.arguments;

    if (routeArguments is SearchResultArguments) {
      return routeArguments;
    }

    if (routeArguments is String) {
      return SearchResultArguments.query(routeArguments);
    }

    return const SearchResultArguments.query('');
  }

  Widget _buildEmptyState() {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.search_off, size: 80, color: Colors.grey),
          SizedBox(height: 16),
          Text(
            "Nenhum produto encontrado.",
            style: TextStyle(fontSize: 16, color: Colors.grey),
          ),
        ],
      ),
    );
  }
}
