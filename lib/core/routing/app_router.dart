import 'package:fly/core/routing/app_routes.dart';
import 'package:go_router/go_router.dart';
import '../../features/Register/ui/register_sceen.dart';
import '../../features/profile/Test.dart';

class AppRouter {
    static final router = GoRouter(
     initialLocation :  AppRoutes.test,
       routes : [
         GoRoute(path: AppRoutes.login,
         builder: (context, state) => const RegisterScreen()
         ),
         GoRoute(path: AppRoutes.test,
             builder: (context, state) => const Test()
         ),
       ]
    );
}