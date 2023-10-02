
import 'package:flutter/material.dart';
import 'package:rebco/dashboard/ui/dashboard.dart';
import 'package:rebco/dashboard/ui/login_page.dart';
import 'package:rebco/splash/ui/splash.dart';
import 'package:rebco/utils/routes.dart';

import 'dashboard/ui/complete.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'REBCO',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: Colors.white,
          useMaterial3: true,
          scaffoldBackgroundColor: Colors.white,
        ),

        initialRoute: Routes.splashRoute,
        routes: <String, WidgetBuilder>{
          Routes.splashRoute: (context) => const SplashScreen(),
          Routes.dashboardRoute: (context) => const DashboardScreen(),
          Routes.loginRoute: (context) => const LoginPage(),
          Routes.completeRoute: (context) => const CompleteScreen(),

        }

    );
  }
}


