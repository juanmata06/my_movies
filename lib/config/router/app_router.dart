import 'package:go_router/go_router.dart';
import 'package:my_movies/presentation/screens/screens.dart';

//* Go Router configs:
final appRouter = GoRouter(
  initialLocation: '/', 
  routes: [
    GoRoute(
      path: '/', 
      name: HomeScreen.name,
      builder: (context, state) => const HomeScreen()
    )
  ]
);
