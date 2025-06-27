import 'dart:math'; 
import 'package:flutter/material.dart';
import 'package:gdsapplication/Models/User.dart';
import 'package:gdsapplication/Screens/settings/SettingsScreen.dart';

class UserDetailsScreen extends StatefulWidget {
  final User user;
  final int yesCount;
  final int noCount;
  final int Score;

  const UserDetailsScreen({super.key, required this.user, required this.yesCount, required this.noCount, required this.Score});

  @override
  _UserDetailsScreenState createState() => _UserDetailsScreenState();
}

class _UserDetailsScreenState extends State<UserDetailsScreen> {
  int _currentQuoteIndex = 0; 

  final List<String> quotes = [
    "The best way to predict the future is to create it. - Peter Drucker",
    "Life is 10% what happens to us and 90% how we react to it. - Charles R. Swindoll",
    "The only way to do great work is to love what you do. - Steve Jobs",
    "Change your thoughts and you change your world. - Norman Vincent Peale",
    "The purpose of our lives is to be happy. - Dalai Lama",
    "Success is not how high you have climbed, but how you make a positive difference to the world. - Roy T. Bennett",
    "Keep your face always toward the sunshine—and shadows will fall behind you. - Walt Whitman",
    "The best way out is always through. - Robert Frost"
  ];

 
  void _changeQuote() {
    setState(() {
      _currentQuoteIndex = Random().nextInt(quotes.length);
    });
  }

  @override
  Widget build(BuildContext context) {
    

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 90, 200, 239) ,
        title: Text("User Details - ${widget.user.Name}",
        style: const TextStyle(
      fontSize: 22, 
      fontWeight: FontWeight.bold,  
    )),
        
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SettingScreen()),
              );
            },
            icon: const Icon(Icons.settings),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text("Score: ${widget.Score}"),
            const SizedBox(height: 10),
            Text("Yes Answers: ${widget.yesCount}"),
            const SizedBox(height: 10),
            Text("No Answers: ${widget.noCount}"),
            if (widget.Score >= 5) ...[
              const SizedBox(height: 30),
              const Text(
                "You might be experiencing depression. Please consider seeking professional help.",
                style: TextStyle(color: Color.fromARGB(255, 241, 134, 126)),
              ),
            ],
            const SizedBox(height: 50),
           const Text(
  "Here's some quotes that might motivate you:",
  style: TextStyle(
    fontSize: 22,
    color: Color.fromARGB(255, 44, 154, 244),
    fontWeight: FontWeight.bold,
  ),
),
            const SizedBox(height: 60),
            Expanded(
              child: ListTile(
                title: Text(
                  quotes[_currentQuoteIndex],
                  style: const TextStyle(fontStyle: FontStyle.italic, fontSize: 26),
                ),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
  onPressed: _changeQuote,
  style: ElevatedButton.styleFrom(
    textStyle: const TextStyle(
      fontSize: 18, 
      fontWeight: FontWeight.bold, 
    ),
    padding: const EdgeInsets.symmetric(vertical: 15), // Adjust the button padding
  ),
  child: const Text("Change Quote"),
),
            const SizedBox(height: 20),
            TextButton(
              onPressed: () {
                // Implement navigation to support resources
              },
              child: const Text(
                "Need Help? Contact Support",
                style: TextStyle(fontSize: 18, color: Colors.blue),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
