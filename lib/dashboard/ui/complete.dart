import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rebco/dashboard/controller/controller.dart';

class CompleteScreen extends StatefulWidget {
  const CompleteScreen({super.key});

  @override
  State<CompleteScreen> createState() => _CompleteScreenState();
}

class _CompleteScreenState extends State<CompleteScreen> {
  AuthController authController=AuthController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image(image: AssetImage("assets/images/completed.png")),
            InkWell(
              onTap: (){
                authController.dashboardRoute(context);
              },
              child: Container(
                width: 300,
                padding: const EdgeInsets.all(15,),
                decoration:ShapeDecoration(
                  color: Colors.green,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)
                  ),
                ),
                child: const Center(
                  child: Text('LOGIN',
                    style: TextStyle(
                        fontSize: 18,
                        color: Colors.white
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
