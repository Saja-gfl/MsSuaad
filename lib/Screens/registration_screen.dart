import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:suaadchatapp/Screens/chat_screen.dart';
import 'package:suaadchatapp/Widgets/MyButton.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RegisterationScreen extends StatefulWidget {
  static const  screenroute = 'registration_screen';
  const RegisterationScreen({ super.key });

  @override
  State<RegisterationScreen> createState() => _RegisterationScreenState();
}

class _RegisterationScreenState extends State<RegisterationScreen> {
  final _auth = FirebaseAuth.instance;
  late String email; 
  late String password;

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
             child:  Image.asset('images/SuaadLogo.png'),
            ),
            SizedBox(height: 50),

            //email box 
            TextField(
              keyboardType: TextInputType.emailAddress,
              textAlign: TextAlign.center,
              onChanged: (value){
                email = value;
              },
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
              onChanged: (value){
                password = value;
              },
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
                    borderSide: BorderSide(color: Colors.purple,
                        width: 2),
                    borderRadius: BorderRadius.all(Radius.circular(10))
                ),
              ),

            ),
            SizedBox(height: 10),
            MyButton(
                color: Colors.blue[800]!,
                title: "Register",
                onPressed: () async {
                  // print(email);
                  // print(password);
                  
                    try {
                      final newuser = await _auth.createUserWithEmailAndPassword(
                    email: email, password: password);
                    // Navigator.pushNamed(context, ChatScreen.screenroute);
                    } catch (e) {
                      print(e);
                      
                    }
                }
            )
          ],
        ),
      ),

    );
  }
}