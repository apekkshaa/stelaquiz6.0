//import 'dart:io';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:stela_app/constants/userDetails.dart';
import 'dart:async';
import 'package:stela_app/screens/ReportGenerationBasics.dart';
import 'package:stela_app/constants/colors.dart';
import 'dart:developer';

import 'ReportGenerationBasics.dart';



class OSassessmentpage extends StatefulWidget {
  @override
  _OSassessmentpageState createState() => _OSassessmentpageState();
}

class _OSassessmentpageState extends State<OSassessmentpage> {
  List<String> selectedOptions = ["", "", "", "", "", "", "", "", "", "", ""];
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
    // OS basics questions
    "Mutual Exclusion", // Question 1
    "6", // Question 2
    "20.25 ms", // Question 3
    "Both incur the same number of page faults", // Question 4
    "P: empty, Q: full, R: full, S: empty", // Question 5
    "P2", // Question 6
    "I, II and IV only", // Question 7
    "31", // Question 8
    "10", // Question 9
    "11", // Question 10
  ];

  List<List<String>> questions = [
    // OS basics questions
    [
      "Which of the following property of process synchronization is satisfied by a lock variable?",
      "Progress",
      "Bounded Waiting",
      "Mutual Exclusion",
      "None of these"
    ],
    [
      "A computer system uses a 57-bit virtual address and a multi-level tree-structured page table with L levels to translate virtual addresses to physical addresses. The page size is 4 KB, and each page table entry (PTE) uses 8 bytes. What is the value of L, the number of page table levels?",
      "3",
      "4",
      "5",
      "6"
    ],
    [
      "Processes P1, P2, P3, P4 arrive in order at times 0, 1, 2, and 8 ms with execution times 10, 13, 6, and 9 ms. If Shortest Remaining Time First (SRTF) scheduling is used, what is the average turnaround time?",
      "19.75 ms",
      "20.25 ms",
      "22 ms",
      "23.5 ms"
    ],
    [
      "Consider the following sequence of page references with 5 page frames: 3, 8, 2, 3, 9, 1, 6, 3, 8, 9, 3, 6, 2, 1, 3. Which of the following is true for FIFO and LRU page replacement policies?",
      "FIFO incurs 2 more page faults than LRU",
      "LRU incurs 2 more page faults than FIFO",
      "FIFO incurs 1 more page fault than LRU",
      "Both incur the same number of page faults"
    ],
    [
      "Consider the producer-consumer problem with a shared buffer of size N. Semaphores empty, full, and mutex are initialized as: empty = 0, full = N, mutex = 1. What is the correct match for P, Q, R, S?",
      "P: full, Q: full, R: empty, S: empty",
      "P: empty, Q: empty, R: full, S: full",
      "P: full, Q: empty, R: empty, S: full",
      "P: empty, Q: full, R: full, S: empty"
    ],
    [
      "A single processor system has 3 resource types X, Y, Z (5 units each). Which of these processes will finish LAST?",
      "P0",
      "P1",
      "P2",
      "Deadlock"
    ],
    [
      "Consider the following statements:\nI. A running process can move to ready state.\nII. A ready process can move to running state.\nIII. A blocked process can move to running state.\nIV. A blocked process can move to ready state.\nWhich of the above statements are TRUE?",
      "I, II and III only",
      "II and III only",
      "I, II and IV only",
      "I, II, III and IV only"
    ],
    [
      "How many child processes are created by the following C program?\nfor (i = 0; i < 10; i++)\nif (i % 2 == 0) fork();",
      "10",
      "16",
      "31",
      "32"
    ],
    [
      "Disk request sequence: 45, 20, 90, 10, 50, 60, 80, 25, 70. Initial head on track 50. SSTF and SCAN (towards 100) are used. What is the additional distance SSTF traverses compared to SCAN?",
      "0",
      "10",
      "15",
      "20"
    ],
    [
      "Three processes A, B, C have peak demands of 3, 4, and 6. What is the minimum number of resources (m) needed to avoid deadlock?",
      "10",
      "11",
      "12",
      "13"
    ],
  ];


  late Timer _timer;
  bool timerExpired = false;

  int _remainingTime = 1200; // 20 minutes in seconds

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    pageVisitTime = DateTime.now();
    super.initState();

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
            /*child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                padding: EdgeInsets.all(10),
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: primaryButton,
                ),

   child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      "Enter Text:",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 10), // Add some space between text and text field
                    TextField(
                      decoration: InputDecoration(
                        border: InputBorder.none,
                      ),
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 20), // Add some space between the text field and "AIM" text
              Container(
                padding: EdgeInsets.all(10),
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: primaryButton,
                ),*/

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
                    'PRACTICE QUIZ',
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
                        log("here i am ");
                        _showResultDialog();
                        pageVisitTimeSubmit = DateTime.now();
                      },
                      child: Text('Result'),
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
                            MaterialPageRoute(builder: (context) => PdfPageOS()),
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

    // Check if the name exists in the database
    DataSnapshot snapshot = await databaseReference.child('OS').child(enrollmentNo).get();

    Duration difference = pageVisitTimeSubmit.difference(pageVisitTime);

    int differenceInMinutes = difference.inMinutes;
    int differenceInSeconds = difference.inSeconds % 60;
    // If the name does not exist, show the result dialog and add the name with marks
    //if (!snapshot.exists) {
    await databaseReference.child('OS').child(enrollmentNo).set({
      '1_Name': name,
      '2_Total Marks': questions.length,
      '3_Marks obtained': correctCount,
      '4_Correct': correctCount,
      '5_Incorrect': incorrectCount,
      '6_Unattempted': unattemptedCount,
      '7_Start time': pageVisitTime.toString(),
      '8_End time': pageVisitTimeSubmit.toString(),
      '11_Duration': differenceInMinutes.toString() + " minutes " + differenceInSeconds.toString() + " seconds",
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
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Marks Obtained: $correctCount out of ${correctAnswers.length}',
                style: TextStyle(color: Colors.black),
              ),
              SizedBox(height: 10),
              ...List.generate(
                correctAnswers.length,
                (index) {
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
                },
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () async {
                // Add the name with marks to the database
                await databaseReference.child('OS').child(enrollmentNo).set({
                  '1_Name': name,
                  '2_Total Marks': questions.length,
                  '3_Marks obtained': correctCount,
                  '4_Correct': correctCount,
                  '5_Incorrect': incorrectCount,
                  '6_Unattempted': unattemptedCount,
                  '7_Start time': pageVisitTime.toString(),
                  '8_End time': pageVisitTimeSubmit.toString(),
                  '11_Duration': differenceInMinutes.toString() + " minutes " + differenceInSeconds.toString() + " seconds",
                  '12_University Name': universityName,
                  '13_Course Name': courseName,
                  '14_Exam Type': examTypeName,
                  '15_Place': place,
                });
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
    /*} else {
    // If the name already exists, show a message indicating that the assessment has already been submitted
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'ASSESSMENT ALREADY SUBMITTED',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
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
  }*/
    // Your result dialog implementation
  }

  String _formatTime(int seconds) {
    Duration duration = Duration(seconds: seconds);
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String minutes = twoDigits(duration.inMinutes.remainder(60));
    String remainingSeconds = twoDigits(duration.inSeconds.remainder(60));
    return "$minutes:$remainingSeconds";
  }
}

/*@override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Assessment'),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              SizedBox(height: 20),
              for (int i = 0; i < questions.length; i++)
                _buildQuestionWidget(i + 1, questions[i]),
              SizedBox(height: 20),
              ElevatedButton(
                //onPressed: resultButtonClicked ? null : _showResultDialog,
                onPressed: _showResultDialog,
                child: Text('Result'),
              ),
              SizedBox(height: 20),
            ],
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

  // Check if the name exists in the database
  DataSnapshot snapshot = await databaseReference.child('COA').child(enrollmentNo).get();

  // If the name does not exist, show the result dialog and add the name with marks
  if (!snapshot.exists) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'RESULT',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Marks Obtained: $correctCount out of ${correctAnswers.length}',
                style: TextStyle(color: Colors.black),
              ),
              SizedBox(height: 10),
              ...List.generate(
                correctAnswers.length,
                (index) {
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
                },
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () async {
                // Add the name with marks to the database
                await databaseReference.child('COA').child(enrollmentNo).set({
                  '1_Name': name,
                  '2_Total Marks': questions.length,
                  '3_Marks obtained': correctCount,
                  '4_Correct': correctCount,
                  '5_Incorrect': incorrectCount,
                  '6_Unattempted': unattemptedCount,

                });
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  } else {
    // If the name already exists, show a message indicating that the assessment has already been submitted
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'ASSESSMENT ALREADY SUBMITTED',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
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
}


}*/

/*Map<String, dynamic>? data, document;
var userDetails;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(AssessmentPage());
}

class AssessmentPage extends StatefulWidget {
  @override
  _AssessmentPageState createState() => _AssessmentPageState();
}

class _AssessmentPageState extends State<AssessmentPage> {
  List<String> selectedOptions = ["", "", "", "", ""];
  bool resultButtonClicked = false; // To track if result button is clicked
  final databaseReference = FirebaseDatabase.instance.ref(); // Firebase database reference

  // Define the correct answers for each question
  List<String> correctAnswers = ["Paris", "William Shakespeare", "H2O", "Mars", "Leonardo da Vinci"];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Assessment'),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              SizedBox(height: 20),
              _buildQuestionWidget(1),
              _buildQuestionWidget(2),
              _buildQuestionWidget(3),
              _buildQuestionWidget(4),
              _buildQuestionWidget(5),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: resultButtonClicked ? null : _showResultDialog, // Disable button after first click
                child: Text('Result'),
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildQuestionWidget(int questionNumber) {
    late String question;
    late List<String> options;

    // Define questions and options based on questionNumber
    switch (questionNumber) {
      case 1:
        question = 'What is the capital of France?';
        options = ['Paris', 'Berlin', 'London', 'Rome'];
        break;
      case 2:
        question = 'Who wrote "Romeo and Juliet"?';
        options = ['William Shakespeare', 'Jane Austen', 'Charles Dickens', 'Mark Twain'];
        break;
      case 3:
        question = 'What is the chemical symbol for water?';
        options = ['H2O', 'CO2', 'NaCl', 'O2'];
        break;
      case 4:
        question = 'Which planet is known as the Red Planet?';
        options = ['Mars', 'Venus', 'Mercury', 'Jupiter'];
        break;
      case 5:
        question = 'Who painted the Mona Lisa?';
        options = ['Leonardo da Vinci', 'Pablo Picasso', 'Vincent van Gogh', 'Michelangelo'];
        break;
      default:
        question = 'Question';
        options = ['Option A', 'Option B', 'Option C', 'Option D'];
    }

    return Padding(
      padding: EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'Question $questionNumber: $question',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10),
          for (var option in options)
            RadioListTile(
              title: Text(option),
              value: option,
              groupValue: selectedOptions[questionNumber - 1],
              onChanged: (value) {
                setState(() {
                  selectedOptions[questionNumber - 1] = value.toString(); // Ensure value is converted to String
                });
              },
            ),
        ],
      ),
    );
  }

  void _showResultDialog() async {
    int correctCount = 0;
    List<String> result = [];


    for (int i = 0; i < correctAnswers.length; i++) {
  if (selectedOptions[i] == correctAnswers[i]) {
    correctCount++;
    result.add('Correct');
  } else if (selectedOptions[i] == null || selectedOptions[i].isEmpty) {
    result.add('Unattempted, Correct Answer: ${correctAnswers[i]}');
  } else {
    result.add('Incorrect, Correct Answer: ${correctAnswers[i]}');
  }
}



    // Upload marks to Firebase
    databaseReference.child(name).get().then((DataSnapshot snapshot) {
  if (!snapshot.exists) {
    // Name does not exist in the database, so we add it
    return databaseReference.child(name).set({
      'marks': correctCount,
    });
  }
}).catchError((error) {
  print('Error fetching data: $error');
});





    setState(() {
      resultButtonClicked = true;
    });

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'RESULT',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: List.generate(
  correctAnswers.length,
  (index) {
    if (result[index] == 'Correct') {
      return Text(
        'Question ${index + 1}: ${result[index]}',
        style: TextStyle(color: Colors.green),
      );
    } else if (result[index] == 'Unattempted') {
      return Text(
        'Question ${index + 1}: Unattempted, Correct Answer: ${correctAnswers[index]}',
        style: TextStyle(color: Colors.yellow),
      );
    } else {
      return Text(
        'Question ${index + 1}: Incorrect, Correct Answer: ${correctAnswers[index]}',
        style: TextStyle(color: Colors.red),
      );
    }
  }
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
  }
}
*/

/*import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:stela_app/constants/colors.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:stela_app/constants/experimentDesc.dart';
import 'package:stela_app/screens/BasicsexperimentList.dart'
    as BasicsexperimentList;
import 'package:stela_app/screens/NumpyexperimentList copy.dart';
import 'package:stela_app/screens/MatplotlibexperimentList copy.dart';
import 'package:stela_app/screens/PandasexperimentList copy.dart';
import 'package:stela_app/screens/SeabornexperimentList copy.dart';
import 'package:stela_app/screens/TensorflowexperimentList copy.dart';
import 'package:stela_app/screens/SklearnexperimentList copy.dart';
import 'package:stela_app/screens/KerasexperimentList copy.dart';
import 'package:stela_app/screens/PytorchexperimentList copy.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:stela_app/constants/userDetails.dart';

import 'package:flutter/material.dart';

void main() {
  runApp(AssessmentPage());
}

class AssessmentPage extends StatefulWidget {
  @override
  _AssessmentPageState createState() => _AssessmentPageState();
}

class _AssessmentPageState extends State<AssessmentPage> {
  List<String> selectedOptions = ["", "", "", "", ""];

  // Define the correct answers for each question
  List<String> correctAnswers = ["Paris", "Option B", "Option C", "Option D", "Option A"];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Assessment'),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              SizedBox(height: 20),
              _buildQuestionWidget(1),
              _buildQuestionWidget(2),
              _buildQuestionWidget(3),
              _buildQuestionWidget(4),
              _buildQuestionWidget(5),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _showResultDialog,
                child: Text('Result'),
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildQuestionWidget(int questionNumber) {
  late String question;
  late List<String> options;

  // Define questions and options based on questionNumber
  switch (questionNumber) {
    case 1:
      question = 'What is the capital of France?';
      options = ['Paris', 'Berlin', 'London', 'Rome'];
      break;
    case 2:
      question = 'Who wrote "Romeo and Juliet"?';
      options = ['William Shakespeare', 'Jane Austen', 'Charles Dickens', 'Mark Twain'];
      break;
    case 3:
      question = 'What is the chemical symbol for water?';
      options = ['H2O', 'CO2', 'NaCl', 'O2'];
      break;
    case 4:
      question = 'Which planet is known as the Red Planet?';
      options = ['Mars', 'Venus', 'Mercury', 'Jupiter'];
      break;
    case 5:
      question = 'Who painted the Mona Lisa?';
      options = ['Leonardo da Vinci', 'Pablo Picasso', 'Vincent van Gogh', 'Michelangelo'];
      break;
    default:
      question = 'Question';
      options = ['Option A', 'Option B', 'Option C', 'Option D'];
  }

  return Padding(
    padding: EdgeInsets.all(10),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Question $questionNumber: $question',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 10),
        for (var option in options)
          RadioListTile(
            title: Text(option),
            value: option,
            groupValue: selectedOptions[questionNumber - 1],
            onChanged: (value) {
              setState(() {
                selectedOptions[questionNumber - 1] = value.toString(); // Ensure value is converted to String
              });
            },
          ),
      ],
    ),
  );
}



  void _showResultDialog() {
    int correctCount = 0;
    for (int i = 0; i < correctAnswers.length; i++) {
      if (selectedOptions[i] == correctAnswers[i]) {
        correctCount++;
      }
    }

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
          'RESULT',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),

          content: Text('Marks: $correctCount/ ${correctAnswers.length}'),
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
}*/
