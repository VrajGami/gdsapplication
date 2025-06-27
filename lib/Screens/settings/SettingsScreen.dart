import 'package:flutter/material.dart';
import 'package:gdsapplication/Screens/settings/SettingsModel.dart';
import 'package:provider/provider.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _SettingsScreenState();
  }
}

class _SettingsScreenState extends State<SettingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 90, 200, 239) ,
          title: const Text('Settings',
          style: TextStyle(
      fontSize: 22, 
      fontWeight: FontWeight.bold,  
        )),
        ),
        body: Consumer<SettingsModel>(builder: (context, settings, child) {
          return Column(
            children: [
              ListTile(
                title: const Text('Dark Theme'),
                trailing: Switch(
                  value: settings.isDarkTheme,
                  onChanged: (value) {
                    settings.toggleTheme();
                  },
                ),
              ),
              ListTile(
                title: const Text('Font Size'),
                subtitle: Slider(
                  min: 10.0,
                  max: 30.0,
                  value: settings.fontSize,
                  onChanged: (value) {
                    settings.setFontSize(value);
                  },
                ),
              ),
              ListTile(
                title: const Text('Language'),
                trailing: DropdownButton<String>(
                  value: settings.language,
                  onChanged: (value) {
                    if (value != null) {
                      settings.setLanguage(value);
                    }
                  },
                  items: <String>['English', 'Spanish', 'French', 'German']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              )
            ],
          );
        }));
  }
}
