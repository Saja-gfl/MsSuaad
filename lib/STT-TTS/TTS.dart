import 'package:flutter_tts/flutter_tts.dart';

class TextToSpeechHelper {
  FlutterTts flutterTts = FlutterTts();
  Future<void> speak(String text) async {
    await flutterTts.setLanguage("ar"); // تعيين اللغة
    await flutterTts.setSpeechRate(0.5); // تعيين سرعة الصوت
    await flutterTts.speak(text); // تحويل النص إلى كلام
    //  List<dynamic> voices =await FlutterTts
    //  print(voices);

  }
}
