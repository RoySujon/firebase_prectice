import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_demo/data/utils/utils.dart';
import 'package:firebase_demo/view/auth/veryfy_screen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';
import 'package:get/route_manager.dart';

import '../../Utils/utils.dart';
import '../firestore/firestore_post_screen.dart';

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
                      final _sixDigitCode = TextEditingController();
                      showDialog(
                          builder: (context) => AlertDialog(
                                  semanticLabel: '6 Digit Code',
                                  actions: [
                                    CustomeTextField(
                                      controller: _sixDigitCode,
                                      errorText: '',
                                      labelText: '6 digit',
                                      borderColor: Colors.blueGrey,
                                      hintText: '223...',
                                    ),
                                    Row(
                                      children: [
                                        TextButton(
                                            onPressed: () {
                                              Get.back();
                                            },
                                            child: Text('Cancel')),
                                        TextButton(
                                            onPressed: () async {
                                              final credential =
                                                  PhoneAuthProvider.credential(
                                                      verificationId:
                                                          verificationId,
                                                      smsCode:
                                                          _sixDigitCode.text);

                                              try {
                                                await _auth
                                                    .signInWithCredential(
                                                        credential);
                                                Get.to(FirestorePostScreen());
                                              } catch (e) {
                                                if (kDebugMode) {
                                                  print(e);
                                                }
                                              }
                                            },
                                            child: Text('Verify')),
                                      ],
                                    ),

                                    // applicationName: 'UPDATE',
                                  ]),
                          context: context);
                    },
                    // Get.to(VerifyScreem(
                    //   verificationId: verificationId,
                    // ));

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
