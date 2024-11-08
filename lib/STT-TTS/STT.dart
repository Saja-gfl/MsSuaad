import 'package:speech_to_text/speech_to_text.dart';
import 'package:suaadchatapp/STT-TTS/STT.dart' as stt;
import 'package:speech_to_text/speech_to_text.dart' as stt;


class SpeechToTextHelper {
  stt.SpeechToText _speech = stt.SpeechToText();
  bool _isListening = false;

  Future<String> startListening() async {
    String text = "";
    if (!_isListening) {
      bool available = await _speech.initialize();
      if (available) {
        _isListening = true;
        await _speech.listen(onResult: (result) {
          text = result.recognizedWords;
        });
      }
    } else {
      _isListening = false;
      await _speech.stop();
    }
    return text;
  }
}
