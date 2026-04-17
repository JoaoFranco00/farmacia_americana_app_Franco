import 'dart:async';
import 'dart:collection';

import 'package:flutter/material.dart';

class FavoriteProductsViewModel extends ChangeNotifier {
  FavoriteProductsViewModel()
      : _favoriteProducts = List<FavoriteProduct>.from(_initialFavorites),
        _suggestedProducts = List<FavoriteProduct>.from(_initialSuggestions);

  final List<FavoriteProduct> _favoriteProducts;
  final List<FavoriteProduct> _suggestedProducts;
  final Set<String> _loadingAddToCart = <String>{};
  bool _isDisposed = false;

  UnmodifiableListView<FavoriteProduct> get favoriteProducts =>
      UnmodifiableListView(_favoriteProducts);

  UnmodifiableListView<FavoriteProduct> get suggestedProducts =>
      UnmodifiableListView(_suggestedProducts);

  bool isAddingToCart(String productId) => _loadingAddToCart.contains(productId);

  void removeFromFavorites(FavoriteProduct product) {
    _favoriteProducts.removeWhere((item) => item.id == product.id);
    _suggestedProducts.insert(0, product.copyWith(isFavorite: false));
    _notifySafely();
  }

  void addToFavorites(FavoriteProduct product) {
    _suggestedProducts.removeWhere((item) => item.id == product.id);
    _favoriteProducts.insert(0, product.copyWith(isFavorite: true));
    _notifySafely();
  }

  String addToCart(FavoriteProduct product) {
    if (_loadingAddToCart.add(product.id)) {
      _notifySafely();
      unawaited(_finishAddToCart(product.id));
    }

    return '${product.title} adicionado ao carrinho.';
  }

  Future<void> _finishAddToCart(String productId) async {
    await Future<void>.delayed(const Duration(milliseconds: 850));
    _loadingAddToCart.remove(productId);
    _notifySafely();
  }

  void _notifySafely() {
    if (!_isDisposed) {
      notifyListeners();
    }
  }

  @override
  void dispose() {
    _isDisposed = true;
    super.dispose();
  }
}

class FavoriteProduct {
  final String id;
  final String title;
  final String price;
  final String category;
  final Color categoryBg;
  final Color categoryText;
  final String imageUrl;
  final bool isFavorite;

  const FavoriteProduct({
    required this.id,
    required this.title,
    required this.price,
    required this.category,
    required this.categoryBg,
    required this.categoryText,
    required this.imageUrl,
    this.isFavorite = true,
  });

  FavoriteProduct copyWith({bool? isFavorite}) {
    return FavoriteProduct(
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

const List<FavoriteProduct> _initialFavorites = [
  FavoriteProduct(
    id: 'serum-vitamin-c',
    title: 'Sérum Facial Antioxidante Vitamin C+',
    price: 'R\$ 189,90',
    category: 'SKIN HEALTH',
    categoryBg: Color(0xFFFCD400),
    categoryText: Color(0xFF5A4300),
    imageUrl:
        'https://lh3.googleusercontent.com/aida-public/AB6AXuCst8VmobGYlwMUb6tqK_2wi1jiMZ2g3QPXNL1ymmA-UyTOuH9YMjsDn3EQ426Y10_gmNeG9f7ZeDTnOF_PPIVCoyy6gRdPhap02_oIrhPXCCffIGkHH7dFvSy3NoYOGzcpfY7GhI7jBcP7C5TADSjF7KOHMUxrJWq-K9v-IcfXIyrLI3AoJKtXjB5yTnhaDHKu9SMxjgtOvPuVAqvh5xb_79u77utvzZk0INFO9vireVrQMUX0oS8dy9F1uImY4knqECs13QC7Wxg',
  ),
  FavoriteProduct(
    id: 'complexo-a-z',
    title: 'Complexo Vitamínico A-Z 60 Caps',
    price: 'R\$ 54,90',
    category: 'SUPLEMENTOS',
    categoryBg: Color(0xFFCDE5FF),
    categoryText: Color(0xFF003E67),
    imageUrl:
        'https://lh3.googleusercontent.com/aida-public/AB6AXuDJXQNuFGCQwWefF5zdmVg0qSBteFuP_dwhotU00z3To-pcxr4muiI1hXWnBmws5B_zvh1E1nqJflchUTO5I8IETv71qBeh4DNv4Kl-zQAU-xWY1ATkRigZGq9LGWOLHT31TZFGipa8dep9nxLFkUsiVdYoM6CT_mcTL17ZKCAEO2-ELYYJlwuNa971Ut_AnrohhtReYtpxmMOeXqR_8mbxBrHBdz-hpTssPttwzHZADn2abO0PfUs4qQXno8RNU79pAcQnX-8DKIc',
  ),
  FavoriteProduct(
    id: 'analgesico-ultra',
    title: 'Analgésico Ultra 500mg 20 Comprimidos',
    price: 'R\$ 22,15',
    category: 'MEDICAMENTO',
    categoryBg: Color(0xFFFFDAD6),
    categoryText: Color(0xFF93000A),
    imageUrl:
        'https://lh3.googleusercontent.com/aida-public/AB6AXuCjAgWRkWSt2J6Yzh7pLEzuelyt7qP79I-T3KmBzdBdPEP-3KeteAn30lM9YcsL7inHZVppehPE4v9r0P0EGxKiEzhVnY_OWaTQ_6o5h0zJjTb0Foy7YKZAx1nIdoKcp4lLOOVHFxjO_V_zn15rKZKPCS-sXmO1D_3WIHrGYncEUwwcv6UVAHU-q1EJMyjwEYIkje3YMRYxleQ9lSjf_zlhGKT-30KOD9F7WeyCVvQLlruMKZrUy9YNZ5mLnq_QXl4kIRjumQAaJDE',
  ),
  FavoriteProduct(
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

const List<FavoriteProduct> _initialSuggestions = [
  FavoriteProduct(
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
  FavoriteProduct(
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
