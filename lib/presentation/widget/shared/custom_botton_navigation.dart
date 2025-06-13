import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CustomBottonNavigation extends StatelessWidget {
  final int currentIndex;
  const CustomBottonNavigation({super.key, required this.currentIndex});

  void onItemTapped(BuildContext context, int index) {
    switch (index) {
      case 0:
        context.go('/home/0');
        break;
      case 1:
        context.go('/home/1');
        break;
      case 2:
        context.go('/home/2');
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return BottomNavigationBar(
      onTap: (value) => onItemTapped(context, value),
      currentIndex: currentIndex,
      elevation: 0,
      selectedItemColor: colors.primary,
      items: [
        BottomNavigationBarItem(icon: Icon(Icons.home_max), label: 'Inicio'),
        BottomNavigationBarItem(
          icon: Icon(Icons.thumbs_up_down_outlined),
          label: 'Populares',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.favorite_outline),
          label: 'Favoritos',
        ),
      ],
    );
  }
}
