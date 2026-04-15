import 'dart:async';

import 'package:flutter/material.dart';
import 'package:farmacia_app/app/app_routes.dart';
import 'package:farmacia_app/core/palette/pallete.dart';
import 'package:farmacia_app/features/client/widgets/custom_bottom_nav_bar.dart';

class FavoriteProductsScreen extends StatefulWidget {
  const FavoriteProductsScreen({super.key});

  @override
  State<FavoriteProductsScreen> createState() => _FavoriteProductsScreenState();
}

class _FavoriteProductsScreenState extends State<FavoriteProductsScreen> {
  static const Color _screenBg = Color(0xFFFFF8F7);
  static const Color _surfaceLowest = Colors.white;
  static const Color _surfaceLow = Color(0xFFFFF0EE);
  static const Color _surfaceHighest = Color(0xFFFDDDD8);

  final ScrollController _scrollController = ScrollController();
  final GlobalKey _suggestionsKey = GlobalKey();
  final Set<String> _loadingAddToCart = <String>{};

  late List<_FavoriteProduct> _favoriteProducts;
  late List<_FavoriteProduct> _suggestedProducts;

  @override
  void initState() {
    super.initState();
    _favoriteProducts = List<_FavoriteProduct>.from(_initialFavorites);
    _suggestedProducts = List<_FavoriteProduct>.from(_initialSuggestions);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onBottomBarTap(int index) {
    if (index == 0) {
      Navigator.of(context).popUntil((route) => route.isFirst);
      return;
    }

    if (index == 3) {
      return;
    }

    debugPrint('Tab $index selecionada em Favoritos');
  }

  Future<void> _scrollToSuggestions() async {
    final suggestionsContext = _suggestionsKey.currentContext;

    if (suggestionsContext != null) {
      await Scrollable.ensureVisible(
        suggestionsContext,
        duration: const Duration(milliseconds: 450),
        curve: Curves.easeInOut,
      );
      return;
    }

    await _scrollController.animateTo(
      _scrollController.position.maxScrollExtent,
      duration: const Duration(milliseconds: 450),
      curve: Curves.easeInOut,
    );
  }

  void _goToCategories() {
    Navigator.of(context).pushNamed(AppRoutes.homeClient);
  }

  void _toggleFavoriteFromFavorites(_FavoriteProduct product) {
    setState(() {
      _favoriteProducts.removeWhere((item) => item.id == product.id);
      _suggestedProducts.insert(0, product.copyWith(isFavorite: false));
    });
  }

  void _toggleFavoriteFromSuggestions(_FavoriteProduct product) {
    setState(() {
      _suggestedProducts.removeWhere((item) => item.id == product.id);
      _favoriteProducts.insert(0, product.copyWith(isFavorite: true));
    });
  }

  Future<void> _addToCartWithFeedback(_FavoriteProduct product) async {
    setState(() => _loadingAddToCart.add(product.id));

    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${product.title} adicionado ao carrinho.'),
        duration: const Duration(milliseconds: 900),
      ),
    );

    await Future<void>.delayed(const Duration(milliseconds: 850));
    if (!mounted) {
      return;
    }

    setState(() => _loadingAddToCart.remove(product.id));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _screenBg,
      appBar: AppBar(
        backgroundColor: _screenBg,
        elevation: 0,
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(Icons.arrow_back_rounded, color: Color(0xFFB90014)),
        ),
        title: const Text(
          'Produtos Favoritos',
          style: TextStyle(
            color: Color(0xFFB90014),
            fontSize: 18,
            fontWeight: FontWeight.w700,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () => debugPrint('Buscar em favoritos'),
            icon: const Icon(Icons.search_rounded, color: Color(0xFFB90014)),
          ),
          IconButton(
            onPressed: () => debugPrint('Abrir carrinho'),
            icon: const Icon(Icons.shopping_cart_rounded, color: Color(0xFFB90014)),
          ),
        ],
      ),
      body: SingleChildScrollView(
        controller: _scrollController,
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'SUA COLEÇÃO CURADA',
              style: TextStyle(
                color: Color(0xFF5D3F3C),
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 8),
            RichText(
              text: const TextSpan(
                style: TextStyle(
                  color: Color(0xFF291715),
                  fontSize: 32,
                  fontWeight: FontWeight.w800,
                ),
                children: [
                  TextSpan(text: 'Itens que você '),
                  TextSpan(
                    text: 'ama.',
                    style: TextStyle(
                      color: Color(0xFFB90014),
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: _favoriteProducts.length + 1,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 14,
                mainAxisSpacing: 14,
                childAspectRatio: 0.58,
              ),
              itemBuilder: (context, index) {
                if (index == _favoriteProducts.length) {
                  return _buildDiscoverMoreCard();
                }

                final product = _favoriteProducts[index];
                return _ProductCard(
                  product: product,
                  isLoadingAddToCart: _loadingAddToCart.contains(product.id),
                  onFavoriteTap: () => _toggleFavoriteFromFavorites(product),
                  onAddTap: () => _addToCartWithFeedback(product),
                );
              },
            ),
            const SizedBox(height: 26),
            _buildTipsCard(),
            const SizedBox(height: 20),
            GridView.builder(
              key: _suggestionsKey,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: _suggestedProducts.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 14,
                mainAxisSpacing: 14,
                childAspectRatio: 0.58,
              ),
              itemBuilder: (context, index) {
                final product = _suggestedProducts[index];
                return _ProductCard(
                  product: product,
                  suggested: true,
                  isLoadingAddToCart: false,
                  onFavoriteTap: () => _toggleFavoriteFromSuggestions(product),
                  onAddTap: () => debugPrint('Adicionar sugerido ${product.title}'),
                );
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar: CustomBottomNavBar(
        currentIndex: 3,
        onTap: _onBottomBarTap,
      ),
    );
  }

  Widget _buildDiscoverMoreCard() {
    return Container(
      decoration: BoxDecoration(
        color: _surfaceLow,
        borderRadius: BorderRadius.circular(26),
        border: Border.all(color: const Color(0xFFE7BDB8), width: 2),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          InkWell(
            borderRadius: BorderRadius.circular(999),
            onTap: _scrollToSuggestions,
            child: const Padding(
              padding: EdgeInsets.all(4),
              child: Icon(
                Icons.add_circle_rounded,
                color: Color(0xFF926E6B),
                size: 34,
              ),
            ),
          ),
          const SizedBox(height: 10),
          const Text(
            'Descubra Mais',
            style: TextStyle(
              color: Color(0xFF291715),
              fontWeight: FontWeight.w700,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 8),
          TextButton(
            onPressed: _goToCategories,
            style: TextButton.styleFrom(padding: EdgeInsets.zero),
            child: const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Ver Categorias',
                  style: TextStyle(
                    color: Color(0xFFB90014),
                    fontWeight: FontWeight.w700,
                    fontSize: 12,
                  ),
                ),
                SizedBox(width: 2),
                Icon(Icons.chevron_right_rounded, color: Color(0xFFB90014), size: 14),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTipsCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: _surfaceHighest,
        borderRadius: BorderRadius.circular(28),
      ),
      child: Row(
        children: [
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Dicas para você',
                  style: TextStyle(
                    fontSize: 21,
                    fontWeight: FontWeight.w800,
                    color: Color(0xFF291715),
                  ),
                ),
                SizedBox(height: 6),
                Text(
                  'Sugestões baseadas nos seus favoritos.',
                  style: TextStyle(
                    fontSize: 14,
                    color: Color(0xFF5D3F3C),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          _TipIcon(
            icon: Icons.auto_awesome_rounded,
            iconColor: Color(0xFF705D00),
          ),
          const SizedBox(width: 8),
          _TipIcon(
            icon: Icons.health_and_safety_rounded,
            iconColor: Color(0xFF005F93),
          ),
        ],
      ),
    );
  }
}

class _ProductCard extends StatelessWidget {
  final _FavoriteProduct product;
  final bool suggested;
  final bool isLoadingAddToCart;
  final VoidCallback onFavoriteTap;
  final VoidCallback onAddTap;

  const _ProductCard({
    required this.product,
    required this.onFavoriteTap,
    required this.onAddTap,
    required this.isLoadingAddToCart,
    this.suggested = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: _FavoriteProductsScreenState._surfaceLowest,
        borderRadius: BorderRadius.circular(26),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(22),
                  child: Container(
                    color: _FavoriteProductsScreenState._surfaceLow,
                    width: double.infinity,
                    child: Image.network(
                      product.imageUrl,
                      fit: BoxFit.cover,
                      errorBuilder: (context, _, __) {
                        return const Center(
                          child: Icon(
                            Icons.broken_image_outlined,
                            color: Pallete.textColor,
                            size: 40,
                          ),
                        );
                      },
                    ),
                  ),
                ),
                Positioned(
                  top: 8,
                  right: 8,
                  child: InkWell(
                    onTap: onFavoriteTap,
                    borderRadius: BorderRadius.circular(999),
                    child: Container(
                      width: 34,
                      height: 34,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        product.isFavorite
                            ? Icons.favorite_rounded
                            : Icons.favorite_border_rounded,
                        color: product.isFavorite
                            ? const Color(0xFFB90014)
                            : const Color(0xFFAA8784),
                        size: 18,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: product.categoryBg,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              product.category,
              style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w800,
                letterSpacing: 1,
                color: product.categoryText,
              ),
            ),
          ),
          const SizedBox(height: 7),
          Text(
            product.title,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 19,
              fontWeight: FontWeight.w700,
              color: Color(0xFF291715),
              height: 1.2,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            product.price,
            style: const TextStyle(
              fontSize: 23,
              fontWeight: FontWeight.w900,
              color: Color(0xFF291715),
            ),
          ),
          const SizedBox(height: 10),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: onAddTap,
              style: ElevatedButton.styleFrom(
                elevation: 0,
                backgroundColor: suggested ? Colors.white : const Color(0xFFE30613),
                foregroundColor: const Color(0xFFE30613),
                padding: const EdgeInsets.symmetric(vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(999),
                  side: BorderSide(
                    color: const Color(0xFFE30613),
                    width: suggested ? 2 : 0,
                  ),
                ),
              ),
              icon: AnimatedSwitcher(
                duration: const Duration(milliseconds: 220),
                transitionBuilder: (child, animation) => ScaleTransition(
                  scale: animation,
                  child: child,
                ),
                child: isLoadingAddToCart
                    ? const Icon(
                        Icons.check_circle_rounded,
                        key: ValueKey('check'),
                        size: 16,
                        color: Colors.white,
                      )
                    : Icon(
                        Icons.add_shopping_cart_rounded,
                        key: const ValueKey('cart'),
                        size: 16,
                        color: suggested ? const Color(0xFFE30613) : Colors.white,
                      ),
              ),
              label: AnimatedSwitcher(
                duration: const Duration(milliseconds: 220),
                child: Text(
                  isLoadingAddToCart ? 'Adicionado' : 'Adicionar',
                  key: ValueKey(isLoadingAddToCart),
                  style: TextStyle(
                    color: suggested ? const Color(0xFFE30613) : Colors.white,
                    fontWeight: FontWeight.w800,
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

class _TipIcon extends StatelessWidget {
  final IconData icon;
  final Color iconColor;

  const _TipIcon({required this.icon, required this.iconColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 42,
      height: 42,
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
        border: Border.all(color: const Color(0xFFE7BDB8)),
      ),
      child: Icon(icon, color: iconColor, size: 18),
    );
  }
}

class _FavoriteProduct {
  final String id;
  final String title;
  final String price;
  final String category;
  final Color categoryBg;
  final Color categoryText;
  final String imageUrl;
  final bool isFavorite;

  const _FavoriteProduct({
    required this.id,
    required this.title,
    required this.price,
    required this.category,
    required this.categoryBg,
    required this.categoryText,
    required this.imageUrl,
    this.isFavorite = true,
  });

  _FavoriteProduct copyWith({bool? isFavorite}) {
    return _FavoriteProduct(
      id: id,
      title: title,
      price: price,
      category: category,
      categoryBg: categoryBg,
      categoryText: categoryText,
      imageUrl: imageUrl,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }
}

const List<_FavoriteProduct> _initialFavorites = [
  _FavoriteProduct(
    id: 'serum-vitamin-c',
    title: 'Sérum Facial Antioxidante Vitamin C+',
    price: 'R\$ 189,90',
    category: 'SKIN HEALTH',
    categoryBg: Color(0xFFFCD400),
    categoryText: Color(0xFF5A4300),
    imageUrl:
        'https://lh3.googleusercontent.com/aida-public/AB6AXuCst8VmobGYlwMUb6tqK_2wi1jiMZ2g3QPXNL1ymmA-UyTOuH9YMjsDn3EQ426Y10_gmNeG9f7ZeDTnOF_PPIVCoyy6gRdPhap02_oIrhPXCCffIGkHH7dFvSy3NoYOGzcpfY7GhI7jBcP7C5TADSjF7KOHMUxrJWq-K9v-IcfXIyrLI3AoJKtXjB5yTnhaDHKu9SMxjgtOvPuVAqvh5xb_79u77utvzZk0INFO9vireVrQMUX0oS8dy9F1uImY4knqECs13QC7Wxg',
  ),
  _FavoriteProduct(
    id: 'complexo-a-z',
    title: 'Complexo Vitamínico A-Z 60 Caps',
    price: 'R\$ 54,90',
    category: 'SUPLEMENTOS',
    categoryBg: Color(0xFFCDE5FF),
    categoryText: Color(0xFF003E67),
    imageUrl:
        'https://lh3.googleusercontent.com/aida-public/AB6AXuDJXQNuFGCQwWefF5zdmVg0qSBteFuP_dwhotU00z3To-pcxr4muiI1hXWnBmws5B_zvh1E1nqJflchUTO5I8IETv71qBeh4DNv4Kl-zQAU-xWY1ATkRigZGq9LGWOLHT31TZFGipa8dep9nxLFkUsiVdYoM6CT_mcTL17ZKCAEO2-ELYYJlwuNa971Ut_AnrohhtReYtpxmMOeXqR_8mbxBrHBdz-hpTssPttwzHZADn2abO0PfUs4qQXno8RNU79pAcQnX-8DKIc',
  ),
  _FavoriteProduct(
    id: 'analgesico-ultra',
    title: 'Analgésico Ultra 500mg 20 Comprimidos',
    price: 'R\$ 22,15',
    category: 'MEDICAMENTO',
    categoryBg: Color(0xFFFFDAD6),
    categoryText: Color(0xFF93000A),
    imageUrl:
        'https://lh3.googleusercontent.com/aida-public/AB6AXuCjAgWRkWSt2J6Yzh7pLEzuelyt7qP79I-T3KmBzdBdPEP-3KeteAn30lM9YcsL7inHZVppehPE4v9r0P0EGxKiEzhVnY_OWaTQ_6o5h0zJjTb0Foy7YKZAx1nIdoKcp4lLOOVHFxjO_V_zn15rKZKPCS-sXmO1D_3WIHrGYncEUwwcv6UVAHU-q1EJMyjwEYIkje3YMRYxleQ9lSjf_zlhGKT-30KOD9F7WeyCVvQLlruMKZrUy9YNZ5mLnq_QXl4kIRjumQAaJDE',
  ),
  _FavoriteProduct(
    id: 'shampoo-botanico',
    title: 'Shampoo Fortificante Botânico 400ml',
    price: 'R\$ 38,40',
    category: 'CABELO',
    categoryBg: Color(0xFFFCD400),
    categoryText: Color(0xFF5A4300),
    imageUrl:
        'https://lh3.googleusercontent.com/aida-public/AB6AXuAy8Fy933PuGhnG2Wo2p4H0Tqif4VDCMKyhA2PEtAVKaoUcqVuZiJhmu2mzvebnIaFqLObjnTjWRvvDzAadwKQdDq4NkZJuILDfoeNKeL-u_yQ-O40rFc-u8blkDjCrduaQ15CXkIOAvRiwofHZ3Sp1MIP9f8rAkIhoZAqhyTqO6PJR815etDfn_AAlS7cXWqLKfQDmdM4ODNaLYOi-j5sSxweUrmxASWNBTjZ4FFaRJrEC_sUjbL3z-LCNaTodNeXaiPoEgH1XHF8',
  ),
];

const List<_FavoriteProduct> _initialSuggestions = [
  _FavoriteProduct(
    id: 'protetor-solar',
    title: 'Protetor Solar Facial FPS 60 Toque Seco 50ml',
    price: 'R\$ 79,90',
    category: 'SKIN HEALTH',
    categoryBg: Color(0xFFFCD400),
    categoryText: Color(0xFF5A4300),
    imageUrl:
        'https://images.tcdn.com.br/img/img_prod/1017481/protetor_solar_facial_fps_60_toque_seco_50ml_nivea_sun_32063_1_6eb62f41dba9e6303af5e94de189f110.jpg',
    isFavorite: false,
  ),
  _FavoriteProduct(
    id: 'omega-3-ultra',
    title: 'Ômega 3 Ultra Concentrado 1000mg',
    price: 'R\$ 112,00',
    category: 'SUPLEMENTOS',
    categoryBg: Color(0xFFCDE5FF),
    categoryText: Color(0xFF003E67),
    imageUrl:
        'https://images.unsplash.com/photo-1587854692152-cbe660dbde88?auto=format&fit=crop&w=600&q=80',
    isFavorite: false,
  ),
];