import 'package:flutter/material.dart';
import 'package:gdsapplication/API/api_handler.dart';
import 'package:gdsapplication/Screens/Login/Login_screen.dart';
import 'package:gdsapplication/Models/User.dart';
import 'package:gdsapplication/Screens/UserScreens/UserDetailScreen.dart';
import 'package:gdsapplication/Screens/settings/SettingsModel.dart';
import 'package:gdsapplication/Screens/settings/SettingsScreen.dart';
import 'package:provider/provider.dart';

class MainPage extends StatefulWidget {
  final User user;

  const MainPage({super.key, required this.user});

  @override
  State<StatefulWidget> createState() {
    return _MainPageState();
  }
}

class _MainPageState extends State<MainPage> {
  final List<String> questions = [
    "Are you basically satisfied with your life?",
    "Have you dropped many of your activities and interests?",
    "Do you feel that your life is empty?",
    "Do you often get bored?",
    "Are you in good spirits most of the time?",
    "Are you afraid that something bad is going to happen to you?",
    "Do you feel happy most of the time?",
    "Do you often feel helpless?",
    "Do you prefer to stay at home, rather than going out and doing things?",
    "Do you feel that you have more problems with memory than most?",
    "Do you think it is wonderful to be alive now?",
    "Do you feel pretty worthless the way you are now?",
    "Do you feel full of energy?",
    "Do you feel that your situation is hopeless?",
    "Do you think that most people are better off than yourself?",
  ];
  List<String> answers = List.filled(15, "");

  Future<void> submitAnswers() async {
   int score = 0;
    score += answers[0] == 'No' ? 1 : 0;   // Q1: no
    score += answers[1] == 'Yes' ? 1 : 0;  // Q2: yes
    score += answers[2] == 'Yes' ? 1 : 0;  // Q3: yes
    score += answers[3] == 'Yes' ? 1 : 0;  // Q4: yes
    score += answers[4] == 'No' ? 1 : 0;   // Q5: no
    score += answers[5] == 'Yes' ? 1 : 0;  // Q6: yes
    score += answers[6] == 'No' ? 1 : 0;   // Q7: no
    score += answers[7] == 'Yes' ? 1 : 0;  // Q8: yes
    score += answers[8] == 'Yes' ? 1 : 0;  // Q9: yes
    score += answers[9] == 'Yes' ? 1 : 0;  // Q10: yes
    score += answers[10] == 'No' ? 1 : 0;  // Q11: no
    score += answers[11] == 'Yes' ? 1 : 0; // Q12: yes
    score += answers[12] == 'No' ? 1 : 0;  // Q13: no
    score += answers[13] == 'Yes' ? 1 : 0; // Q14: yes
    score += answers[14] == 'Yes' ? 1 : 0; // Q15: yes
    Map<String, dynamic> answersData = {
      'id': widget.user.Id,
      'name': widget.user.Name,
      'password': widget.user.Password,
      'role': "User",
      'q1': answers[0] == 'Yes',
      'q2': answers[1] == 'Yes',
      'q3': answers[2] == 'Yes',
      'q4': answers[3] == 'Yes',
      'q5': answers[4] == 'Yes',
      'q6': answers[5] == 'Yes',
      'q7': answers[6] == 'Yes',
      'q8': answers[7] == 'Yes',
      'q9': answers[8] == 'Yes',
      'q10': answers[9] == 'Yes',
      'q11': answers[10] == 'Yes',
      'q12': answers[11] == 'Yes',
      'q13': answers[12] == 'Yes',
      'q14': answers[13] == 'Yes',
      'q15': answers[14] == 'Yes',
      'score': widget.user.Score,
    };
    final apiHandler = ApiHandler();

    try {
      String s = await apiHandler.updateUser(widget.user, answersData);
      if (s == "success") {
        final yesCount =answers.where((a) => a == 'Yes').length;
        final noCount = answers.length - yesCount;
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => UserDetailsScreen(user: widget.user, yesCount: yesCount,noCount: noCount,Score: score,)),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(s)),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error occurred: $e')),
      );
    }
  }



// Modify the _speak method
Future<void> _speak(String text) async {
 
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 90, 200, 239) ,
        title: Text("Hello, ${widget.user.Name}",
         style: const TextStyle(
      fontSize: 22, 
      fontWeight: FontWeight.bold,  
    ),),
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
          IconButton(
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) =>const LoginScreen()),
              );
            },
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: Consumer<SettingsModel>(
        builder: (context, value, child) => Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                "Please answer the following questions to the best of your ability:",
                style: TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 10),
              Expanded(
                child: ListView.builder(
                  itemCount: questions.length,
                  itemBuilder: (context, index) {
                    return Card(
                      margin: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Expanded(child: Text(questions[index])),
                                IconButton(
                                  icon: const Icon(Icons.volume_up),
                                  onPressed: () => _speak(questions[index]),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: ElevatedButton(
                                    onPressed: () {
                                      setState(() {
                                        answers[index] = 'Yes';
                                      });
                                    },
                                    style: ButtonStyle(
                                      backgroundColor: MaterialStateProperty.all(
                                        answers[index] == 'Yes' ? const Color.fromARGB(255, 32, 173, 224) : const Color.fromARGB(255, 211, 211, 211),
                                      ),
                                    ),
                                    child: const Text('Yes', style: TextStyle(color:Colors.black ),),
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: ElevatedButton(
                                    onPressed: () {
                                      setState(() {
                                        answers[index] = 'No';
                                      });
                                    },
                                    style: ButtonStyle(
                                      backgroundColor: MaterialStateProperty.all(
                                        answers[index] == 'No' ? const Color.fromARGB(255, 32, 173, 224) : const Color.fromARGB(255, 211, 211, 211),
                                      ),
                                    ),
                                    child: const Text('No',style: TextStyle(color:Colors.black ),),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
               const SizedBox(height: 20),
              const Text(
                '"The greatest glory in living lies not in never falling, but in rising every time we fall." - Nelson Mandela',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, fontStyle: FontStyle.italic),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: answers.contains("") ? null : submitAnswers,
                child: const Text("Submit"),
              ),
              const SizedBox(height: 10),
              TextButton(
                onPressed: () {
                  // Implement navigation to support resources
                },
                child: const Text(
                  "Need Help? Contact Support",
                  style: TextStyle(fontSize: 16, color: Colors.blue),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


