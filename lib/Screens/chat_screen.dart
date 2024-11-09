import 'package:flutter/material.dart';

import 'package:dash_chat_2/dash_chat_2.dart';

import 'package:http/http.dart' as http;

import 'dart:convert';

import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:flutter_tts/flutter_tts.dart';

// import 'package:dio/dio.dart';
// import 'package:shared_preferences/shared_preferences.dart';

import 'package:suaadchatapp/TokenHelper.dart';

class ChatScreen extends StatefulWidget {

  const ChatScreen({super.key});



  @override

  State<ChatScreen> createState() => _ChatScreenState();


}



class _ChatScreenState extends State<ChatScreen> {

  final _user = ChatUser(id: '1', firstName: 'User'); // معرف المستخدم

  final _bot = ChatUser(id: '2', firstName: 'معلمة سعاد'); // معرف النموذج الذكي


  String main_prompt = "<s> [INST]<<SYS>>\nانتي مساعدة معلمة روضة داخل الفصل , واسمك دائما  معلمة سعاد فقط \n\nانتي معلمة رياض اطفال و تتعاملين مع الاطفال فقط\n\nالاسئلة التي تأتيك هي من الاطفال تحت 6 سنوات فقط , فالجواب يجب ان يكون مبسط وواضح جدا\n\nحيي الاطفال في البدايه واحكي معهم بكل حب ولطافة \n\nعلميهم الحروف والارقام العربية بشكل بسيط وواضح \n\nاحكي لهم الحكايات والقصص بطابع عربي لكن بشكل واضح \n\nعلميهم بعض الكلمات العربية البسيطة \n\nجاوبي على اسئلتهم البسيطه باجوبة سهله لا تتجاوز العشر كلمات\n\nشجعيهم على التحدث بالعربية \n\nاحكي لهم عن الثقافة والعادات والتقاليد العربية \n\nعلميهم بعض القيم والمبادئ العربية مثل الاحترام والتعاون والصدق\n\nاحرصي على توفير بيئة تعليمية ممتعة وجذابة للأطفال\n\nتفاعلي معهم واستمعي لآرائهم واسأليهم عن يومهم وتجاربهم\n\nقدمي لهم الدعم والتشجيع لتعلم اللغة العربية والثقافة العربية\n\nتذكري أن دورك كمعلمة روضة مهم جداً في تشكيل شخصية الأطفال وتنمية مهاراتهم اللغوية والثقافية. \n\nلا تجاوبين على اي سؤال ليس له علاقه بتعليم الاطفال نهائيا  \n<</SYS>>\n\n";
  List<ChatMessage> messages = [];

  final String apiUrl = "https://eu-de.ml.cloud.ibm.com/ml/v1/text/generation?version=2023-05-29"; // رابط API الخاص بك
  //final String apiKey = "eyJraWQiOiIyMDI0MTEwMTA4NDIiLCJhbGciOiJSUzI1NiJ9.eyJpYW1faWQiOiJJQk1pZC02OTYwMDBKRlZMIiwiaWQiOiJJQk1pZC02OTYwMDBKRlZMIiwicmVhbG1pZCI6IklCTWlkIiwianRpIjoiMWY2MThhM2MtZWM2YS00Y2Y5LTkwMTgtZmZkMDE2ZjJiZTQ1IiwiaWRlbnRpZmllciI6IjY5NjAwMEpGVkwiLCJnaXZlbl9uYW1lIjoiSm9tYW5oIiwiZmFtaWx5X25hbWUiOiJNb2hhbW1hZCIsIm5hbWUiOiJKb21hbmggTW9oYW1tYWQiLCJlbWFpbCI6ImpvbWFubmgxNkBnbWFpbC5jb20iLCJzdWIiOiJqb21hbm5oMTZAZ21haWwuY29tIiwiYXV0aG4iOnsic3ViIjoiam9tYW5uaDE2QGdtYWlsLmNvbSIsImlhbV9pZCI6IklCTWlkLTY5NjAwMEpGVkwiLCJuYW1lIjoiSm9tYW5oIE1vaGFtbWFkIiwiZ2l2ZW5fbmFtZSI6IkpvbWFuaCIsImZhbWlseV9uYW1lIjoiTW9oYW1tYWQiLCJlbWFpbCI6ImpvbWFubmgxNkBnbWFpbC5jb20ifSwiYWNjb3VudCI6eyJ2YWxpZCI6dHJ1ZSwiYnNzIjoiMzlhYTJjZjlkZDMzNDM1ZThkYWNmNTViN2RhOTg0NzgiLCJpbXNfdXNlcl9pZCI6IjEyNjc3NjEzIiwiZnJvemVuIjp0cnVlLCJpbXMiOiIyNzQ5NDAyIn0sImlhdCI6MTczMDk5NTQwOSwiZXhwIjoxNzMwOTk5MDA5LCJpc3MiOiJodHRwczovL2lhbS5jbG91ZC5pYm0uY29tL2lkZW50aXR5IiwiZ3JhbnRfdHlwZSI6InVybjppYm06cGFyYW1zOm9hdXRoOmdyYW50LXR5cGU6YXBpa2V5Iiwic2NvcGUiOiJpYm0gb3BlbmlkIiwiY2xpZW50X2lkIjoiZGVmYXVsdCIsImFjciI6MSwiYW1yIjpbInB3ZCJdfQ.OIhv3QoYyVwnfaJKryw1a2PltDCxC80tx1yWBJ7IXe5P5bRZ6xBvriOO_gVDOwtOGqMQWqTWOGSc9R4qs-qCzzIu0ClH_BL2bRJPHurIkEiQUm5JuN-_ijCEMt1r397qUH45a0a_IHQH5kzYXhAue-bgoPaw1nWeJVmahdnoBWw9vymG0FgR1pVkQOxJNtOXTEHfD6PW2JcU2QzDFACXfaynaz6zFihi8paIufjLkWQM6x_dAT7fhZcuCrM22aGfD9vxDgcuUttSIaznBOE7OY6Yv2cGh7sW_8H4eZ2Pp8s46G7pI8la2Ql9CWCFr8j4H6GBy4pTcaIU75tvxEHIzA";
  String? accessToken;
  String apiKey ='2IVk3l-v0K_hXCDPQBJXDkAJPC_6Dw4fF7kjvu55diCC';




  stt.SpeechToText _speech = stt.SpeechToText();
  FlutterTts _flutterTts = FlutterTts();
  bool _isListening = false;  // للتحقق إذا كان الاستماع مفعل أم لا



      // دالة لتحويل النص إلى كلام
  Future<void> _speak(String text) async {
    if (text.isNotEmpty) {
      await _flutterTts.setLanguage("ar");

      // تعيين درجة الصوت (يمكنك تعديلها حسب الرغبة)
      await _flutterTts.setPitch(
          1); // قيمة تتراوح من 0.5 إلى 2 (قيمة أعلى تعني صوت أعلى)

      // تعيين السرعة (تتراوح من 0.5 إلى 2)
      await _flutterTts.setSpeechRate(
          0.6); // يمكنك تعديلها حسب السرعة التي تفضلها

      // تحديد الصوت الخاص بالمعلمة (قد يختلف الصوت حسب النظام)
      await _flutterTts.setVoice({"name": "ar-xa-x-asma", "locale": "ar"});


      await _flutterTts.speak(text); // تحويل النص إلى صوت
    }
  }

  String formatMessages() {
    StringBuffer formattedString = StringBuffer();

    for (int i = messages.length - 1; i >= 0; i--) {
      // Access the content of the message
      String messageContent = messages[i].text;

      // Append the message with the required formatting
      if (i % 2 == 0) {
        formattedString.write(messageContent + " [/INST] ");
      } else {
        formattedString.write(messageContent + " </s><s> [INST] ");
      }
    }

    // Append the new message with the appropriate format based on its index
    // formattedString.write(newMessage);
    // formattedString.write(messages.length % 2 == 0 ? " [/INST]" : " </s><s> [INST]");

    // Concatenate with main_prompt and return the final string
    return main_prompt + formattedString.toString();
  }

  // دالة لبدء الاستماع
  void _startListening() async {
    if (!_isListening) {
      bool available = await _speech.initialize();  // التحقق من توفر الاستماع
      if (available) {
        await _speech.listen(
          onResult: (result) {
            setState(() {
              // إضافة النص الذي تم سماعه في الرسائل
              messages.insert(
                0,
                ChatMessage(
                  text: result.recognizedWords,
                  user: _user,
                  createdAt: DateTime.now(),
                ),
              );
            });
          },
        );
        setState(() {
          _isListening = true;  // تغيير حالة الاستماع إلى true
        });
      } else {
        print("Speech recognition not available.");
      }
    }
  }


  // دالة لتوقف الاستماع
  void _stopListening() async {
    if (_isListening) {
      await _speech.stop();  // إيقاف الاستماع
      setState(() {
        _isListening = false;  // تحديث حالة الاستماع
      });
    }
  }


  @override

  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(

        title: const Text("Chat with AI"),

      ),

      body: Column(
        children: [
          // واجهة DashChat لعرض المحادثة
          Expanded(
            child: DashChat(
              currentUser: _user,
              onSend: onSend,
              messages: messages,
            ),
          ),
          // أزرار التحكم بالصوت
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // زر Speech-to-Text (الميكروفون)
                ElevatedButton(
                  onPressed: _isListening ? _stopListening : _startListening,
                  child: Icon(
                    _isListening ? Icons.mic_off : Icons.mic,
                    size: 30,
                  ),
                ),
                SizedBox(width: 10),
                // زر Text-to-Speech (التحدث)
                ElevatedButton(
                  onPressed: () => _speak("مرحبًا ! كيف يمكنني مساعدتك؟"),
                  child:
                  Icon(Icons.volume_up,
                    size: 30,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }



  void onSend(ChatMessage message) async {
    setState(() {
      messages.insert(0, message);
    });


    // إرسال رسالة المستخدم إلى واجهة Watsonx API

    // List<Map<String, dynamic>> messagesHistory = messages.reversed.map((msg) {
    //   if (msg.user == _user) {
    //     return {'role': 'user', 'content': msg.text};
    //   } else {
    //     return {'role': 'assistant', 'content': msg.text};
    //   }
    // }).toList();


    var bodyData = {

      'model_id': 'sdaia/allam-1-13b-instruct',
      'project_id': 'cf629a38-2a47-4f82-9741-ec2636009c31',
      'language': 'ar', // تعيين اللغة إلى العربية

      'input': formatMessages(),

      //"ims_user_id": 12677613,
      //"scope": "ibm openid",

      "parameters": {
        "decoding_method": "greedy",
        "max_new_tokens": 900,
        "min_new_tokens": 0,
        "stop_sequences": ['5'],
        "repetition_penalty": 1,
        "temperature": 0.3
      }
    };
    // استدعاء دالة sendMessage لإرسال الرسالة
    await sendMessage(apiUrl, bodyData);
  }

    //print(formatMessages());

    Future<void> sendMessage(String apiUrl, Map<String, dynamic> bodyData) async {
    try {
      // تأكد من أن التوكن متوفر أو جدد التوكن إذا كان غير متاح
      if (accessToken == null) {

        if (apiKey.isEmpty) {
          print('Error: API Key is not defined!');
          return;
        }

        print('Starting token refresh...');
        accessToken = await TokenHelper.refreshAccessToken(apiKey);
        print('Token refreshed: $accessToken');

      }
      final response = await http.post(

        Uri.parse(apiUrl),

        headers: {

          "Accept": "application/json",

          'Content-Type': 'application/json',

          'Authorization': 'Bearer  $accessToken',

        },


        body: jsonEncode(bodyData),

      );


      if (response.statusCode == 200) {
        final data = jsonDecode(utf8.decode(response.bodyBytes));

        print(data); // طباعة البيانات للتحقق منها
// تعريف المتغير لتخزين الرد
        String replyText = '';



        if (data.containsKey('response')) {
          // إذا كان الرد موجودًا في الحقل "response"
          replyText = data['response'];
        } else if (data.containsKey('choices') && data['choices'].isNotEmpty) {
          // إذا كان الرد موجودًا في الحقل "choices" كجزء من الرسائل
          final choices = data['choices'] as List;
          print('Choices: $choices');
          replyText =
              choices.map((choice) => choice['message']?['content']).join(" ");
        } else if (data.containsKey('results') && data['results'].isNotEmpty) {
          // إذا كان الرد موجودًا في الحقل "results"
          replyText = data['results'][0]['generated_text'];
        } else {
          // إذا لم يتم العثور على أي من الحقول
          print('Error: No suitable response key found in data');
          //print(data);
        }
        if (replyText.isNotEmpty) {
          setState(() {
            messages.insert(
              0,
              ChatMessage(
                text: replyText,
                user: _bot,
                createdAt: DateTime.now(),
              ),
            );
          });

          // تفعيل Text-to-Speech لتحويل الرد إلى صوت
          _speak(replyText); // استدعاء دالة _speak لتحويل النص إلى كلام
        }
        else if (response.statusCode == 401) {
          // إذا كانت الحالة 401، جدد التوكن وأعد المحاولة
          print("Token expired. Refreshing token...");
          accessToken = await TokenHelper.refreshAccessToken(apiKey);
          if (accessToken != null) {
            await sendMessage(apiUrl, bodyData); // إعادة المحاولة بعد تجديد التوكن
          } else {
            print("Failed to refresh token");
          }
        }
      } else {
        print('Error: ${response.statusCode} - ${response
            .body}'); // طباعة رسالة الخطأ إذا كانت الحالة غير 200
      }
    } catch (e) {
      print('Exception: $e'); // التعامل مع أي استثناءات أثناء الطلب
    }
  }}
