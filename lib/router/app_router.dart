import 'package:auto_route/auto_route.dart';
import 'package:test_store/features/autorization/ui/authorization_screen.dart';
import 'package:test_store/features/product/ui/screens/favorites_screen.dart';
import 'package:test_store/features/product/ui/screens/product_screen.dart';
import 'package:test_store/features/profile/ui/screen/profile_screen.dart';
import 'package:test_store/features/registration/ui/registration_screen.dart';
part 'app_router.gr.dart';

@AutoRouterConfig()
class AppRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(
          page: AuthorizationRoute.page,
          initial: true,
        ),
        AutoRoute(
          page: RegistrationRoute.page,
        ),
        AutoRoute(
          page: ProductRoute.page,
        ),
        AutoRoute(
          page: FavoritesRoute.page,
        ),
        AutoRoute(
          page: ProfileRoute.page,
        )
      ];
}
