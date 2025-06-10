import 'package:cinamapedia/presentation/views/views.dart';
import 'package:cinamapedia/presentation/widget/widgets.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  static const name = 'home-screm';
  final int pageIndex;
  const HomeScreen({super.key, required this.pageIndex});

  final viewRoutes = const <Widget>[
    HomeView(),
    SizedBox(), // <------ categorias View
    FavoritesView(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(index: pageIndex, children: viewRoutes),

      bottomNavigationBar: CustomBottonNavigation(currentIndex: pageIndex),
    );
  }
}
