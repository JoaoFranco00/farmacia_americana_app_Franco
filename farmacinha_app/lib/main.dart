import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:farmacia_app/core/palette/pallete.dart';
import 'package:farmacia_app/app/app_routes.dart';
import 'package:farmacia_app/features/auth/view_models/auth_session_view_model.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: 'https://svutfmjjqkmfcyfgxgqq.supabase.co',
    anonKey: 'sb_publishable_x4Dtp-jkbNuh7euNnFkzjQ_pL9NHceb',
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: AuthSessionViewModel.instance,
      child: MaterialApp(
        title: 'Drogaria Americana Saúde',
        debugShowCheckedModeBanner: false,
        builder: (context, child) {
          // Garante que nenhum ribbon/banner de ambiente apareça no topo da UI.
          final safeChild = child ?? const SizedBox.shrink();
          if (safeChild is Banner) {
            return safeChild.child ?? const SizedBox.shrink();
          }
          return safeChild;
        },
        theme: ThemeData(
          useMaterial3: true,
          scaffoldBackgroundColor: Pallete.backgroundColor,
          colorScheme: ColorScheme.fromSeed(
            seedColor: const Color(0xFFE31E24),
            brightness: Brightness.light,
          ),
        ),
        initialRoute: AppRoutes.splash,
        routes: AppRoutes.routes,
      ),
    );
  }
}
