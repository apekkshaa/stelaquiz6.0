//import 'dart:io';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:stela_app/constants/userDetails.dart';
import 'dart:async';
import '../constants/colors.dart';
import 'SoftwareEngReportUnit4.dart';



class SEUnit4 extends StatefulWidget {
  @override
  _SEUnit4State createState() => _SEUnit4State();
}

class _SEUnit4State extends State<SEUnit4> {
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
  "To define the project scope and allocate resources",  // Question 1
  "User acceptance testing",  // Question 2
  "By ensuring that the project is completed on time and within budget",  // Question 3
  "Project Management Plan",  // Question 4
  "To identify and understand the needs and expectations of all parties involved in the project",  // Question 5
  "Historical data from similar projects",  // Question 6
  "To establish a reference point for measuring project performance",  // Question 7
  "Increased risk of project failure due to missed deadlines, budget overruns, and unmet requirements",  // Question 8
  "Effective project planning",  // Question 9
  "It helps in breaking down the project into manageable tasks, facilitating resource allocation and scheduling",  // Question 10
  "Accurately estimating time, effort, and resources required for the project",  // Question 11
  "Identifying, analyzing, and mitigating potential risks to minimize their impact on the project",  // Question 12
  "To outline the timeline for completing project tasks and milestones",  // Question 13
  "Gantt Chart",  // Question 14
  "They serve as key progress indicators, helping to track the completion of critical phases in the project",  // Question 15
  "To ensure that the right resources (people, tools, budget) are available when needed to complete the project",  // Question 16
  "Status Report",  // Question 17
  "To ensure that the project meets the needs and expectations of everyone involved, reducing the likelihood of conflicts and misunderstandings",  // Question 18
  "To oversee the planning process, ensuring that the project is well-organized, resources are allocated, and risks are managed effectively",  // Question 19
  "By clearly defining what is included in the project and what is not, helping to avoid scope creep and ensuring that the project stays on track"  // Question 20
];

List<List<String>> questions = [
  [
    "What is the primary objective of software project planning?",
    "To define the project scope and allocate resources",
    "To establish the technical requirements for the project",
    "To conduct post-project reviews",
    "To handle the testing phase of the project"
  ],
  [
    "Which of the following is NOT a component of software project planning?",
    "Resource allocation",
    "Risk analysis",
    "User acceptance testing",
    "Schedule estimation"
  ],
  [
    "How does effective software project planning contribute to project success?",
    "By ensuring that the project is completed on time and within budget",
    "By eliminating the need for risk management",
    "By guaranteeing that all software bugs are identified and resolved",
    "By reducing the number of required project deliverables"
  ],
  [
    "Which key document is typically produced during the software project planning phase?",
    "Project Management Plan",
    "Test Plan",
    "User Manual",
    "Maintenance Plan"
  ],
  [
    "What is the role of stakeholder analysis in software project planning?",
    "To identify and understand the needs and expectations of all parties involved in the project",
    "To document the technical requirements of the project",
    "To create the system architecture",
    "To perform unit testing"
  ],
  [
    "Which factor is critical for accurate estimation during software project planning?",
    "Historical data from similar projects",
    "Assumptions about future technologies",
    "Ignoring risk factors",
    "Estimating based on the shortest possible timeframe"
  ],
  [
    "In software project planning, what is the purpose of defining a project baseline?",
    "To establish a reference point for measuring project performance",
    "To identify project risks",
    "To allocate project resources",
    "To determine the project's quality standards"
  ],
  [
    "What is the main consequence of inadequate project planning?",
    "Increased risk of project failure due to missed deadlines, budget overruns, and unmet requirements",
    "Reduction in the number of project deliverables",
    "Improved team collaboration",
    "Enhanced software quality"
  ],
  [
    "Which of the following is a key factor in determining the success of a software project?",
    "The use of the latest technology",
    "Large project team size",
    "Effective project planning",
    "Detailed code documentation"
  ],
  [
    "What is the importance of creating a Work Breakdown Structure (WBS) in project planning?",
    "It helps in breaking down the project into manageable tasks, facilitating resource allocation and scheduling",
    "It documents the testing process",
    "It defines the project's quality standards",
    "It helps in creating user manuals"
  ],
  [
    "Which of the following is a major challenge in software project planning?",
    "Writing detailed code documentation",
    "Creating a user-friendly interface",
    "Conducting usability testing",
    "Accurately estimating time, effort, and resources required for the project"
  ],
  [
    "What role does risk management play in software project planning?",
    "Identifying, analyzing, and mitigating potential risks to minimize their impact on the project",
    "Ensuring that all project deliverables are completed",
    "Automating the testing process",
    "Documenting project requirements"
  ],
  [
    "What is the purpose of a project schedule in software project planning?",
    "To outline the timeline for completing project tasks and milestones",
    "To detail the technical specifications of the software",
    "To document user requirements",
    "To allocate project budget"
  ],
  [
    "Which tool is commonly used for project scheduling in software project planning?",
    "Gantt Chart",
    "UML Diagram",
    "Flowchart",
    "Entity-Relationship Diagram"
  ],
  [
    "In project planning, what is the significance of defining project milestones?",
    "They reduce the need for testing",
    "They serve as key progress indicators, helping to track the completion of critical phases in the project",
    "They define the project's coding standards",
    "They eliminate the need for risk management"
  ],
  [
    "What is the primary focus of resource allocation in software project planning?",
    "To ensure that the right resources (people, tools, budget) are available when needed to complete the project",
    "To create user manuals",
    "To write test cases",
    "To document software requirements"
  ],
  [
    "Which document is typically used to communicate the project's progress to stakeholders?",
    "Source Code",
    "User Guide",
    "Status Report",
    "Technical Specification Document"
  ],
  [
    "Why is it important to involve all relevant stakeholders in the project planning process?",
    "To ensure that the project meets the needs and expectations of everyone involved, reducing the likelihood of conflicts and misunderstandings",
    "To speed up the coding process",
    "To eliminate the need for documentation",
    "To focus solely on technical requirements"
  ],
  [
    "What is the role of a project manager in software project planning?",
    "To oversee the planning process, ensuring that the project is well-organized, resources are allocated, and risks are managed effectively",
    "To write the project's code",
    "To test the software",
    "To create the user interface"
  ],
  [
    "How does software project planning help in managing project scope?",
     "By reducing the number of project deliverables",
    "By clearly defining what is included in the project and what is not, helping to avoid scope creep and ensuring that the project stays on track",
    "By eliminating the need for testing",
    "By focusing only on technical tasks"
  ]
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
                                                                              MaterialPageRoute(builder: (context) => SEReportUnit4()),
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
  DataSnapshot snapshot = await databaseReference.child('SE-Unit4').child(enrollmentNo).get();
 
        Duration difference = pageVisitTimeSubmit.difference(pageVisitTime);

int differenceInMinutes = difference.inMinutes;
int differenceInSeconds = difference.inSeconds%60;
  // If the name does not exist, show the result dialog and add the name with marks
  if (!snapshot.exists) {
    await databaseReference.child('SE-Unit4').child(enrollmentNo).set({
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
                await databaseReference.child('SE-Unit4').child(enrollmentNo).set({
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

