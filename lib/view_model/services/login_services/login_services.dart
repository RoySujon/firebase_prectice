import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_demo/Utils/utils.dart';
import 'package:firebase_demo/view/home_screen.dart';
import 'package:firebase_demo/view/post/post_screen.dart';
import 'package:flutter/material.dart';

class LoginService extends ChangeNotifier {
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

  Future<dynamic> loginUser(BuildContext context) async {
    isloading();
    _auth
        .signInWithEmailAndPassword(
            email: _emailController.text.toString(),
            password: _passController.text.toString())
        .then((value) {
      isNotloading();
      Utils.toastMessage('Login sucessfull' + value.user!.uid.toString());
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PostScreen(),
          ));
    }).onError((error, stackTrace) {
      isNotloading();
      print(error);
      Utils.toastMessage('Not Login');
    });
  }
}
