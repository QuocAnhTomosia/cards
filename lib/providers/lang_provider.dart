import 'package:flutter/material.dart';

class LanguageProvider with ChangeNotifier {
  List<String> languages = ["en,vi"];
  String current = "en";
  LanguageProvider({
    required this.current,
  });

  changeLanguage(String lang) {
    if (lang != current && languages.contains(current)) {
      current = lang;
      notifyListeners();
    }
  }
}
