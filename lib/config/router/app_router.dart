import 'package:cinamapedia/presentation/screens/screens.dart';
import 'package:go_router/go_router.dart';

final appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      name: HomeScreen.name,
      builder: (context, state) => HomeScreen(),
    ),
    GoRoute(
      path: '/movie/:movieId',
      name: MovieScreen.name,
      builder: (context, state) {
        final movieId = state.pathParameters['movieId']!;
        return MovieScreen(movieId: movieId);
      },
    ),
  ],
);
