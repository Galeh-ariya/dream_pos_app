import 'package:dream_pos/bloc/item_categories/del_item_category/del_item_category_bloc.dart';
import 'package:dream_pos/bloc/item_categories/list_item_category/list_item_category_bloc.dart';
import 'package:dream_pos/bloc/item_categories/store_item_category/store_item_category_bloc.dart';
import 'package:dream_pos/bloc/outlets/del_outlet/del_outlet_bloc.dart';
import 'package:dream_pos/bloc/outlets/list_outlet/list_outlet_bloc.dart';
import 'package:dream_pos/bloc/login/login_bloc.dart';
import 'package:dream_pos/bloc/logout/logout_bloc.dart';
import 'package:dream_pos/bloc/outlets/store_outlet/store_outlet_bloc.dart';
import 'package:dream_pos/bloc/outlets/update_outlet/update_outlet_bloc.dart';
import 'package:dream_pos/bloc/positions/del_position/del_position_bloc.dart';
import 'package:dream_pos/bloc/positions/list_position/list_position_bloc.dart';
import 'package:dream_pos/bloc/positions/store_position/store_position_bloc.dart';
import 'package:dream_pos/bloc/units/del_unit/del_unit_bloc.dart';
import 'package:dream_pos/bloc/units/list_unit/list_unit_bloc.dart';
import 'package:dream_pos/bloc/units/store_unit/store_unit_bloc.dart';
import 'package:dream_pos/data/repositories/auth_repository.dart';
import 'package:dream_pos/data/repositories/item_categories_repository.dart';
import 'package:dream_pos/data/repositories/outlets_repository.dart';
import 'package:dream_pos/data/repositories/position_repository.dart';
import 'package:dream_pos/data/repositories/units_repository.dart';
import 'package:flutter/material.dart';
import 'package:dream_pos/core/index.dart';
import 'package:dream_pos/router/app_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");

  await Supabase.initialize(
    url: '${dotenv.env['URL']}',
    anonKey: '${dotenv.env['ANONKEY']}',
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => LoginBloc(AuthRepository())),
        BlocProvider(create: (context) => LogoutBloc(AuthRepository())),
        BlocProvider(create: (context) => ListOutletBloc(OutletsRepository())),
        BlocProvider(create: (context) => StoreOutletBloc(OutletsRepository())),
        BlocProvider(create: (context) => DelOutletBloc(OutletsRepository())),
        BlocProvider(create: (context) => UpdateOutletBloc(OutletsRepository())),
        BlocProvider(create: (context) => StoreUnitBloc(UnitRepository())),
        BlocProvider(create: (context) => ListUnitBloc(UnitRepository())),
        BlocProvider(create: (context) => DelUnitBloc(UnitRepository())),
        BlocProvider(create: (context) => ListItemCategoryBloc(ItemCategoriesRepository())),
        BlocProvider(create: (context) => DelItemCategoryBloc(ItemCategoriesRepository())),
        BlocProvider(create: (context) => StoreItemCategoryBloc(ItemCategoriesRepository())),
        BlocProvider(create: (context) => ListPositionBloc(PositionRepository())),
        BlocProvider(create: (context) => StorePositionBloc(PositionRepository())),
        BlocProvider(create: (context) => DelPositionBloc(PositionRepository())),

      ],
      child: MaterialApp.router(
        routerConfig: AppRouter.router,
        debugShowCheckedModeBanner: false,
        title: 'Dream POS',
        theme: AppTheme.lightTheme,
      ),
    );
  }
}
