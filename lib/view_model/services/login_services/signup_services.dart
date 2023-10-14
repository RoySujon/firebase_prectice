import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_demo/Utils/utils.dart';
import 'package:firebase_demo/view/home_screen.dart';
import 'package:flutter/material.dart';

class SignUpServices extends ChangeNotifier {
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

  Future<dynamic> signUpUser(BuildContext context) async {
    _auth
        .createUserWithEmailAndPassword(
            email: _emailController.text.toString(),
            password: _passController.text.toString())
        .then((value) {
      isNotloading();
      Utils.toastMessage('User Create sucessfull' + value.user!.uid.toString());
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => HomeScreen(),
          ));
    }).onError((error, stackTrace) {
      isNotloading();
      Utils.toastMessage('Not Create' + error.toString());
    });
    isloading();
  }
}
