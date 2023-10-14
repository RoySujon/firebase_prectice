import 'package:firebase_demo/view_model/services/login_services/signup_services.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:firebase_demo/data/utils/utils.dart';
import 'login_screen.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<SignUpServices>(context, listen: false);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      // resizeToAvoidBottomInset: false,
      backgroundColor: Color(0xffFF9F9F9),
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(0, 0, 0, 0),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          // crossAxisAlignment: CrossAxisAlignment.start,
          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const CustomText(text: 'Sign up'),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
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
                                builder: (context) => const LoginScreen(),
                              ));
                        },
                        text: 'Forgot your password?',
                      ),
                      Consumer<SignUpServices>(
                        builder: (context, value, child) => RoundButton(
                          text: 'SIGN UP',
                          loading: value.loading,
                          onTap: () {
                            if (_formKey.currentState!.validate()) {
                              value.signUpUser(context);
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            LoginButtonWithSocialMedia(
              facebookButton: () {},
              googleButton: () {},
            )
          ],
        ),
      ),
    );
  }
}
