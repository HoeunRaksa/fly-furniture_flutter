import 'package:fly/core/routing/app_routes.dart';
import 'package:fly/features/Register/ui/register_sceen.dart';
import 'package:fly/features/splash/ui/splash_screen.dart';
import 'package:go_router/go_router.dart';

class AppRouter {
    static final router = GoRouter(
     initialLocation :  AppRoutes.splash,
       routes : [
         GoRoute(path: AppRoutes.splash,
         builder: (context, state) => const SplashScreen()
         ),
         GoRoute(path: AppRoutes.register,
           builder: (context, state) => const RegisterScreen()
         )
       ]
    );
}