import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_demo/data/utils/utils.dart';
import 'package:firebase_demo/view/home_screen.dart';
import 'package:flutter/foundation.dart';

import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';
import 'package:get/route_manager.dart';

class VerifyScreem extends StatefulWidget {
  const VerifyScreem({super.key, required this.verificationId});
  final String verificationId;
  @override
  State<VerifyScreem> createState() => _VerifyScreemState();
}

class _VerifyScreemState extends State<VerifyScreem> {
  final _phoneController = TextEditingController();
  final _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Verify"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomeTextField(
                hintText: '6 Digit code',
                keyboardType: TextInputType.phone,
                controller: _phoneController,
                errorText: 'Enter the wright phone no',
                prefixIcon: Icon(Icons.phone)),
            SizedBox(
              height: 34,
            ),
            RoundButton(
              text: 'Verify',
              onTap: () async {
                final credential = PhoneAuthProvider.credential(
                    verificationId: widget.verificationId,
                    smsCode: _phoneController.text);

                try {
                  await _auth.signInWithCredential(credential);
                  Get.to(HomeScreen());
                } catch (e) {
                  if (kDebugMode) {
                    print(e);
                  }
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
