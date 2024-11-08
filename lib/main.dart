import 'dart:developer';

import 'package:flutter/material.dart';
import 'Screens/Welcome_Screen.dart';
import 'Screens/registration_screen.dart';
import 'Screens/signin_screen.dart';
import 'Screens/chat_screen.dart';
import 'package:firebase_core/firebase_core.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ms.Suaad',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: ChatScreen(),
      // initialRoute: WelcomeScreen.screenroute,
      // routes:{
      //   WelcomeScreen.screenroute: (context) => WelcomeScreen(),
      //   SignInScreen.screenroute: (context) => SignInScreen(),
      //    RegisterationScreen.screenroute: (context) => RegisterationScreen(),
      //    ChatScreen.screenroute: (context) => ChatScreen(),
      // },
    );
  }
}

