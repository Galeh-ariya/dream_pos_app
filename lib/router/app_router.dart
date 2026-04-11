import 'package:dream_pos/presentation/screens/auth/login_screen.dart';
import 'package:dream_pos/presentation/screens/auth/splash_screen.dart';
import 'package:dream_pos/presentation/screens/home/main_screen.dart';
import 'package:dream_pos/presentation/screens/home/master_screen.dart';
import 'package:dream_pos/data/models/response/outlet_reponse_model.dart';
import 'package:dream_pos/presentation/screens/masters/item_categories/form_item_category_screen.dart';
import 'package:dream_pos/presentation/screens/masters/item_categories/list_item_category_screen.dart';
import 'package:dream_pos/presentation/screens/masters/outlets/form_regis_outlet_screen.dart';
import 'package:dream_pos/presentation/screens/masters/outlets/list_outlet_screen.dart';
import 'package:dream_pos/presentation/screens/masters/units/form_unit_screen.dart';
import 'package:dream_pos/presentation/screens/masters/units/list_unit_screen.dart';
import 'package:dream_pos/presentation/screens/masters/units/unit_screen.dart';
import 'package:dream_pos/presentation/widgets/loading_widget.dart';
import 'package:go_router/go_router.dart';

class AppRouter {
  static final router = GoRouter(
    initialLocation: '/splash',
    routes: [
      GoRoute(
        path: '/loading',
        name: 'loading',
        builder: (context, state) => const LoadingWidget(),
      ),

      GoRoute(
        path: '/master',
        name: 'master',
        builder: (context, state) => const MasterScreen(),
        routes: [
          GoRoute(
            path: 'outlets',
            name: 'master-outlets',
            builder: (context, state) => const ListOutletScreen(),
            routes: [
              GoRoute(
                path: 'form-outlet',
                name: 'master-form-outlet',
                builder: (context, state) {
                  final selectedOutlet = state.extra as OutletResponseModel?;
                  return FormRegisOutletScreen(outlet: selectedOutlet);
                },
              ),
            ],
          ),
          GoRoute(
            path: 'units',
            name: 'master-units',
            builder: (context, state) => const UnitScreen(),
            routes: [
              GoRoute(
                path: 'list-unit',
                name: 'master-list-unit',
                builder: (context, state) {
                  final payload = state.extra as Map<String, dynamic>?;
                  final selectedOutletId = payload?['outletId'] as String?;

                  if (selectedOutletId == null || selectedOutletId.isEmpty) {
                    return const UnitScreen();
                  }

                  return ListUnitScreen(
                    selectedOutletId: selectedOutletId,
                    selectedOutletName: payload?['outletName'] as String?,
                  );
                },
              ),
              GoRoute(
                path: 'form-unit',
                name: 'master-form-unit',
                builder: (context, state) {
                  final payload = state.extra as Map<String, dynamic>?;
                  return FormUnitScreen(
                    initialUnitName: payload?['initialUnitName'] as String?,
                    initialOutletId: payload?['initialOutletId'] as String?,
                  );
                },
              ),
            ],
          ),
          GoRoute(
            path: 'item-categories',
            name: 'master-item-categories',
            builder: (context, state) => const ListItemCategoryScreen(),
            routes: [
              GoRoute(
                path: 'form-item-category',
                name: 'master-form-item-category',
                builder: (context, state) => const FormItemCategoryScreen(),
              ),
            ],
          ),
        ],
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
