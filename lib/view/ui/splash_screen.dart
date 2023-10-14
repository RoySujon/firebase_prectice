import 'package:firebase_demo/view_model/splash_service.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final splashService = SplashServices();
  @override
  void initState() {
    splashService.isLogin(context);

    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();

    // splashService.isLogin(context)
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
