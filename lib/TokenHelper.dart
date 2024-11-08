import 'dart:convert';
import 'package:http/http.dart' as http;

class TokenHelper {
  static Future<String?> refreshAccessToken(String apiKey) async {
    var headers = {
      'Content-Type': 'application/x-www-form-urlencoded',
      'Cookie': 'ak_bmsc=60696BA0CDBACB3D257BA68C80E0C0FE~000000000000000000000000000000~YAAQktgRAjgf0dqSAQAAyw2QChlXw+Z+eA4iTXKOn3cFsbPTyECauZK2r7jcyPYSmxlZxDnHBb+L3/MEps5Mp/pgnRGSK/4lFp/xz3WDbOatNxx29WEOfwu6gOPtUmN2Tjj2DbvVU+NThSH0OX1kA2LCJ74qhZ1STsp4s2/aUss6gcL1RTFjd4jOIZ/Cfi4OiQnSM0p41e06sYVNrpC13esb3Ckf53JDVimi1YT+i9q6IBlv3JyHLIm/brpbeYeiVT1DJPxU4M2Bu2JXKeJu4fy3eKtiQ0AQKqfMkvpUDWyMA4KFYlbAkUoVTzdF+YxJfJcpCNkTOAAoGIQJN1eB5jcLIdsD8Qlk1+A5OxQ='
    };

    var request = http.Request('POST', Uri.parse('https://iam.cloud.ibm.com/identity/token'));
    request.body = 'grant_type=urn:ibm:params:oauth:grant-type:apikey&apikey=$apiKey';
    request.headers.addAll(headers);

    try {
      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        var responseData = await response.stream.bytesToString();
        var jsonData = jsonDecode(responseData);
        return jsonData['access_token']; // إرجاع التوكن الجديد
      } else {
        print("Failed to refresh token: ${response.reasonPhrase}");
        return null;
      }
    } catch (e) {
      print("Error refreshing token: $e");
      return null;
    }
  }
}
