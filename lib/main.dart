import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gdsapplication/Screens/Login/Login_screen.dart';
import 'package:gdsapplication/Screens/settings/SettingsModel.dart';
import 'package:provider/provider.dart';

class DevHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context){
    return super.createHttpClient(context) .. badCertificateCallback = (X509Certificate cert, String host, int port) => true;
  }
}
void main() {
  HttpOverrides.global = DevHttpOverrides();
  runApp(ChangeNotifierProvider(
      create: (context) => SettingsModel(),
      child: const MyApp() ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
  
        return Consumer<SettingsModel>(
      builder: (context, settings, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: settings.getThemeData(),
          home: const LoginScreen(),
        );
      },
    );
  }
}
