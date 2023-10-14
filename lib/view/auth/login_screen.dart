import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_demo/view/auth/login_with_phone.dart';
import 'package:firebase_demo/view_model/services/login_services/login_services.dart';
import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';
import 'package:get/route_manager.dart';

import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';

import '../../data/utils/utils.dart';
import 'forget_pass_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<LoginService>(context, listen: false);
    final _formKey = GlobalKey<FormState>();

    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Color(0xffFF9F9F9),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          // crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                const CustomText(text: 'Login'),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      CustomeTextField(
                        hintText: 'Ente your email here...',
                        labelText: 'Email',
                        controller: controller.emailController,
                        errorText: 'Error Email',
                        prefixIcon: Icon(Icons.email),
                      ),
                      CustomeTextField(
                        hintText: 'Ente your password here...',
                        labelText: 'Password',
                        obscureText: true,
                        controller: controller.passController,
                        errorText: 'Error Password',
                        prefixIcon: Icon(Icons.lock),
                      ),
                    ],
                  ),
                ),
                RowTextWithButton(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ForgetPassScreem(),
                        ));
                  },
                  text: 'Forgot your password?',
                ),
                Consumer<LoginService>(
                  builder: (context, value, child) => RoundButton(
                    text: 'LOGIN',
                    loading: value.loading,
                    onTap: () {
                      if (_formKey.currentState!.validate()) {
                        value.loginUser(context);
                      }
                    },
                  ),
                ),
                SizedBox(
                  height: 34,
                ),
                RoundButton(
                  text: 'Login with Phone',
                  onTap: () {
                    Get.to(const LoginWithPhoneScreen());
                  },
                )
              ],
            ),
            LoginButtonWithSocialMedia(
              googleButton: () {},
              facebookButton: () {
                signInWithGoogle();
              },
            )
          ],
        ),
      ),
    );
  }
}
