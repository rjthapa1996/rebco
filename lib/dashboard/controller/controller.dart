
import 'package:flutter/cupertino.dart';

import '../../utils/routes.dart';

class AuthController {
  bool isNotValidPhone(String value) {
    if (value.length != 10) {
      return true;
    } else {
      return false;
    }
  }

  void loginRoute(BuildContext context) {
    Navigator.pushNamed(context, Routes.loginRoute);
  }

  void dashboardRoute(BuildContext context) {
    Navigator.pushReplacementNamed(context, Routes.dashboardRoute);
  }

  void completeRoute(BuildContext context) {
    Navigator.pushReplacementNamed(context, Routes.completeRoute);
  }

  // Future<void> apiCallForRegisterUser(
  //     BuildContext context, File? selectedImage) async {
  //   var result = await apiCalls.registerUser(
  //       selectedImage,context);
  //   switch (result['statusCode']) {
  //     case 200:
  //       UserDetailsModel userData = result['data'];
  //       PrefModel prefModel = AppPref.getPref();
  //       prefModel.userData = userData;
  //       await AppPref.setPref(prefModel);
  //       if (context.mounted) {
  //         Navigator.pop(context);
  //       }
  //       break;
  //     case 301:
  //       if (context.mounted) {
  //         Navigator.pop(context);
  //         showErrorToast(context,"User already exist !");
  //       }
  //       break;
  //     default:
  //       if (context.mounted) {
  //         Navigator.pop(context);
  //         showErrorToast(context,"Something Went wrong");
  //       }
  //   }
  // }
  //

}
