import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  //constructor
  MyButton({ required this.color,required this.title,required this.onPressed});

  // varibles
  final Color color;
  final String title;
  final Function onPressed;


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Material(
        elevation: 5,
        color: color,
        borderRadius: BorderRadius.circular(10),
        child: MaterialButton(
          onPressed: ()=> onPressed,
          minWidth: 200,
          height: 42,
          child: Text(title,style: TextStyle(
              color: Colors.white
          ),),
        ),
      ),
    );
  }
}