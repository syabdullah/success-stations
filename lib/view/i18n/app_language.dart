
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:success_stations/view/i18n/lang/ar_lang.dart';
import 'package:success_stations/view/i18n/lang/en_dart.dart';


class LocalizationServices extends Translations {
  static const List<String> _rtlLanguages = <String>[
    'ar', // Arabic
    'fa', // Farsi
    'he', // Hebrew
    'ps', // Pashto
    'ur', // Urdu
  ];
  GetStorage box = GetStorage();
  /// The locale for which the values of this class's localized resources
  /// have been translated.
  
  @override
  // ignore: override_on_non_overriding_member
  TextDirection get textDirection => _textDirection;
  late TextDirection _textDirection;
// var loc = box.read(key)
  static final locale = Locale('en', '');

  // fallbackLocale saves the day when the locale gets in trouble
  static final fallbackLocale = Locale('en', '');

  // Supported languages
  // Needs to be same order with locales
  static final langs = [  
    'العربية',
    'English',
  ];

  static final locales = [
    Locale('ar', ''),
    Locale('en', ''),
  ];
  @override
  Map<String, Map<String, String>> get keys => {
    'ar': ar, // lang/en_us.dart
    'en': en,
  };
  void changeLocale(String lang) {
    if(lang.length == 2) {
     
      _getLangFromLocal(Locale(lang));
      _textDirection = _rtlLanguages.contains(lang) ? TextDirection.rtl : TextDirection.ltr;
       Get.updateLocale(Locale(lang));
        box.write('language', lang);
       
    }else{
      _textDirection = _rtlLanguages.contains(lang) ? TextDirection.rtl : TextDirection.ltr;
      Get.updateLocale(locale);
    }
  }
  _getLangFromLocal(loc) {
    for (int i = 0; i < locales.length; i++) {
      if (loc == locales[i]){
        box.write('lang', langs[i]);
       return langs[i];
      }
    }
  }
}