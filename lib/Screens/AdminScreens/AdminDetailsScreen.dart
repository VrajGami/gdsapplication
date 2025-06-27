import 'package:flutter/material.dart';
import 'package:gdsapplication/Models/User.dart';
import 'package:fl_chart/fl_chart.dart';

class AdminDetailsScreen extends StatelessWidget {
  final User user;
  AdminDetailsScreen({super.key, required this.user});

  // Hardcoded questions
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

  @override
  Widget build(BuildContext context) {
    final yesCount = user.answers.where((a) => a == 'Yes').length;
    final noCount = user.answers.length - yesCount;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 90, 200, 239) ,
        title: const Text('User Details',
        style: TextStyle(
      fontSize: 22, 
      fontWeight: FontWeight.bold,  
        )),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Name: ${user.Name}',
              
            ),
            const SizedBox(height: 8),
            Text(
              'Score: ${user.Score}',
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 8),
            Text(
              'Yes Count: $yesCount',
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 8),
            Text(
              'No Count: $noCount',
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Text(
                      'Answers:',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10),
                    ListView.builder(
                      shrinkWrap: true, // Added this line
                      physics:
                          const NeverScrollableScrollPhysics(), // Added this line
                      itemCount: user.answers.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 4.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(child: Text(
                                '${index + 1}. ${questions[index]}',
                                style: const TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                              ),
                              Text(
                                user.answers[index],
                                style: const TextStyle(fontSize: 16),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Text('Responses Chart:',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: PieChart(
                  PieChartData(
                    sections: _createPieChartSections(user),
                    centerSpaceRadius: 40,
                    sectionsSpace: 2,
                    borderData: FlBorderData(show: false),
                  ),
                ),
              ),
            ),
            if (user.Score >= 5)
              const Text(
                textAlign: TextAlign.center,
                'Stress Level: Depressed',
                style: TextStyle(
                    fontSize: 18,
                    color: Colors.red,
                    fontWeight: FontWeight.bold),
              )
            else
              const Text(
                'Stress Level: Normal',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 18,
                    color: Colors.green,
                    fontWeight: FontWeight.bold),
              ),
          ],
        ),
      ),
    );
  }

  List<PieChartSectionData> _createPieChartSections(User user) {
    final yesCount = user.answers.where((a) => a == 'No').length;
    final noCount = user.answers.length - yesCount;

    return [
      PieChartSectionData(
        color: Colors.green,
        value: yesCount.toDouble(),
        title: '', 
        radius: 50,
      ),
      PieChartSectionData(
        color: Colors.red,
        value: noCount.toDouble(),
        title: '', 
        radius: 50,
      ),
    ];
  }
}
