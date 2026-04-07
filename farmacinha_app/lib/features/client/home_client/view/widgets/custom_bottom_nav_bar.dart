import 'package:flutter/material.dart';
import 'package:farmacia_app/core/palette/pallete.dart';

class CustomBottomNavBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const CustomBottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: onTap,
      type: BottomNavigationBarType.fixed,
      backgroundColor: Pallete.whiteColor,
      elevation: 8,
      selectedItemColor: Pallete.primaryRed,
      unselectedItemColor: Pallete.textColor,
      selectedLabelStyle: const TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 12,
      ),
      unselectedLabelStyle: const TextStyle(
        fontWeight: FontWeight.normal,
        fontSize: 12,
      ),
      items: [
        BottomNavigationBarItem(
          icon: Icon(
            Icons.home_outlined,
            color: currentIndex == 0 ? Pallete.primaryRed : Pallete.textColor,
          ),
          activeIcon: const Icon(
            Icons.home_rounded,
            color: Pallete.primaryRed,
          ),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.search_outlined,
            color: currentIndex == 1 ? Pallete.primaryRed : Pallete.textColor,
          ),
          activeIcon: const Icon(
            Icons.search_rounded,
            color: Pallete.primaryRed,
          ),
          label: 'Buscar',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.chat_bubble_outline_rounded,
            color: currentIndex == 2 ? Pallete.primaryRed : Pallete.textColor,
          ),
          activeIcon: const Icon(
            Icons.chat_bubble_rounded,
            color: Pallete.primaryRed,
          ),
          label: 'Chat',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.shopping_cart_outlined,
            color: currentIndex == 3 ? Pallete.primaryRed : Pallete.textColor,
          ),
          activeIcon: const Icon(
            Icons.shopping_cart_rounded,
            color: Pallete.primaryRed,
          ),
          label: 'Carrinho',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.person_outline_rounded,
            color: currentIndex == 4 ? Pallete.primaryRed : Pallete.textColor,
          ),
          activeIcon: const Icon(
            Icons.person_rounded,
            color: Pallete.primaryRed,
          ),
          label: 'Conta',
        ),
      ],
    );
  }
}
