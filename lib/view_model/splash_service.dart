import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_demo/view/auth/login_screen.dart';
import 'package:firebase_demo/view/firestore/firestore_post_screen.dart';
import 'package:firebase_demo/view/post/post_screen.dart';

import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';

class SplashServices {
  final auth = FirebaseAuth.instance;

  Future<void> isLogin(BuildContext context) async {
    final user = auth.currentUser;
    if (user != null) {
      Future.delayed(Duration(seconds: 2))
          .then((value) => Get.to(const FirestorePostScreen()));
    } else {
      Future.delayed(Duration(seconds: 2))
          .then((value) => Get.to(const LoginScreen()));
    }
  }
}
