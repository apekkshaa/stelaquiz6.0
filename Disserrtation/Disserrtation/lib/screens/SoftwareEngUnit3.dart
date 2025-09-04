//import 'dart:io';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:stela_app/constants/userDetails.dart';
import 'dart:async';

import '../constants/colors.dart';
import 'SoftwareEngReportUnit3.dart';



class SEUnit3 extends StatefulWidget {
  @override
  _SEUnit3State createState() => _SEUnit3State();
}

class _SEUnit3State extends State<SEUnit3> {
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
  "Singleton",  // Question 1
  "To define a one-to-many dependency between objects so that when one object changes state, all its dependents are notified and updated automatically",  // Question 2
  "Mediator",  // Question 3
  "Abstract Factory",  // Question 4
  "Define a family of algorithms, encapsulate each one, and make them interchangeable",  // Question 5
  "Factory Method",  // Question 6
  "To provide a default implementation of the interface that can be extended or modified by decorators",  // Question 7
  "Decorator",  // Question 8
  "Uniformly, allowing clients to interact with both individual objects and compositions in the same way",  // Question 9
  "Strategy",  // Question 10
  "To allow incompatible interfaces to work together by providing a wrapper that converts one interface into another",  // Question 11
  "The construction process of an object should be independent of the parts that make up the object and how they are assembled",  // Question 12
  "Singleton",  // Question 13
  "Define the skeleton of an algorithm in a base class but allow subclasses to provide specific implementations for some steps",  // Question 14
  "It acts as an intermediary or placeholder for another object, controlling access to it",  // Question 15
  "State",  // Question 16
  "Facade",  // Question 17
  "Facade",  // Question 18
  "Bridge",  // Question 19
  "To minimize memory usage by sharing as much data as possible with similar objects",  // Question 20
];

List<List<String>> questions = [
  [
    "Which design pattern is used to ensure that a class has only one instance and provides a global point of access to it?",
    "Singleton", "Factory", "Observer", "Strategy"
  ],
  [
    "What is the primary purpose of the Observer design pattern?",
    "To define a one-to-many dependency between objects so that when one object changes state, all its dependents are notified and updated automatically", 
    "To provide a way to create objects without specifying the exact class of the object that will be created", 
    "To ensure that a class has only one instance and provides a global point of access to it", 
    "To provide a way to compose objects into tree structures to represent part-whole hierarchies"
  ],
  [
    "In which design pattern do objects communicate with each other through a mediator object, which handles the communication between them?",
    "Mediator", "Observer", "Singleton", "Factory"
  ],
  [
    "Which pattern is designed to allow a system to be independent of how its objects are created, composed, and represented?",
    "Abstract Factory", "Builder", "Prototype", "Decorator"
  ],
  [
    "The Strategy pattern is used to:",
    "Define a family of algorithms, encapsulate each one, and make them interchangeable", 
    "Provide a way to create objects without specifying the exact class of the object that will be created", 
    "Attach additional responsibilities to an object dynamically", 
    "Allow an object to alter its behavior when its internal state changes"
  ],
  [
    "Which design pattern involves creating an interface for creating objects, but letting subclasses alter the type of objects that will be created?",
    "Factory Method", "Adapter", "Bridge", "Composite"
  ],
  [
    "In the Decorator pattern, what is the purpose of the concrete component class?",
    "To provide a default implementation of the interface that can be extended or modified by decorators", 
    "To act as a mediator between different objects", 
    "To ensure that a class has only one instance", 
    "To encapsulate a family of algorithms"
  ],
  [
    "Which design pattern is best suited for systems where objects can have a varying number of responsibilities and where responsibilities need to be added dynamically?",
    "Decorator", "Proxy", "Singleton", "Command"
  ],
  [
    "In the Composite pattern, how are individual objects and compositions of objects treated?",
    "Uniformly, allowing clients to interact with both individual objects and compositions in the same way", 
    "Separately, with distinct interfaces for individual objects and compositions", 
    "Using different patterns for individual objects and compositions", 
    "By defining a new interface for compositions only"
  ],
  [
    "Which design pattern helps to separate an algorithm from an object on which it operates, allowing the algorithm to vary independently of the objects that use it?",
    "Strategy", "Template Method", "Iterator", "Mediator"
  ],
  [
    "What is the primary benefit of using the Adapter pattern?",
    "To allow incompatible interfaces to work together by providing a wrapper that converts one interface into another", 
    "To encapsulate a family of algorithms", 
    "To define a common interface for a set of related classes", 
    "To control the access to a resource"
  ],
  [
    "The Builder pattern is most appropriate when:",
    "The construction process of an object should be independent of the parts that make up the object and how they are assembled", 
    "There is a need to add responsibilities to objects dynamically", 
    "There is a need to create a single instance of a class", 
    "An object should have only one instance and provide a global point of access"
  ],
  [
    "Which design pattern is used to ensure that only one instance of a class is created and provides a global point of access to that instance?",
    "Singleton", "Prototype", "Builder", "Adapter"
  ],
  [
    "The Template Method pattern is used to:",
    "Define the skeleton of an algorithm in a base class but allow subclasses to provide specific implementations for some steps", 
    "Separate the creation of complex objects from their representation", 
    "Define a family of algorithms and make them interchangeable", 
    "Provide a way to create objects without specifying the exact class of the object that will be created"
  ],
  [
    "In the Proxy pattern, what role does the proxy object play?",
    "It acts as an intermediary or placeholder for another object, controlling access to it", 
    "It defines a family of algorithms, encapsulates each one, and makes them interchangeable", 
    "It provides a way to compose objects into tree structures to represent part-whole hierarchies", 
    "It defines the interface for creating objects but allows subclasses to alter the type of objects created"
  ],
  [
    "Which pattern allows an object to alter its behavior when its internal state changes, appearing as if it has changed its class?",
    "State", "Strategy", "Chain of Responsibility", "Mediator"
  ],
  [
    "In which design pattern does a client interact with a single object rather than a group of objects, simplifying the interface for the client?",
    "Facade", "Decorator", "Composite", "Proxy"
  ],
  [
    "Which design pattern is used to provide a unified interface to a set of interfaces in a subsystem, making it easier to use?",
    "Facade", "Adapter", "Bridge", "Proxy"
  ],
  [
    "In which design pattern are operations and responsibilities encapsulated in separate classes, allowing them to be independently varied and extended?",
    "Bridge", "Singleton", "Composite", "Decorator"
  ],
  [
    "What is the key advantage of using the Flyweight pattern?",
    "To minimize memory usage by sharing as much data as possible with similar objects", 
    "To provide a way to create objects without specifying the exact class of the object", 
    "To simplify the interface for interacting with a complex subsystem", 
    "To ensure that a class has only one instance and provides a global point of access"
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
                                                                              MaterialPageRoute(builder: (context) => SEReportUnit3()),
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
  DataSnapshot snapshot = await databaseReference.child('SE-Unit3').child(enrollmentNo).get();
 
        Duration difference = pageVisitTimeSubmit.difference(pageVisitTime);

int differenceInMinutes = difference.inMinutes;
int differenceInSeconds = difference.inSeconds%60;
  // If the name does not exist, show the result dialog and add the name with marks
  if (!snapshot.exists) {
    await databaseReference.child('SE-Unit3').child(enrollmentNo).set({
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
                await databaseReference.child('SE-Unit3').child(enrollmentNo).set({
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

