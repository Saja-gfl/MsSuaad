import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

Future<String> sendMessageToWatson(String message) async {
  final url = 'https://eu-de.ml.cloud.ibm.com/ml/v1/text/generation?version=2023-05-29'; // Replace with your Watson API endpoint
  final apiKey = '2IVk3l-v0K_hXCDPQBJXDkAJPC_6Dw4fF7kjvu55diCC'; // Replace with your IBM Watson API key

  final response = await http.post(
    Uri.parse(url),
    headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Basic ' + base64Encode(utf8.encode('apikey:$apiKey')), //  للترميز.

    },
    body: jsonEncode({
      'input': {'text': message},
    }),
  );

  if (response.statusCode == 200) {
    final data = jsonDecode(response.body);
    return data['output']['text']; // Adjust based on Watson's response format
  } else {
    throw Exception('Failed to load response from Watson');
  }
}

class ChatScreen extends StatefulWidget {
  const ChatScreen({ super.key });

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
    String userMessage = '';
  String watsonResponse = ''; // لتخزين الرد من واتسون
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar( 
        backgroundColor: Colors.purple[200],
    //     bottom: PreferredSize(
    //  preferredSize: const Size.fromHeight(4.0),
    //  child: Container(
    //     color: Colors.purple,
    //     height: 4.0,
    //  )),
        
        title: Row(
          children: [
            Image.asset('images/SuaadLogo.png', height: 70),
            SizedBox(width: 10),
            Text("Suaad Chat ")
          ],
        ),
        actions: [
          IconButton(
              onPressed: (){
                //add log out function
              },
              icon: Icon(Icons.close))
        ],
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: Container(
                child: ListView(
                children: [
                  Text('Watson: $watsonResponse'),
                ],
              ),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                    color: Colors.purple,
                    width: 2,
                  ),
                ),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      onChanged: (value){},
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(
                          vertical: 10,
                          horizontal: 20,
                        ),
                        hintText: "write your msg here...",
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () async {
                      String response = await sendMessageToWatson(userMessage);
                      setState(() {
                        watsonResponse = response;
                      });
                    },
                    child: Text(
                      'send',
                      style: TextStyle(
                        color: Colors.blue[800],
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
