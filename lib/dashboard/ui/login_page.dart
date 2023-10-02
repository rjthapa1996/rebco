import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../controller/controller.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  AuthController authController=AuthController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 270,horizontal: 70,),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Center(
                child: Image(image: AssetImage('assets/images/repco.jpg')),
              ),

              const SizedBox(height: 70,),
              const  Form(
                  child: TextField(
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                        hintText: 'UserName',
                    ),
                  )),
              const SizedBox(height: 40,),
              const Form(child: TextField(
                keyboardType: TextInputType.visiblePassword,
                decoration: InputDecoration(
                    hintText: 'Password'
                ),
              )),
              const SizedBox(height: 20,),

              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Dont Have an Account?',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                      color: Colors.green,
                    ),),
                  Text('Forgot Password?',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                      color: Colors.green,
                    ),),
                ],
              ),

              const SizedBox(height: 40,),
              InkWell(
                onTap: (){
                  authController.dashboardRoute(context);
                },
                child: Container(
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
      ),
    );
  }
}
