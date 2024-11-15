import 'package:flutter/material.dart';

import '../Widgets/MyButton.dart';

class SignInScreen extends StatefulWidget {
  static const  screenroute = 'signin_screen';
  const SignInScreen({ super.key });

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              height: 180,
              child: Image.asset('images/SuaadLogo.png'),
            ),
            SizedBox(height: 50),

            //email box 
            TextField(
             keyboardType: TextInputType.emailAddress,
              textAlign: TextAlign.center,
              onChanged: (value){},
              decoration: InputDecoration(
                hintText: 'Enter your Email',
                contentPadding: EdgeInsets.symmetric(vertical: 10,horizontal: 20),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10))
                ),
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.purple,
                        width: 1),
                    borderRadius: BorderRadius.all(Radius.circular(10))
                ),
                focusedBorder: OutlineInputBorder(

                  // TODO : change this later 
                    borderSide: BorderSide(color: Colors.purple,
                        width: 2),
                    borderRadius: BorderRadius.all(Radius.circular(10))
                ),
              ),

            ),
            SizedBox(height: 8),

            //pass box 
            TextField(
            obscureText: true,  
              textAlign: TextAlign.center,
              onChanged: (value){},
              decoration: InputDecoration(
                hintText: 'Enter your Password',
                contentPadding: EdgeInsets.symmetric(vertical: 10,horizontal: 20),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10))
                ),
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.purple,
                        width: 1),
                    borderRadius: BorderRadius.all(Radius.circular(10))
                ),
                focusedBorder: OutlineInputBorder(

                  // TODO : Change this later
                    borderSide: BorderSide(color: Colors.purple,
                        width: 2),
                    borderRadius: BorderRadius.all(Radius.circular(10))
                ),
              ),

            ),
            SizedBox(height: 10),
            MyButton(
                color: Colors.yellow[900]!,
                title: "Log In",
                onPressed: (){}
            )
          ],
        ),
      ),

    );
  }
}