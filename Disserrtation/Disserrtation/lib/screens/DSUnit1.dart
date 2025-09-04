//import 'dart:io';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:stela_app/constants/userDetails.dart';
import 'dart:async';

import '../constants/colors.dart';
import 'DSReportUnit1.dart';



class DSUnit1 extends StatefulWidget {
  @override
  _DSUnit1State createState() => _DSUnit1State();
}

class _DSUnit1State extends State<DSUnit1> {
  List<String> selectedOptions = ["", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", ""];
 bool resultButtonClicked = false; 
  final DatabaseReference databaseReference = FirebaseDatabase.instanceFor(
  app: Firebase.app(),
  databaseURL: "https://stela23-f9a52-default-rtdb.asia-southeast1.firebasedatabase.app",
).ref();

    late int marks;
  bool alreadySubmitted = false;
late DateTime pageVisitTime;
DateTime? pageVisitTimeSubmit;
late String userContent = '';
late String expectedOutput = _controller.text;
final TextEditingController _controller = TextEditingController(text: '''The manipulated value is: 45''');
 String universityName = '';
 String courseName = '';
 String examTypeName = '';
 String place = '';
 final TextEditingController controller = TextEditingController(text: '''x=5645\n''');
late String section2= controller.text;


List<String> correctAnswers = [
  // Data Structure Unit 1
  "O(log n)",                // Question 1
  "Worst-case time complexity", // Question 2
  "Worst case",              // Question 3
  "Insertion Sort",          // Question 4
  "Dynamic size",            // Question 5
  "The first node",          // Question 6
  "Merge Sort",              // Question 7
  "Insertion Sort",          // Question 8
  "Insertion",               // Question 9
  "Representing a graph using adjacency matrix", // Question 10
  "strcpy()",                // Question 11
  "To mark the end of the string", // Question 12
  "Change the head pointer to the new node and link the new node to the old head", // Question 13
  "The worst-case time complexity of an algorithm", // Question 14
  "O(n log n)",              // Question 15
  "Merge sort",              // Question 16
  "A stack follows LIFO, while a queue follows FIFO", // Question 17
  "Enqueue",                 // Question 18
  "By using one stack for enqueue operations and the other for dequeue operations", // Question 19
  "The first node"           // Question 20
];

List<List<String>> questions = [
  // Data Structure Unit 1
  [
    "What is the time complexity of binary search?",
    "O(n)", "O(log n)", "O(n^2)", "O(n log n)"
  ],
  [
    "What does the Big-O notation represent?",
    "Worst-case time complexity", "Best-case time complexity", 
    "Average-case time complexity", "All of the above"
  ],
  [
    "In which case is the algorithm's time complexity most important?",
    "Best case", "Worst case", "Average case", "All of the above"
  ],
  [
    "Which algorithm is the most efficient for sorting an already sorted list?",
    "Bubble Sort", "Insertion Sort", "Merge Sort", "Quick Sort"
  ],
  [
    "What is the primary advantage of using a linked list over an array?",
    "Easier access to elements", "Dynamic size", "Lower memory usage", "Faster searching"
  ],
  [
    "What does the ‘head’ pointer in a linked list point to?",
    "The last node", "The first node", "The middle node", "None of the above"
  ],
  [
    "Which sorting algorithm is stable?",
    "Quick Sort", "Merge Sort", "Heap Sort", "Selection Sort"
  ],
  [
    "Which of the following algorithms is best suited for sorting a small number of elements?",
    "Bubble Sort", "Selection Sort", "Insertion Sort", "Merge Sort"
  ],
  [
    "Which of the following operations is more complex in a multidimensional array than in a one-dimensional array?",
    "Accessing an element", "Insertion", "Deletion", "Traversal"
  ],
  [
    "Which of the following applications is best suited for using a 2D array?",
    "Implementing a stack.", "Representing a graph using adjacency matrix.", 
    "Implementing a queue.", "Representing a sparse matrix."
  ],
  [
    "In C, which of the following functions is used to copy a string?",
    "strcopy()", "strcpy()", "copy()", "strdup()"
  ],
  [
    "What is the purpose of the null character (\\0) in a C string?",
    "To indicate the start of the string", "To mark the end of the string", 
    "To separate characters", "To store spaces"
  ],
  [
    "In a singly linked list, how do you insert an element at the beginning of the list?",
    "Traverse to the end and add the new element.", 
    "Change the head pointer to the new node and link the new node to the old head.", 
    "Find the middle of the list and add the new element.", "Add the new element at the end."
  ],
  [
    "What does the Big-O notation describe?",
    "The best-case scenario of an algorithm", "The average-case time complexity of an algorithm", 
    "The worst-case time complexity of an algorithm", "The space complexity of an algorithm"
  ],
  [
    "What is the time complexity of merge sort?",
    "O(n)", "O(n log n)", "O(n^2)", "O(log n)"
  ],
  [
    "Which of the following is a divide-and-conquer algorithm?",
    "Insertion sort", "Merge sort", "Bubble sort", "Selection sort"
  ],
  [
    "What is the main difference between a stack and a queue?",
    "A stack follows FIFO, while a queue follows LIFO", 
    "A stack follows LIFO, while a queue follows FIFO", 
    "A stack allows random access, while a queue does not", 
    "A queue can be implemented using a linked list, while a stack cannot"
  ],
  [
    "Which operation is not typically supported by a stack?",
    "Push", "Pop", "Enqueue", "Peek"
  ],
  [
    "How can a queue be implemented using two stacks?",
    "By using one stack for enqueue operations and the other for dequeue operations", 
    "By using two stacks for alternating enqueue and dequeue operations", 
    "By using one stack for all operations", 
    "By using two stacks for holding intermediate results"
  ],
  [
    "In a circular linked list, the last node points to:",
    "The first node", "The last node itself", "Null", "The second node"
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

    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (!mounted) return;
      setState(() {
        if (_remainingTime > 0) {
          _remainingTime--;
        } else {
          timerExpired = true;
          _timer.cancel(); // Cancel the timer
          pageVisitTimeSubmit ??= DateTime.now();
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
    return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title: Text('Assessment'),
          backgroundColor: primaryBar,
          actions: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(timerExpired ? 'Time\'s up!' : 'Time Left: ${_formatTime(_remainingTime)}', style: TextStyle(color: Colors.white)),
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
                 pageVisitTimeSubmit = DateTime.now();
                 _showResultDialog();
                  },
                child: Text('Submit Test'),
              ),
              SizedBox(height: 20),
            ],
          ),


 Container(
                                                                    child:
                                                                        Column(
                                                                      children: [
                                                                        Container(
                                                                          width:
                                                                              50,
                                                                          margin:
                                                                              EdgeInsets.all(10),
                                                                          child:
                                                                              ClipRRect(
                                                                            borderRadius:
                                                                                BorderRadius.circular(150),
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
                                                                          onPressed:
                                                                              () {
                                                                            Navigator.push(
                                                                              context,
                                                                              MaterialPageRoute(builder: (context) => DSReportUnit1()),
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
  DataSnapshot snapshot = await databaseReference.child('DS-Unit1').child(enrollmentNo).get();
 
        Duration difference = (pageVisitTimeSubmit ?? DateTime.now()).difference(pageVisitTime);

int differenceInMinutes = difference.inMinutes;
int differenceInSeconds = difference.inSeconds%60;
  // If the name does not exist, show the result dialog and add the name with marks
  if (!snapshot.exists) {
    await databaseReference.child('DS-Unit1').child(enrollmentNo).set({
                  '1_Name': name,
                  '2_Total Marks': questions.length,
                  '3_Marks obtained': correctCount,
                  '4_Correct': correctCount,
                  '5_Incorrect': incorrectCount,
                  '6_Unattempted': unattemptedCount,
                   '7_Start time': pageVisitTime.toString(),
                      '8_End time': (pageVisitTimeSubmit ?? DateTime.now()).toString(),
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
                await databaseReference.child('DS-Unit1').child(enrollmentNo).set({
                  '1_Name': name,
                  '2_Total Marks': questions.length,
                  '3_Marks obtained': correctCount,
                  '4_Correct': correctCount,
                  '5_Incorrect': incorrectCount,
                  '6_Unattempted': unattemptedCount,
                   '7_Start time': pageVisitTime.toString(),
                      '8_End time': (pageVisitTimeSubmit ?? DateTime.now()).toString(),
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

