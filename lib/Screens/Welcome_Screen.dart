import'package:flutter/material.dart';
import 'package:suaadchatapp/Screens/registration_screen.dart';
import 'package:suaadchatapp/Screens/signin_screen.dart';
import 'package:suaadchatapp/Widgets/MyButton.dart';


class WelcomeScreen extends StatefulWidget {
  static const  screenroute = 'Welcome_Screen';
  const WelcomeScreen({ super.key });

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body:
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          mainAxisAlignment : MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
          Column(
            children: [ Container(
              height: 180,
              child: Image.asset('images/SuaadLogo.png'),
            ),
            Text("Ms.Suaad",style: TextStyle(fontSize: 40, fontWeight: FontWeight.w900,
              color: Color(0xff2e386b),),),
            ],
          ),
            SizedBox(height: 30),
            MyButton(
              
              color: Color(0xFF9B60B0),
              title: 'sign in',
              onPressed: () {
                Navigator.pushNamed(context, SignInScreen.screenroute);
                
              },
            ),
            MyButton(
              color: Color(0xFF9B60B0),
              title: 'register',
              onPressed: (){
                Navigator.pushNamed(context, RegisterationScreen.screenroute);
              },
            )
        ],
        ),
      ),
    );
}}


// this is the sign in button refacctored as a button to reuse later
// please pass the varibales needed as a constructor when used
