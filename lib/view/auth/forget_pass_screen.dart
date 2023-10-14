import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_demo/Utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../data/utils/utils.dart';
import '../../view_model/services/forget_pass_service.dart';

class ForgetPassScreem extends StatefulWidget {
  const ForgetPassScreem({super.key});

  @override
  State<ForgetPassScreem> createState() => _ForgetPassScreemState();
}

class _ForgetPassScreemState extends State<ForgetPassScreem> {
  // Future<dynamic> forgotPass()async{
  // _auth.
  // }
  @override
  Widget build(BuildContext context) {
    final _forgetPasscontroller =
        Provider.of<ForgotPassServices>(context, listen: false);
    final _formKey = GlobalKey<FormState>();

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Color(0xffFF9F9F9),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const CustomText(text: 'Forgot password'),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  CustomeTextField(
                    hintText: 'Ente your email here...',
                    labelText: 'Email',
                    controller: _forgetPasscontroller.emailController,
                    errorText: 'Error Email',
                    prefixIcon: Icon(Icons.email),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 34),
            RoundButton(
              text: 'SEND',
              onTap: () {
                if (_formKey.currentState!.validate()) {
                  _forgetPasscontroller.forgetPass(context);
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
