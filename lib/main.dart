import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wisetube/core/bloc/app_bloc_observer.dart';
import 'package:wisetube/core/injection/injection_container.dart';
import 'package:wisetube/core/routes/app_routes.dart';
import 'package:wisetube/core/theme.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = AppBlocObserver();
  setupDependencies();
  runApp(const WisetubeApp());
}

class WisetubeApp extends StatelessWidget {
  const WisetubeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Wisetube',
      theme: MaterialTheme(GoogleFonts.poppinsTextTheme()).light(),
      darkTheme: MaterialTheme(GoogleFonts.poppinsTextTheme()).dark(),
      themeMode: ThemeMode.system,
      initialRoute: AppRoutes.home,
      routes: AppRoutes.routes,
      debugShowCheckedModeBanner: false,
    );
  }
}
