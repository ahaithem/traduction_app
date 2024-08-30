import 'dart:convert';
import 'package:http/http.dart' as http;

class TranslationService {
  Future<String> translateText(
      String text, String sourceLang, String targetLang) async {
    final response = await http.get(
      Uri.parse(
          'https://api.mymemory.translated.net/get?q=$text&langpair=$sourceLang|$targetLang'),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data['responseData']['translatedText'] ?? 'No translation found';
    } else {
      return 'Error: ${response.statusCode} ${response.body}';
    }
  }
}
