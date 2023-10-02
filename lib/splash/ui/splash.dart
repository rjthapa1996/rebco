import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../controller/splash_controller.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  SplashController splashController=SplashController();
  @override
  Widget build(BuildContext context) {
    splashController.moveToNextPage(context);
    return const Scaffold(
        body:Center(
            child:Image(image: AssetImage('assets/images/repco.jpg'),
            )
        )
    );
  }
}
