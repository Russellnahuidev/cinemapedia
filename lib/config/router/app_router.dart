import 'package:cinamapedia/presentation/screens/screens.dart';
import 'package:go_router/go_router.dart';

final appRouter = GoRouter(
  initialLocation: '/home/0',
  routes: [
    GoRoute(
      path: '/home/:page',
      name: HomeScreen.name,
      builder: (context, state) {
        final pageIndex = int.parse(state.pathParameters['page'] ?? '0');

        return HomeScreen(pageIndex: pageIndex);
      },
      routes: [
        GoRoute(
          path: 'movie/:movieId',
          name: MovieScreen.name,
          builder: (context, state) {
            final movieId = state.pathParameters['movieId']!;
            return MovieScreen(movieId: movieId);
          },
        ),
      ],
    ),
    GoRoute(path: '/', redirect: (_, __) => '/home/0'),
  ],
);
