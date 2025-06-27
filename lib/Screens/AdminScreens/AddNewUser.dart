import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:gdsapplication/API/api_handler.dart';
import 'package:gdsapplication/Screens/AdminScreens/AdminScreen.dart';
import 'package:gdsapplication/Screens/settings/SettingsModel.dart';
import 'package:gdsapplication/Screens/settings/SettingsScreen.dart';
import 'package:provider/provider.dart';

class AddNewUserScreen extends StatefulWidget {
  const AddNewUserScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _AddNewUserScreen();
  }
}

class _AddNewUserScreen extends State<AddNewUserScreen> {
  final _formKey = GlobalKey<FormBuilderState>();
  bool _isLoading = false;
  String? _errorMessage;

  final ApiHandler _apiHandler = ApiHandler();
  
  get http => null;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 90, 200, 239) ,
        title: const Text("Add New User",
        style:  TextStyle(
      fontSize: 22, 
      fontWeight: FontWeight.bold, 
        )
        ),
      actions: [IconButton(onPressed: (){
      Navigator.push(
                context,
                MaterialPageRoute(builder: (context) =>const SettingScreen()),
              );
    }, icon: const Icon(Icons.settings))],),
      body: Consumer<SettingsModel>(builder: (context, value, child) => Padding(
        padding: const EdgeInsets.all(10),
        child: FormBuilder(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              FormBuilderTextField(
                name: 'name',
                decoration: const InputDecoration(labelText: 'Username'),
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(),
                ]),
              ),
              FormBuilderTextField(
                name: 'password',
                decoration: const InputDecoration(labelText: 'Password'),
                obscureText: true,
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(),
                ]),
              ),
              FormBuilderTextField(
                name: 'confirm_password',
                decoration:
                    const InputDecoration(labelText: 'Confirm Password'),
                obscureText: true,
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(),
                  (val) {
                    final password =
                        _formKey.currentState!.fields['password']!.value;
                    if (val != password) {
                      return 'Passwords do not match';
                    }
                    return null;
                  }
                ]),
              ),
              const SizedBox(height: 20),
              _isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : ElevatedButton(
                      onPressed: () {
                         if (_formKey.currentState!.saveAndValidate()) {
                          _register(_formKey.currentState!.value);
                        }
                      },
                      child: const Text('Add User'),
                    ),
              if (_errorMessage != null) ...[
                const SizedBox(height: 20),
                Text(
                  _errorMessage!,
                  style: const TextStyle(color: Colors.red),
                  textAlign: TextAlign.center,
                ),
              ],
            ],
          ),
        ),
      ),)
    );
  }
  Future<void> _register(Map<String, dynamic> value) async{
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });
    try{
        await _apiHandler.registerUser(
        value['name'], // Pass username
        value['password'], // Pass password
      );

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const AdminPage()),
      );

    }catch(e){
      setState(() {
        _errorMessage = 'Error occured: $e';
      });
    }finally {
      setState(() {
        _isLoading = false;
      });
    }
  }
}
