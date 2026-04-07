import 'package:flutter/material.dart';
import 'package:farmacia_app/core/palette/pallete.dart';

class BannerCarousel extends StatefulWidget {
  final Function(int)? onBannerTap;

  const BannerCarousel({
    super.key,
    this.onBannerTap,
  });

  @override
  State<BannerCarousel> createState() => _BannerCarouselState();
}

class _BannerCarouselState extends State<BannerCarousel> {
  late PageController _pageController;
  int _currentIndex = 0;

  final List<BannerItem> banners = [
    BannerItem(
      id: 1,
      title: 'TUDO PARA A SUA\nSAÚDE COM O\nMELHOR PREÇO',
      subtitle: 'Confira as promoções especiais\nda semana em todas as nossas unidades.',
      imageUrl:
          'https://images.unsplash.com/photo-1587854692152-cbe660dbde0f?w=500&h=300&fit=crop',
      tag: 'OFERTAS EXCLUSIVAS',
      action: 'Saiba mais',
    ),
    BannerItem(
      id: 2,
      title: 'CUIDADOS COM\nA PELE E BELEZA',
      subtitle: 'Produtos premium com até 40%\nde desconto para você.',
      imageUrl:
          'https://images.unsplash.com/photo-1556228578-8c89e6adf883?w=500&h=300&fit=crop',
      tag: 'BELEZA EM FOCO',
      action: 'Comprar agora',
    ),
    BannerItem(
      id: 3,
      title: 'VITAMINAS E\nSUPLEMENTOS',
      subtitle: 'Reforce sua imunidade com\nnossas melhores marcas.',
      imageUrl:
          'https://images.unsplash.com/photo-1516339901601-2e1b62dc0c45?w=500&h=300&fit=crop',
      tag: 'SAÚDE E BEM-ESTAR',
      action: 'Explorar',
    ),
  ];

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final bannerHeight = screenHeight < 600 ? 180.0 : 220.0;

    return Column(
      children: [
        // PageView (Carrossel)
        SizedBox(
          height: bannerHeight,
          child: PageView.builder(
            controller: _pageController,
            onPageChanged: (index) {
              setState(() => _currentIndex = index);
            },
            itemCount: banners.length,
            itemBuilder: (context, index) {
              return _BannerItem(
                banner: banners[index],
                onTap: () {
                  widget.onBannerTap?.call(banners[index].id);
                  debugPrint('Banner ${banners[index].id} clicado');
                },
              );
            },
          ),
        ),

        // Indicadores de página
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              banners.length,
              (index) => GestureDetector(
                onTap: () {
                  _pageController.animateToPage(
                    index,
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                  );
                },
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  width: _currentIndex == index ? 24 : 8,
                  height: 8,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    color: _currentIndex == index
                        ? Pallete.primaryRed
                        : Pallete.borderColor,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _BannerItem extends StatelessWidget {
  final BannerItem banner;
  final VoidCallback onTap;

  const _BannerItem({
    required this.banner,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              // ignore: deprecated_member_use
              color: Colors.black.withOpacity(0.1),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Stack(
            children: [
              // Imagem de fundo
              Image.network(
                banner.imageUrl,
                fit: BoxFit.cover,
                width: double.infinity,
                height: double.infinity,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    color: Pallete.primaryRed,
                    child: const Center(
                      child: Icon(
                        Icons.image_not_supported_outlined,
                        color: Colors.white,
                        size: 40,
                      ),
                    ),
                  );
                },
              ),

              // Overlay escuro
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.centerRight,
                    end: Alignment.centerLeft,
                    colors: [
                      // ignore: deprecated_member_use
                      Colors.black.withOpacity(0.7),
                      // ignore: deprecated_member_use
                      Colors.black.withOpacity(0.3),
                    ],
                  ),
                ),
              ),

              // Conteúdo do banner
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Tag
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: Pallete.accentYellow,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        banner.tag,
                        style: const TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 50, 50, 50),
                        ),
                      ),
                    ),

                    // Título e Subtítulo
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          banner.title,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            height: 1.2,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          banner.subtitle,
                          style: TextStyle(
                            fontSize: 12,
                            // ignore: deprecated_member_use
                            color: Colors.white.withOpacity(0.9),
                            height: 1.4,
                          ),
                        ),
                      ],
                    ),

                    // Botão CTA
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: Pallete.accentYellow,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        banner.action,
                        style: const TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 50, 50, 50),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class BannerItem {
  final int id;
  final String title;
  final String subtitle;
  final String imageUrl;
  final String tag;
  final String action;

  BannerItem({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.imageUrl,
    required this.tag,
    required this.action,
  });
}
