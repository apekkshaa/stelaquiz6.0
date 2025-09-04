//import 'dart:io';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:stela_app/constants/userDetails.dart';
import 'dart:async';

import '../constants/colors.dart';
import 'SoftwareEngReportUnit1.dart';

class SEUnit1 extends StatefulWidget {
  @override
  _SEUnit1State createState() => _SEUnit1State();
}

class _SEUnit1State extends State<SEUnit1> {
  List<String> selectedOptions = ["", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", ""];
  bool resultButtonClicked = false;
  final DatabaseReference databaseReference = FirebaseDatabase.instanceFor(
    app: Firebase.app(),
    databaseURL: "https://stela23-f9a52-default-rtdb.asia-southeast1.firebasedatabase.app",
  ).ref();
  late int marks;
  bool alreadySubmitted = false;
  late DateTime pageVisitTime;
  late DateTime pageVisitTimeSubmit;
  late String userContent = '';
  late String expectedOutput = _controller.text;
  final TextEditingController _controller = TextEditingController(text: '''The manipulated value is: 45''');
  String universityName = '';
  String courseName = '';
  String examTypeName = '';
  String place = '';
  final TextEditingController controller = TextEditingController(text: '''x=5645\n''');
  late String section2 = controller.text;

  List<String> correctAnswers = [
    // Software Engineering Basics
    "Developing software that meets the needs of users with high quality and within constraints", // Question 1
    "System software acts as a platform for application software", // Question 2
    "Custom software", // Question 3
    "It deals primarily with abstract concepts and logical design", // Question 4
    "High cost", // Question 5
    "It enables the software to handle increased load without degradation in performance", // Question 6
    "To serve as an interface between different applications", // Question 7
    "System software", // Question 8
    "It helps in the maintenance and future enhancement of software", // Question 9
    "To confirm that the software meets its specifications", // Question 10
    // Software Challenges & Characteristics
    "Balancing time, cost, and quality in software projects", // Question 11
    "It helps in reducing development time and cost", // Question 12
    "Web browser", // Question 13
    "To provide a standardized solution to common design problems", // Question 14
    "It ensures that software can be easily understood and modified for future changes", // Question 15
    // Types of Software
    "Open-source software allows users to modify the source code, while commercial software typically does not", // Question 16
    "System software", // Question 17
    "Software specifically designed for controlling hardware devices", // Question 18
    "It is designed to perform tasks within a guaranteed time frame", // Question 19
    "Real-time software", // Question 20
  ];

  List<List<String>> questions = [
    // Software Engineering Basics
    [
      "Which of the following best describes the main goal of software engineering?",
      "Developing software with maximum efficiency",
      "Developing software that meets the needs of users with high quality and within constraints",
      "Writing code that is easy to maintain",
      "Reducing the cost of software development"
    ],
    [
      "What is the primary difference between system software and application software?",
      "System software is more user-friendly",
      "Application software manages hardware resources",
      "System software acts as a platform for application software",
      "Application software is mandatory for a computer to function"
    ],
    [
      "Which type of software is specifically designed to meet the needs of a particular customer or organization?",
      "Off-the-shelf software",
      "Open-source software",
      "Custom software",
      "System software"
    ],
    [
      "How does software engineering differ from traditional engineering disciplines?",
      "It focuses more on hardware development",
      "It has more established and widely accepted principles",
      "It deals primarily with abstract concepts and logical design",
      "It has fewer quality standards"
    ],
    ["Which of the following is NOT a characteristic of high-quality software?", "Efficiency", "Maintainability", "High cost", "Usability"],

    // Software Scalability, Middleware, and Documentation
    [
      "Why is scalability an important aspect of software?",
      "It ensures that software can be used on multiple devices",
      "It allows software to be easily updated",
      "It enables the software to handle increased load without degradation in performance",
      "It reduces the time required for software testing"
    ],
    [
      "What is the primary purpose of middleware in software systems?",
      "To serve as an interface between different applications",
      "To manage the user interface",
      "To develop system software",
      "To perform debugging"
    ],
    ["Which type of software is most likely to be affected by changes in hardware?", "System software", "Application software", "Custom software", "Middleware"],
    [
      "Why is documentation an essential component of software development?",
      "It reduces the cost of development",
      "It helps in the maintenance and future enhancement of software",
      "It replaces the need for testing",
      "It speeds up the coding process"
    ],
    [
      "What is the main goal of the software verification process?",
      "To ensure the software is free of bugs",
      "To confirm that the software meets its specifications",
      "To reduce the cost of software development",
      "To simplify the software development process"
    ],

    // Software Challenges and Reusability
    [
      "Which of the following is considered a primary challenge in software engineering?",
      "Minimizing hardware costs",
      "Balancing time, cost, and quality in software projects",
      "Increasing the speed of coding",
      "Avoiding the use of formal methods"
    ],
    [
      "Why is software reusability considered an important aspect in software engineering?",
      "It allows for easier debugging",
      "It helps in reducing development time and cost",
      "It eliminates the need for testing",
      "It improves user interface design"
    ],
    ["Which of the following is an example of application software?", "Operating system", "Database management system", "Web browser", "Compiler"],
    [
      "In software engineering, what is the main purpose of using design patterns?",
      "To increase code complexity",
      "To provide a standardized solution to common design problems",
      "To reduce documentation requirements",
      "To speed up the coding process"
    ],
    [
      "Why is maintainability a critical characteristic of software quality?",
      "It ensures that software can be easily understood and modified for future changes",
      "It reduces the initial cost of software development",
      "It improves the graphical user interface",
      "It decreases the time needed for coding"
    ],

    // Types of Software
    [
      "What is the primary difference between commercial software and open-source software?",
      "Commercial software is free to use, while open-source software is paid",
      "Open-source software allows users to modify the source code, while commercial software typically does not",
      "Commercial software is more secure than open-source software",
      "Open-source software is developed by large corporations"
    ],
    ["Which type of software is designed to operate and control the hardware directly?", "Application software", "System software", "Utility software", "Middleware"],
    [
      "Which of the following best describes embedded software?",
      "Software designed for personal computers",
      "Software that runs within larger software applications",
      "Software specifically designed for controlling hardware devices",
      "Software that is free and open-source"
    ],
    [
      "What is the main characteristic of real-time software?",
      "It is designed to perform tasks within a guaranteed time frame",
      "It can be modified by the user",
      "It is primarily used for entertainment",
      "It is only used in desktop applications"
    ],
    [
      "Which type of software would be most appropriate for a critical application like an air traffic control system?",
      "General-purpose software",
      "Real-time software",
      "Embedded software",
      "System software"
    ],
  ];

  late Timer _timer;
  bool timerExpired = false;

  int _remainingTime = 600; // 10 minutes in seconds

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    pageVisitTime = DateTime.now();
    super.initState();
print("Here i am");
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (_remainingTime > 0) {
          _remainingTime--;
        } else {
          timerExpired = true;
          _timer.cancel(); // Cancel the timer
          _showResultDialog(); // Automatically click the result button
        }
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    _timer.cancel(); // Cancel the timer when the widget is disposed
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title: Text('Assessment'),
          actions: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(timerExpired ? 'Time\'s up!' : 'Time Left: ${_formatTime(_remainingTime)}'),
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  padding: EdgeInsets.all(10),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: primaryButton,
                  ),
                  child: SelectableText(
                    'FILL BASIC DETAILS BEFORE SUBMISSION',
                    style: TextStyle(
                      fontSize: 16,
                      fontFamily: 'PTSerif',
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                //SizedBox(height: 20),

                // Add space before the WidgetSpan
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: 'University Name: ',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      WidgetSpan(
                        child: SizedBox(
                          width: 300, // Adjust the width as needed
                          child: TextField(
                            onChanged: (newValue) {
                              // Update the university name here
                              setState(() {
                                universityName = newValue;
                              });
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: 'Course Name: ',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      WidgetSpan(
                        child: SizedBox(
                          width: 300, // Adjust the width as needed
                          child: TextField(
                            onChanged: (newValue) {
                              // Update the university name here
                              setState(() {
                                courseName = newValue;
                              });
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: 'Exam Type(Practice/ Internal/ External): ',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      WidgetSpan(
                        child: SizedBox(
                          width: 300, // Adjust the width as needed
                          child: TextField(
                            onChanged: (newValue) {
                              // Update the university name here
                              setState(() {
                                examTypeName = newValue;
                              });
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: 'Place',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      WidgetSpan(
                        child: SizedBox(
                          width: 300, // Adjust the width as needed
                          child: TextField(
                            onChanged: (newValue) {
                              // Update the university name here
                              setState(() {
                                place = newValue;
                              });
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 20), // Add some space between the "University Name" and "AIM" sections
                Container(
                  padding: EdgeInsets.all(10),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: primaryButton,
                  ),
                  child: SelectableText(
                    'END SEM ASSESSMENT',
                    style: TextStyle(
                      fontSize: 16,
                      fontFamily: 'PTSerif',
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

                Column(
                  children: <Widget>[
                    SizedBox(height: 20),
                    for (int i = 0; i < questions.length; i++) _buildQuestionWidget(i + 1, questions[i]),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        pageVisitTimeSubmit = DateTime.now();  // Set this first
                        _showResultDialog();                  // Then call the dialog
                      },


                      child: Text('Submit Test'),
                    ),
                    SizedBox(height: 20),
                  ],
                ),

                Container(
                  child: Column(
                    children: [
                      Container(
                        width: 50,
                        margin: EdgeInsets.all(10),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(150),
                          /*child: Image(
                                          image: NetworkImage(
                                              'https://w7.pngwing.com/pngs/827/120/png-transparent-educational-assessment-test-computer-icons-risk-assessment-assess-angle-text-logo-thumbnail.png'),
                                        ),*/
                        ),
                      ),
                      TextButton(
                        child: Container(
                            width: double.infinity,
                            padding: EdgeInsets.symmetric(vertical: 5),
                            decoration: BoxDecoration(
                              color: primaryButton,
                              borderRadius: BorderRadius.circular(10),
                              //border: Border.all(width: 2.0, color: primaryBar),
                            ),
                            child: Text(
                              'Generate report',
                              style: TextStyle(
                                //color: Colors.white,
                                fontSize: 15, fontFamily: 'PTSerif-Bold', fontWeight: FontWeight.bold,
                                color: primaryBar,
                              ),
                              textAlign: TextAlign.center,
                            )),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => SEReportUnit1()),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildQuestionWidget(int questionNumber, List<String> question) {
    return Padding(
      padding: EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'Question $questionNumber: ${question[0]}',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10),
          for (int i = 1; i < question.length; i++)
            RadioListTile(
              title: Text(question[i]),
              value: question[i],
              groupValue: selectedOptions[questionNumber - 1],
              onChanged: (value) {
                setState(() {
                  selectedOptions[questionNumber - 1] = value.toString();
                });
              },
            ),
        ],
      ),
    );
  }

  void _showResultDialog() async {
    print("_showResultDialog is called");

    int correctCount = 0;
    int incorrectCount = 0;
    int unattemptedCount = 0;
    List<String> result = [];

    for (int i = 0; i < correctAnswers.length; i++) {
      if (selectedOptions[i] == correctAnswers[i]) {
        correctCount++;
        result.add('Correct');
      } else if (selectedOptions[i].isEmpty) {
        unattemptedCount++;
        result.add('Unattempted');
      } else {
        incorrectCount++;
        result.add('Incorrect');
      }
    }

    Duration difference = pageVisitTimeSubmit.difference(pageVisitTime);
    int differenceInMinutes = difference.inMinutes;
    int differenceInSeconds = difference.inSeconds % 60;

    try {

      DataSnapshot snapshot = await databaseReference.child('SE-Unit1').child(enrollmentNo).get();

      if (!snapshot.exists) {
        await databaseReference.child('SE-Unit1').child(enrollmentNo).set({
          '1_Name': name,
          '2_Total Marks': questions.length,
          '3_Marks obtained': correctCount,
          '4_Correct': correctCount,
          '5_Incorrect': incorrectCount,
          '6_Unattempted': unattemptedCount,
          '7_Start time': pageVisitTime.toString(),
          '8_End time': pageVisitTimeSubmit.toString(),
          '11_Duration': "$differenceInMinutes minutes $differenceInSeconds seconds",
          '12_University Name': universityName,
          '13_Course Name': courseName,
          '14_Exam Type': examTypeName,
          '15_Place': place,
        });

        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text(
                'RESULT',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Marks Obtained: $correctCount out of ${correctAnswers.length}',
                      style: TextStyle(color: Colors.black),
                    ),
                    SizedBox(height: 10),
                    ...List.generate(correctAnswers.length, (index) {
                      if (result[index] == 'Correct') {
                        return Text(
                          'Question ${index + 1}: ${result[index]}',
                          style: TextStyle(color: Colors.green),
                        );
                      } else if (result[index] == 'Unattempted') {
                        return Text.rich(
                          TextSpan(
                            children: [
                              TextSpan(
                                text: 'Question ${index + 1}: Unattempted, ',
                                style: TextStyle(color: Colors.grey),
                              ),
                              TextSpan(
                                text: 'Correct Answer: ${correctAnswers[index]}',
                                style: TextStyle(color: Colors.grey),
                              ),
                            ],
                          ),
                        );
                      } else {
                        return Text.rich(
                          TextSpan(
                            children: [
                              TextSpan(
                                text: 'Question ${index + 1}: Incorrect, ',
                                style: TextStyle(color: Colors.red),
                              ),
                              TextSpan(
                                text: 'Correct Answer: ${correctAnswers[index]}',
                                style: TextStyle(color: Colors.red),
                              ),
                            ],
                          ),
                        );
                      }
                    }),
                  ],
                ),
              ),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('OK'),
                ),
              ],
            );
          },
        );
      } else {
        // Already submitted dialog
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text(
                'ASSESSMENT ALREADY SUBMITTED',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              content: Text(
                'Your assessment has already been submitted. You cannot submit it again.',
              ),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('OK'),
                ),
              ],
            );
          },
        );
      }
    } catch (e) {
      print("Firebase Database error: $e");
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Error"),
            content: Text("There was an issue submitting your result. Please try again later."),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text("OK"),
              )
            ],
          );
        },
      );
    }
  }


  String _formatTime(int seconds) {
    Duration duration = Duration(seconds: seconds);
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String minutes = twoDigits(duration.inMinutes.remainder(60));
    String remainingSeconds = twoDigits(duration.inSeconds.remainder(60));
    return "$minutes:$remainingSeconds";
  }
}
