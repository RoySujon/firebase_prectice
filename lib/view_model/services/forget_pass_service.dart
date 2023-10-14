import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_demo/Utils/utils.dart';
import 'package:firebase_demo/view/auth/login_screen.dart';
import 'package:flutter/material.dart';

class ForgotPassServices extends ChangeNotifier {
  TextEditingController _emailController = TextEditingController();
  TextEditingController get emailController => _emailController;
  TextEditingController _passController = TextEditingController();
  TextEditingController get passController => _passController;
  bool _loading = true;
  bool get loading => _loading;
  final _auth = FirebaseAuth.instance;
  isloading() {
    _loading = false;
    notifyListeners();
  }

  isNotloading() {
    _loading = true;
    notifyListeners();
  }

  Future<dynamic> forgetPass(BuildContext context) async {
    isloading();
    _auth
        .sendPasswordResetEmail(
      email: _emailController.text.toString(),
    )
        .then((value) {
      isNotloading();
      Utils.toastMessage('Login sucessfull');
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => LoginScreen(),
          ));
    }).onError((error, stackTrace) {
      isNotloading();
      print(error);
      Utils.toastMessage('Not Login');
    });
  }
}
