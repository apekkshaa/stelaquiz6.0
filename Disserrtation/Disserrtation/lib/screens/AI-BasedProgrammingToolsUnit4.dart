//import 'dart:io';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:stela_app/constants/userDetails.dart';
import 'dart:async';

import '../constants/colors.dart';
import 'AIPT-ReportUnit4Pdf.dart';



class AIbasedProgrammingToolsUnit4 extends StatefulWidget {
  @override
  _AIbasedProgrammingToolsUnit4State createState() => _AIbasedProgrammingToolsUnit4State();
}

class _AIbasedProgrammingToolsUnit4State extends State<AIbasedProgrammingToolsUnit4> {
  List<String> selectedOptions = ["", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", ""];
 bool resultButtonClicked = false; 
  final databaseReference = FirebaseDatabase.instance.ref(); 
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
  // R basics
  "5 7 9",  // Question 1
  "paste()",  // Question 2
  "To display the structure of an R object",  // Question 3
  "2 4 6",  // Question 4
  "mean()",  // Question 5

  // R operations
  "1 2 3",  // Question 6
  "merge()",  // Question 7
  "10",  // Question 8
  "Creates a contingency table",  // Question 9
  "3 4 5",  // Question 10

  // Data handling
  "hist()",  // Question 11
  "Removes NA values from a vector or data frame",  // Question 12
  "3 5 7",  // Question 13
  "A B C",  // Question 14
  "sd()",  // Question 15

  // Advanced R functions
  "Applies a function to each element of a list or vector and returns a vector or matrix",  // Question 16
  "1 5 4 8",  // Question 17
  "3 7 11",  // Question 18
  "Combines data frames by rows",  // Question 19
  "5 7 9",  // Question 20
];

List<List<String>> questions = [
  // R basics
  [
    "What will be the output of the following R code?\nx <- c(1, 2, 3)\ny <- c(4, 5, 6)\nz <- x + y\nprint(z)",
    "5 7 9", "4 5 6", "1 2 3 4 5 6", "5 7 9"
  ],
  [
    "Which function is used to concatenate strings in R?",
    "concat()", "combine()", "paste()", "merge()"
  ],
  [
    "What is the purpose of the str() function in R?",
    "To display summary statistics",
    "To display the structure of an R object",
    "To convert a variable to a string",
    "To summarize a data frame"
  ],
  [
    "What will be the output of the following R code?\ndf <- data.frame(a = 1:3, b = c(\"x\", \"y\", \"z\"))\ndf\$a <- df\$a * 2\nprint(df)",
    "2 4 6", "1 2 3", "2 4 6", "2 4 6"
  ],
  [
    "Which function in R is used to calculate the mean of a numeric vector?",
    "average()", "mean()", "sum()", "median()"
  ],

  // R operations
  [
    "What is the result of the following code?\nx <- c(2, 4, 6)\ny <- x / 2\nprint(y)",
    "1 2 3", "2 4 6", "1 2 3", "2 4 6"
  ],
  [
    "How can you merge two data frames in R by a common column?",
    "merge()", "join()", "combine()", "link()"
  ],
  [
    "What will the following R code output?\nx <- c(1, 2, 3)\ny <- c(3, 2, 1)\nresult <- x %*% y\nprint(result)",
    "10", "14", "8", "12"
  ],
  [
    "What does the table() function in R do?",
    "Creates a contingency table",
    "Combines multiple tables",
    "Generates a summary of a data frame",
    "Calculates means and medians"
  ],
  [
    "What will be the result of the following R code?\nx <- c(1, 2, 3, 4, 5)\nresult <- x[x > 2]\nprint(result)",
    "1 2 3 4 5", "3 4 5", "1 2", "2 3 4 5"
  ],

  // Data handling
  [
    "How do you plot a histogram in R?",
    "hist()", "plot()", "barplot()", "scatter()"
  ],
  [
    "What does the na.omit() function do in R?",
    "Removes NA values from a vector or data frame",
    "Replaces NA values with zeros",
    "Imputes NA values using the mean",
    "Excludes NA values from calculations"
  ],
  [
    "What will be the output of the following R code?\nx <- c(2, 4, 6)\ny <- x + 1\nprint(y)",
    "3 5 7", "2 4 6", "3 4 5", "2 5 6"
  ],
  [
    "What is the output of this R code?\ndf <- data.frame(a = 1:3, b = c(\"A\", \"B\", \"C\"))\ndf\$b <- toupper(df\$b)\nprint(df)",
    "A B C", "a b c", "A B C", "1 2 3 A B C"
  ],
  [
    "Which function is used to calculate the standard deviation in R?",
    "sd()", "std_dev()", "deviation()", "variance()"
  ],

  // Advanced R functions
  [
    "What does the sapply() function do in R?",
    "Applies a function to each element of a list or vector and returns a vector or matrix",
    "Applies a function to each column of a data frame",
    "Summarizes the statistics of a data frame",
    "Splits a data frame into smaller data frames"
  ],
  [
    "What will be the result of the following code snippet?\ndf <- data.frame(a = c(1, 2, NA, 4), b = c(5, NA, 7, 8))\ndf_clean <- na.omit(df)\nprint(df_clean)",
    "1 5 2 8", "1 5 4 8", "1 5 2 7 4 8", "1 5 4 8"
  ],
  [
    "What will the following R code output?\nx <- c(2, 4, 6)\ny <- c(1, 3, 5)\nresult <- x + y\nprint(result)",
    "3 7 11", "2 4 6", "3 7 11", "1 3 5"
  ],
  [
    "What does the rbind() function do in R?",
    "Combines data frames by rows",
    "Combines data frames by columns",
    "Binds rows of matrices",
    "Removes rows from a data frame"
  ],
  [
    "What will be the output of this R code?\nx <- c(1, 2, 3)\ny <- c(4, 5, 6)\ndf <- data.frame(x, y)\ndf_sum <- rowSums(df)\nprint(df_sum)",
    "5 7 9", "1 2 3 4 5 6", "4 8 12", "5 7 9"
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
                child: Text('Result'),
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
                                                                              MaterialPageRoute(builder: (context) => PdfPageUnit4()),
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
  DataSnapshot snapshot = await databaseReference.child('AIPT-Unit4').child(enrollmentNo).get();
 
        Duration difference = pageVisitTimeSubmit.difference(pageVisitTime);

int differenceInMinutes = difference.inMinutes;
int differenceInSeconds = difference.inSeconds%60;
  // If the name does not exist, show the result dialog and add the name with marks
  if (!snapshot.exists) {
    await databaseReference.child('DS').child(enrollmentNo).set({
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
                await databaseReference.child('AIPT-Unit4').child(enrollmentNo).set({
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


