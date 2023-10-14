import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_demo/data/utils/utils.dart';
import 'package:firebase_demo/view/auth/veryfy_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';
import 'package:get/route_manager.dart';

import '../../Utils/utils.dart';

class LoginWithPhoneScreen extends StatefulWidget {
  const LoginWithPhoneScreen({super.key});

  @override
  State<LoginWithPhoneScreen> createState() => _LoginWithPhoneScreenState();
}

class _LoginWithPhoneScreenState extends State<LoginWithPhoneScreen> {
  final _phoneController = TextEditingController();
  final _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("login with phone"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomeTextField(
                hintText: '+880172333.....',
                labelText: 'Phone No',
                keyboardType: TextInputType.phone,
                controller: _phoneController,
                errorText: 'Enter the wright phone no',
                prefixIcon: Icon(Icons.phone)),
            SizedBox(
              height: 34,
            ),
            RoundButton(
              text: 'Login',
              onTap: () {
                if (_phoneController.text.isEmpty) {
                  Utils.toastMessage('Error Phone No');
                } else {
                  _auth.verifyPhoneNumber(
                    verificationCompleted: (phoneAuthCredential) {},
                    phoneNumber: _phoneController.text.toString(),
                    verificationFailed: (error) =>
                        Utils.toastMessage(error.toString()),
                    codeSent: (verificationId, forceResendingToken) {
                      Get.to(VerifyScreem(
                        verificationId: verificationId,
                      ));
                    },
                    codeAutoRetrievalTimeout: (verificationId) {
                      verificationId.toString();
                    },
                  );
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
