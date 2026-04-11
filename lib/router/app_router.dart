import 'package:dream_pos/presentation/screens/auth/login_screen.dart';
import 'package:dream_pos/presentation/screens/auth/splash_screen.dart';
import 'package:dream_pos/presentation/screens/home/main_screen.dart';
import 'package:dream_pos/presentation/screens/home/master_screen.dart';
import 'package:dream_pos/data/models/response/outlet_reponse_model.dart';
import 'package:dream_pos/presentation/screens/masters/employees/employee_screen.dart';
import 'package:dream_pos/presentation/screens/masters/employees/form_employee_screen.dart';
import 'package:dream_pos/presentation/screens/masters/employees/list_employee_screen.dart';
import 'package:dream_pos/presentation/screens/masters/item_categories/form_item_category_screen.dart';
import 'package:dream_pos/presentation/screens/masters/item_categories/item_category_screen.dart';
import 'package:dream_pos/presentation/screens/masters/item_categories/list_item_category_screen.dart';
import 'package:dream_pos/presentation/screens/masters/outlets/form_regis_outlet_screen.dart';
import 'package:dream_pos/presentation/screens/masters/outlets/list_outlet_screen.dart';
import 'package:dream_pos/presentation/screens/masters/positions/form_position_screen.dart';
import 'package:dream_pos/presentation/screens/masters/positions/list_position_screen.dart';
import 'package:dream_pos/presentation/screens/masters/positions/position_screen.dart';
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
            builder: (context, state) => const ItemCategoryScreen(),
            routes: [
              GoRoute(
                path: 'list-item-category',
                name: 'master-list-item-category',
                builder: (context, state) {
                  final payload = state.extra as Map<String, dynamic>?;
                  final selectedOutletId = payload?['outletId'] as String?;

                  if (selectedOutletId == null || selectedOutletId.isEmpty) {
                    return const ItemCategoryScreen();
                  }

                  return ListItemCategoryScreen(
                    selectedOutletId: selectedOutletId,
                    selectedOutletName: payload?['outletName'] as String?,
                  );
                },
              ),
              GoRoute(
                path: 'form-item-category',
                name: 'master-form-item-category',
                builder: (context, state) {
                  final payload = state.extra as Map<String, dynamic>?;
                  return FormItemCategoryScreen(
                    selectedOutletId: payload?['selectedOutletId'] as String?,
                  );
                },
              ),
            ],
          ),
          GoRoute(
            path: 'employee',
            name: 'master-employee',
            builder: (context, state) => const EmployeeScreen(),
            routes: [
              GoRoute(
                path: 'list-employee',
                name: 'master-list-employee',
                builder: (context, state) {
                  final payload = state.extra as Map<String, dynamic>?;
                  final selectedOutletId = payload?['outletId'] as String?;

                  if (selectedOutletId == null || selectedOutletId.isEmpty) {
                    return const EmployeeScreen();
                  }

                  return ListEmployeeScreen(
                    selectedOutletId: selectedOutletId,
                    selectedOutletName: payload?['outletName'] as String?,
                  );
                },
              ),
              GoRoute(
                path: 'form-employee',
                name: 'master-form-employee',
                builder: (context, state) {
                  final payload = state.extra as Map<String, dynamic>?;
                  final selectedOutletId =
                      payload?['selectedOutletId'] as String?;

                  if (selectedOutletId == null || selectedOutletId.isEmpty) {
                    return const EmployeeScreen();
                  }

                  return FormEmployeeScreen(
                    selectedOutletId: selectedOutletId,
                    selectedOutletName:
                        payload?['selectedOutletName'] as String?,
                    initialEmail: payload?['initialEmail'] as String?,
                    initialFullName: payload?['initialFullName'] as String?,
                    initialJabatanId: payload?['initialJabatanId'] as int?,
                  );
                },
              ),
            ],
          ),
          GoRoute(
            path: 'positions',
            name: 'master-position',
            builder: (context, state) => const PositionScreen(),
            routes: [
              GoRoute(
                path: 'list-position',
                name: 'master-list-position',
                builder: (context, state) {
                  final payload = state.extra as Map<String, dynamic>?;
                  final selectedOutletId = payload?['outletId'] as String?;

                  if (selectedOutletId == null || selectedOutletId.isEmpty) {
                    return const PositionScreen();
                  }

                  return ListPositionScreen(
                    selectedOutletId: selectedOutletId,
                    selectedOutletName: payload?['outletName'] as String?,
                  );
                },
              ),
              GoRoute(
                path: 'form-position',
                name: 'master-form-position',
                builder: (context, state) {
                  final payload = state.extra as Map<String, dynamic>?;
                  return FormPositionScreen(
                    selectedOutletId: payload?['selectedOutletId'] as String?,
                  );
                },
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
