//import 'dart:io';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:stela_app/constants/userDetails.dart';
import 'package:stela_app/screens/DSReportUnit3.dart';
import 'dart:async';

import '../constants/colors.dart';
import 'DSReportUnit1.dart';



class DSUnit3 extends StatefulWidget {
  @override
  _DSUnit3State createState() => _DSUnit3State();
}

class _DSUnit3State extends State<DSUnit3> {
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
late String section2= controller.text;


List<String> correctAnswers = [
  // Data Structures - Unit 3
  "Preorder",  // Question 1
  "The value of nodes",  // Question 2
  "O(log n)",  // Question 3
  "Inorder",  // Question 4
  "O(log n)",  // Question 5
  "Rotation",  // Question 6
  "Efficient operations with large amounts of data",  // Question 7
  "Level-order",  // Question 8
  "Using index-based positioning",  // Question 9
  "Priority queue implementation",  // Question 10
  "Binary search",  // Question 11
  "O(n^2)",  // Question 12
  "Merge sort",  // Question 13
  "O(n log n)",  // Question 14
  "Counting sort",  // Question 15
  "Quick sort",  // Question 16
  "Sorting elements with a known range",  // Question 17
  "External sorting involves disk-based storage",  // Question 18
  "O(n)",  // Question 19
  "O(log n)",  // Question 20
];

List<List<String>> questions = [
  // Data Structures - Unit 3
  [
    "Which traversal technique visits the root node before the left and right subtrees?",
    "Inorder", "Preorder", "Postorder", "Level-order"
  ],
  [
    "In a binary search tree (BST), which property is used to determine the position of nodes?",
    "The depth of nodes", "The color of nodes", "The value of nodes", "The height of nodes"
  ],
  [
    "What is the time complexity of searching for an element in a balanced binary search tree (BST)?",
    "O(1)", "O(log n)", "O(n)", "O(n^2)"
  ],
  [
    "Which traversal method is used to retrieve nodes in ascending order from a BST?",
    "Preorder", "Inorder", "Postorder", "Level-order"
  ],
  [
    "What is the worst-case time complexity for inserting a node into an AVL tree?",
    "O(1)", "O(log n)", "O(n)", "O(n^2)"
  ],
  [
    "What operation is used to restore balance in an AVL tree after an insertion?",
    "Rotation", "Compression", "Expansion", "Rehashing"
  ],
  [
    "What is the primary advantage of using a B-tree over a binary search tree?",
    "Faster search time", "Lower memory usage", "Efficient operations with large amounts of data", "Easier implementation"
  ],
  [
    "What traversal technique is commonly used in a breadth-first search (BFS) of a binary tree?",
    "Preorder", "Inorder", "Postorder", "Level-order"
  ],
  [
    "How is a binary tree represented in an array?",
    "Using a linked list", "Using pointers", "Using index-based positioning", "Using a binary heap"
  ],
  [
    "What is the primary application of a binary heap?",
    "Priority queue implementation", "Hash table management", "Graph traversal", "Dynamic memory allocation"
  ],
  [
    "Which searching algorithm is most efficient for a large, sorted array?",
    "Linear search", "Binary search", "Interpolation search", "Jump search"
  ],
  [
    "What is the worst-case time complexity of quicksort?",
    "O(n)", "O(n log n)", "O(n^2)", "O(log n)"
  ],
  [
    "Which sorting algorithm is known for its divide-and-conquer approach?",
    "Bubble sort", "Merge sort", "Insertion sort", "Selection sort"
  ],
  [
    "What is the average time complexity of heap sort?",
    "O(1)", "O(log n)", "O(n log n)", "O(n^2)"
  ],
  [
    "Which of the following sorting algorithms is not comparison-based?",
    "Quick sort", "Merge sort", "Heap sort", "Counting sort"
  ],
  [
    "Which sorting algorithm performs best on average for large datasets?",
    "Merge sort", "Insertion sort", "Bubble sort", "Quick sort"
  ],
  [
    "What is the primary use of bucket sort?",
    "Sorting integers", "Sorting floating-point numbers", "Sorting elements with a known range", "Sorting large datasets with unknown ranges"
  ],
  [
    "How does external sorting differ from internal sorting?",
    "External sorting is used for data that fits in memory.", "Internal sorting is used for data that is too large to fit in memory.", "External sorting involves disk-based storage.", "Internal sorting involves distributed systems."
  ],
  [
    "What is the space complexity of the merge sort algorithm?",
    "O(1)", "O(log n)", "O(n)", "O(n^2)"
  ],
  [
    "What is the worst-case time complexity of binary search?",
    "O(1)", "O(log n)", "O(n)", "O(n^2)"
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
              _showResultDialog();
                  pageVisitTimeSubmit = DateTime.now();
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
                                                                              MaterialPageRoute(builder: (context) => DSReportUnit3()),
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
  DataSnapshot snapshot = await databaseReference.child('DS-Unit3').child(enrollmentNo).get();
 
        Duration difference = pageVisitTimeSubmit.difference(pageVisitTime);

int differenceInMinutes = difference.inMinutes;
int differenceInSeconds = difference.inSeconds%60;
  // If the name does not exist, show the result dialog and add the name with marks
  if (!snapshot.exists) {
    await databaseReference.child('DS-Unit3').child(enrollmentNo).set({
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
                await databaseReference.child('DS-Unit3').child(enrollmentNo).set({
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

