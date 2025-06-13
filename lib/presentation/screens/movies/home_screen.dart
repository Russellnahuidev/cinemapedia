import 'package:cinamapedia/presentation/views/views.dart';
import 'package:cinamapedia/presentation/widget/widgets.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  static const name = 'home-screm';
  final int pageIndex;
  const HomeScreen({super.key, required this.pageIndex});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

//* Este Mixin es necesario para mantener el estado en el PageView
class _HomeScreenState extends State<HomeScreen>
    with AutomaticKeepAliveClientMixin {
  late PageController pageController;

  @override
  void initState() {
    super.initState();
    pageController = PageController(keepPage: true);
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  final viewRoutes = const <Widget>[
    HomeView(),
    PopularView(), // <------ categorias View
    FavoritesView(),
  ];

  @override
  Widget build(BuildContext context) {
    super.build(context);

    if (pageController.hasClients) {
      pageController.animateToPage(
        widget.pageIndex,
        duration: Duration(milliseconds: 250),
        curve: Curves.easeInOut,
      );
    }
    return Scaffold(
      body: PageView(
        //* Esto evitará que rebote
        physics: const NeverScrollableScrollPhysics(),
        controller: pageController,
        // index: pageIndex,
        children: viewRoutes,
      ),

      bottomNavigationBar: CustomBottonNavigation(
        currentIndex: widget.pageIndex,
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
