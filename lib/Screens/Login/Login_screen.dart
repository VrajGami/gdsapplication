import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:gdsapplication/Models/User.dart';
import 'package:gdsapplication/API/api_handler.dart';
import 'package:gdsapplication/Screens/Login/RegisterScreen.dart';
import 'package:gdsapplication/Screens/AdminScreens/AdminScreen.dart';
import 'package:gdsapplication/Screens/UserScreens/MainPage.dart';
import 'package:gdsapplication/Screens/settings/SettingsModel.dart';
import 'package:gdsapplication/Screens/settings/SettingsScreen.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget{
  const LoginScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _LoginScreenState();
  }

}
class _LoginScreenState extends State<LoginScreen>{
final _formKey = GlobalKey<FormBuilderState>();
 bool _isLoading = false;
String? _errorMessage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     
      appBar: AppBar(
         backgroundColor: const Color.fromARGB(255, 90, 200, 239) ,
        title: const Text("Login",
      
      style:  TextStyle(
      fontSize: 22, 
      fontWeight: FontWeight.bold,  
        )),
      actions: [IconButton(onPressed: (){
      Navigator.push(
                context,
                MaterialPageRoute(builder: (context) =>const SettingScreen()),
              );
    }, icon: const Icon(Icons.settings))],), 
      body:Consumer<SettingsModel>(builder: (BuildContext context, SettingsModel value, Widget? child) { 
        return  Padding(padding: const EdgeInsets.all(16),
      child: FormBuilder(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
              FormBuilderTextField(
                name: 'name',
                decoration: const InputDecoration(labelText: 'Username'),
                validator : FormBuilderValidators.compose([
                  FormBuilderValidators.required(),
                ])
              ),
              FormBuilderTextField(
                name: 'password',
                decoration: const InputDecoration(labelText: 'Password'),
                obscureText: true,
                validator:  FormBuilderValidators.compose([
                  FormBuilderValidators.required(),
                ]),
              ),
              const SizedBox(height: 20,),
             _isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : ElevatedButton(
                      onPressed: () {
                         if (_formKey.currentState!.saveAndValidate()) {
                          _login(_formKey.currentState!.value);
                        }
                      },
                      child: const Text('Login'),),
              if(_errorMessage != null) ... [
                const SizedBox(height: 20,),
                Text(_errorMessage!,
                style: const TextStyle(color: Colors.red),textAlign: TextAlign.center,)
              ],
               const Spacer(),
               const SizedBox(height: 10,),
                ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const RegisterScreen()),
                  );
                },
                child: const Text("Register"),
              ),
          ],
        
        ),),);
       },)  
    );
  
  }
  Future<void> _login(Map<String,dynamic> value)async{
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });
    try{
      final response = await http.post(Uri.parse('${ApiHandler.baseUri}/login'),
      headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(value),);
         if (response.statusCode == 200) {
        final user = User.fromJson(jsonDecode(response.body));
        Navigator.pushReplacement(context,
         MaterialPageRoute(builder: (context) => user.Role == 'admin' ?const  AdminPage() : MainPage(user: user,)));
      } else {
        setState(() {
          _errorMessage = 'Invalid username or password';
        });
      }
    }catch(e){
  setState(() {
        _errorMessage = 'Error occurred: $e';
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
  }
}
}