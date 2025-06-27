import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:gdsapplication/Models/User.dart';

class ApiHandler {
   static const String baseUri = "http://10.0.2.2:5000/api/Users";

  Future<List<User>> getUserData() async {
    List<User> data = [];
    final uri = Uri.parse(baseUri);

    try {
      final response = await http.get(
        uri,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

      if (response.statusCode >= 200 && response.statusCode <= 299) {
        final List<dynamic> jsonData = json.decode(response.body);
        data = jsonData.map((json) => User.fromJson(json)).toList();
      } else {
        // Handle non-success status codes
      }
    } catch (e) {
      // Handle any errors that occurred during the request
    }

    return data;
  }

 Future<User> registerUser(String name, String password) async {
    final response = await http.post(
      Uri.parse('$baseUri/register'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      // to register the default value
      body: jsonEncode(<String, dynamic>{
        'name': name,
        'password': password,
        'role' : "User",
        'q1' : true,
        'q2' : true,
        'q3' : true,
        'q4' : true,
        'q5' : true,
        'q6' : true,
        'q7' : true,
        'q8' : true,
        'q9' : true,
        'q10' : true,
        'q11' : true,
        'q12' : true,
        'q13' : true,
        'q14' : true,
        'q15' : true,
        'score' : 0,
      }),
    );

    if (response.statusCode == 201) {
      return User.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to register user');
    }
  }

  Future<List<User>> getUsers() async {
    List<User> users = [];
    final uri = Uri.parse(baseUri);

    try {
      final response = await http.get(
        uri,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

      if (response.statusCode == 200) {
        final List<dynamic> jsonData = json.decode(response.body);
        users = jsonData.map((json) => User.fromJson(json)).toList();
      } else {
        // Handle non-success status codes
      }
    } catch (e) {
      // Handle any errors that occurred during the request
    }

    return users;
  }

  Future<void> deleteUser(int id) async {
    final uri = Uri.parse('$baseUri/$id');
    try {
      final response = await http.delete(
        uri,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

      if (response.statusCode != 204) {
      }
    } catch (e) {
    }
  }
   // Add the updateUser method
  Future<String> updateUser(User user, Map<String, dynamic> answersData) async {
    final uri = Uri.parse('$baseUri/${user.Id}');

    try {
      final response = await http.put(
        uri,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(answersData),
      );


      if (response.statusCode == 200 || response.statusCode == 204) {
        return "success";
        
      } else {
        return "'Failed to update user: ${response.statusCode} - ${response.reasonPhrase}'";
      }
    } catch (e) {
      return 'Error occurred: $e';
    }
  }
}
