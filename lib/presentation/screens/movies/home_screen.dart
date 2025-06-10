import 'package:cinamapedia/presentation/views/views.dart';
import 'package:cinamapedia/presentation/widget/widgets.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  static const name = 'home-screm';
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FavoritesView(),

      bottomNavigationBar: CustomBottonNavigation(),
    );
  }
}
