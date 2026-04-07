import 'package:dream_pos/bloc/login/login_bloc.dart';
import 'package:dream_pos/bloc/logout/logout_bloc.dart';
import 'package:dream_pos/data/repositories/auth_repository.dart';
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
    url: 'https://supadream.digitaldream.or.id',
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
