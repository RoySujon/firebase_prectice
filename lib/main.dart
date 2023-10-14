import 'package:firebase_demo/view/auth/forget_pass_screen.dart';
import 'package:firebase_demo/view/auth/sign_up_screen.dart';
import 'package:firebase_demo/view/home_screen.dart';
import 'package:firebase_demo/view/ui/splash_screen.dart';
import 'package:firebase_demo/view_model/services/forget_pass_service.dart';

import 'package:firebase_demo/view_model/services/login_services/login_services.dart';
import 'package:firebase_demo/view_model/services/login_services/signup_services.dart';

import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/route_manager.dart';

import 'firebase_options.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => LoginService(),
        ),
        ChangeNotifierProvider(
          create: (context) => SignUpServices(),
        ),
        ChangeNotifierProvider(
          create: (context) => ForgotPassServices(),
        ),
      ],
      child: GetMaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: SplashScreen(),
      ),
    );
  }
}
