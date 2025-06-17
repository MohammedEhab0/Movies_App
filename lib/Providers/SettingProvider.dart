import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingProviders extends ChangeNotifier {
  String currentLanguage = 'en';


  SettingProviders() {
    loadSettings();
  }

  Future<void> loadSettings() async {
    SharedPreferences sharedPreference = await SharedPreferences.getInstance();

    // Load saved language
    String? savedLanguage = sharedPreference.getString('currentLanguage');
    if (savedLanguage != null) {
      currentLanguage = savedLanguage;
    }


    notifyListeners(); // Notify listeners after loading settings
  }

  void changeLanguage(BuildContext context, String newLanguage) async {
    SharedPreferences sharedPreference = await SharedPreferences.getInstance();
    if (newLanguage == currentLanguage) return;

    await sharedPreference.setString('currentLanguage', newLanguage);
    currentLanguage = newLanguage;
    context.setLocale(Locale(currentLanguage));
    notifyListeners();
  }


}