import 'package:flutter/material.dart';
import 'translation_service.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Translation App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String? _sourceLanguage;
  String? _targetLanguage;
  String _translatedText = '';
  final TextEditingController _controller = TextEditingController();
  final TranslationService _translationService = TranslationService();

  Future<void> _translate() async {
    final text = _controller.text;
    if (_sourceLanguage != null && _targetLanguage != null && text.isNotEmpty) {
      final result = await _translationService.translateText(
        text,
        _sourceLanguage!,
        _targetLanguage!,
      );
      setState(() {
        _translatedText = result;
      });
    } else {
      setState(() {
        _translatedText = 'Please enter text and select languages.';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    const availableLanguages = [
      'en', // English
      'fr', // French
      'es', // Spanish
      'de', // German
      'it', // Italian
      'pt', // Portuguese
    ];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Translation App'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              // Language dropdowns
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  // Source language dropdown
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    decoration: BoxDecoration(
                      color: Colors.blue[900],
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: DropdownButton<String>(
                      value: _sourceLanguage,
                      hint: const Text(
                        'Select source language',
                        style: TextStyle(color: Colors.white),
                      ),
                      dropdownColor: Colors.blue[900],
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16.0,
                      ),
                      underline: Container(
                        height: 2,
                        color: Colors.white,
                      ),
                      icon: const Icon(
                        Icons.arrow_drop_down,
                        color: Colors.white,
                      ),
                      items: availableLanguages.map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          _sourceLanguage = newValue;
                        });
                      },
                    ),
                  ),
                  Icon(
                    Icons.arrow_forward,
                    size: 50.0,
                    color: Colors.blue[900],
                  ),
                  // Target language dropdown
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    decoration: BoxDecoration(
                      color: Colors.blue[900],
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: DropdownButton<String>(
                      value: _targetLanguage,
                      hint: const Text(
                        'Select target language',
                        style: TextStyle(color: Colors.white),
                      ),
                      dropdownColor: Colors.blue[900],
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16.0,
                      ),
                      underline: Container(
                        height: 2,
                        color: Colors.white,
                      ),
                      icon: const Icon(
                        Icons.arrow_drop_down,
                        color: Colors.white,
                      ),
                      items: availableLanguages.map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          _targetLanguage = newValue;
                        });
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              // Text field for input
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                decoration: BoxDecoration(
                  color: Colors.blue[900],
                  borderRadius: BorderRadius.circular(10.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.3),
                      blurRadius: 6,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: TextField(
                  controller: _controller,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16.0,
                  ),
                  decoration: const InputDecoration(
                    hintText: 'Enter text',
                    hintStyle: TextStyle(color: Colors.white70),
                    border: InputBorder.none,
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              // Translate button
              Container(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: TextButton(
                    onPressed: _translate,
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.blue[900],
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20.0, vertical: 12.0),
                    ),
                    child: const Text(
                      'Translate',
                      style: TextStyle(fontSize: 16.0, color: Colors.white),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              // Display translated text
              Container(
                padding: const EdgeInsets.all(20.0),
                decoration: BoxDecoration(
                  color: Colors.blue[900],
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Text(
                  _translatedText,
                  style: const TextStyle(color: Colors.white, fontSize: 16.0),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
