import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SettingsModel with ChangeNotifier{
  bool _isDarkTheme = false;
  double _fontSize = 18;
  String _language = 'English';
  String _fontFamily = 'Roboto';

  bool get isDarkTheme => _isDarkTheme;
  double get fontSize => _fontSize;
  String get language => _language;
   String get fontFamily => _fontFamily;

  void toggleTheme(){
    _isDarkTheme = !_isDarkTheme;
    notifyListeners();
  }
  void setFontSize(double size){
    _fontSize = size;
    notifyListeners();
  }
  void setLanguage(String language){
    _language = language;
    notifyListeners();
  }
  void setFontFamily(String fontFamily) {
    _fontFamily = fontFamily;
    notifyListeners();
  }
TextTheme getTextTheme() {
    return TextTheme(
      bodyLarge: GoogleFonts.getFont(
        _fontFamily,
        fontSize: _fontSize,
      ),
      bodyMedium: GoogleFonts.getFont(
        _fontFamily,
        fontSize: _fontSize,
      ),
      // Add more text styles as needed
    );
  }

      ThemeData getThemeData() {
    return ThemeData(
      brightness: _isDarkTheme ? Brightness.dark : Brightness.light,
      textTheme: getTextTheme(),
    );
  }
}