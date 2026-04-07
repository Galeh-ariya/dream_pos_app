import 'package:dream_pos/presentation/screens/auth/login_screen.dart';
import 'package:dream_pos/presentation/screens/auth/splash_screen.dart';
import 'package:dream_pos/presentation/screens/home/main_screen.dart';
import 'package:dream_pos/presentation/screens/home/master_screen.dart';
import 'package:dream_pos/presentation/widgets/loading_widget.dart';
import 'package:go_router/go_router.dart';

class AppRouter {
  static final router = GoRouter(
    initialLocation: '/splash',
    routes: [
      GoRoute(
        path: '/test',
        name: 'test',
        builder: (context, state) => const LoadingWidget(),
      ),
      
      GoRoute(
        path: '/master',
        name: 'master',
        builder: (context, state) => const MasterScreen(),
      ),
      
      GoRoute(
        path: '/',
        name: 'main',
        builder: (context, state) => const MainScreen(),
      ),

      GoRoute(
        path: '/splash',
        name: 'splash',
        builder: (context, state) => const SplashScreen(),
      ),

      GoRoute(
        path: '/login',
        name: 'login',
        builder: (context, state) => const LoginScreen(),
        // state.extra
      ),
    ],
  );
}
