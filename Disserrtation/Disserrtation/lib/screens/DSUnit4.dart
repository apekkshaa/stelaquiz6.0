//import 'dart:io';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:stela_app/constants/userDetails.dart';
import 'package:stela_app/screens/DSReportUnit4.dart';
import 'dart:async';

import '../constants/colors.dart';



class DSUnit4 extends StatefulWidget {
  @override
  _DSUnit4State createState() => _DSUnit4State();
}

class _DSUnit4State extends State<DSUnit4> {
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
  // Graph Basics
  "The cost or length associated with the edge", // Question 1
  "Frequency list", // Question 2
  "The edge points from one vertex to another", // Question 3
  "Kruskal’s algorithm builds the minimum spanning tree by adding edges in increasing order of weight, while Prim’s algorithm builds it by expanding the tree from a single vertex", // Question 4
  "When the graph contains negative weight edges", // Question 5
  "A subset of edges that connects all vertices with the minimum possible total edge weight", // Question 6
  "Greedy approach", // Question 7
  "Disjoint-set (Union-Find) data structure", // Question 8
  "Kruskal’s algorithm", // Question 9
  "A graph where vertices can be divided into two disjoint sets", // Question 10

  // Graph Traversal and Algorithms
  "Breadth-first search (BFS)", // Question 11
  "Dijkstra’s algorithm", // Question 12
  "O(V + E)", // Question 13
  "An order of vertices such that for every directed edge (u, v), u comes before v", // Question 14
  "Prim’s algorithm", // Question 15
  "To find the shortest path between all pairs of vertices", // Question 16

  // Hashing
  "A fixed-size data structure used to store hashed data", // Question 17
  "It should produce a uniform distribution of hash values", // Question 18
  "It reduces clustering in hash tables", // Question 19

  // Graph Degree
  "The number of edges incident to the vertex", // Question 20
];

List<List<String>> questions = [
  // Graph Basics
  [
    "In a weighted graph, what does the weight of an edge represent?",
    "The time required to traverse the edge",
    "The number of edges connected to the vertex",
    "The cost or length associated with the edge",
    "The position of the edge in the graph"
  ],
  [
    "Which of the following is not a type of graph representation?",
    "Adjacency matrix",
    "Adjacency list",
    "Edge list",
    "Frequency list"
  ],
  [
    "What does a directed edge in a graph indicate?",
    "The edge has no direction",
    "The edge points from one vertex to another",
    "The edge connects only nodes of the same type",
    "The edge connects nodes in a circular manner"
  ],
  [
    "What is the key difference between Kruskal’s and Prim’s algorithms?",
    "Kruskal’s algorithm works on weighted graphs, while Prim’s algorithm does not.",
    "Kruskal’s algorithm builds the minimum spanning tree by adding edges in increasing order of weight, while Prim’s algorithm builds it by expanding the tree from a single vertex.",
    "Prim’s algorithm is used to find the shortest path, while Kruskal’s algorithm finds the longest path.",
    "Prim’s algorithm uses a priority queue, while Kruskal’s algorithm uses a hash table."
  ],
  [
    "In which scenario is the Bellman-Ford algorithm preferred over Dijkstra’s algorithm?",
    "When all edge weights are non-negative",
    "When the graph is dense",
    "When the graph contains negative weight edges",
    "When the graph is a tree"
  ],
  [
    "What does a spanning tree of a graph provide?",
    "A subset of edges that connects all vertices with the minimum possible total edge weight",
    "The shortest path between two specific vertices",
    "A path covering all edges exactly once",
    "A path covering all vertices exactly once"
  ],
  [
    "Which traversal method is used in Prim’s algorithm for finding the minimum spanning tree?",
    "Depth-first search (DFS)",
    "Breadth-first search (BFS)",
    "Randomized search",
    "Greedy approach"
  ],
  [
    "In Kruskal’s algorithm, what data structure is commonly used to detect cycles in the graph?",
    "Array",
    "Queue",
    "Disjoint-set (Union-Find) data structure",
    "Stack"
  ],
  [
    "Which of the following is not a type of graph traversal?",
    "Depth-first search (DFS)",
    "Breadth-first search (BFS)",
    "Topological sorting",
    "Kruskal’s algorithm"
  ],
  [
    "What is a bipartite graph?",
    "A graph where vertices can be divided into two disjoint sets",
    "A graph with exactly two cycles",
    "A graph where each vertex has exactly two neighbors",
    "A graph with no cycles"
  ],

  // Graph Traversal and Algorithms
  [
    "Which traversal technique is used to explore all nodes of a graph level by level?",
    "Depth-first search (DFS)",
    "Breadth-first search (BFS)",
    "Dijkstra’s algorithm",
    "Prim’s algorithm"
  ],
  [
    "In a directed graph, which of the following algorithms finds the shortest path from a source vertex to all other vertices?",
    "Bellman-Ford algorithm",
    "Dijkstra’s algorithm",
    "Kruskal’s algorithm",
    "Prim’s algorithm"
  ],
  [
    "What is the time complexity of depth-first search (DFS) in an adjacency list representation?",
    "O(V + E)",
    "O(V^2)",
    "O(E log V)",
    "O(V log E)"
  ],
  [
    "What does a topological sort of a directed acyclic graph (DAG) provide?",
    "An order of vertices such that for every directed edge (u, v), u comes before v",
    "A shortest path from source to destination",
    "A minimal spanning tree",
    "An order of edges in the graph"
  ],
  [
    "In a weighted graph, which algorithm is used to find the minimum spanning tree?",
    "Dijkstra’s algorithm",
    "Prim’s algorithm",
    "Floyd-Warshall algorithm",
    "Bellman-Ford algorithm"
  ],
  [
    "What is the primary purpose of the Floyd-Warshall algorithm?",
    "To find the shortest path between all pairs of vertices",
    "To find the minimum spanning tree",
    "To perform topological sorting",
    "To find the shortest path from a single source to all other vertices"
  ],

  // Hashing
  [
    "What is a bucket in the context of hashing?",
    "A fixed-size data structure used to store hashed data",
    "A unit of storage space on disk",
    "A block of memory for file organization",
    "A function used to map keys to indices"
  ],
  [
    "What is a common property of a good hash function?",
    "It should map keys to a fixed-size array in a predictable manner",
    "It should produce a uniform distribution of hash values",
    "It should always generate a unique hash value for each key",
    "It should minimize the use of memory"
  ],
  [
    "What is the primary advantage of double hashing over linear probing?",
    "It reduces clustering in hash tables",
    "It increases the complexity of the hash function",
    "It simplifies hash table resizing",
    "It uses less memory"
  ],

  // Graph Degree
  [
    "What is the degree of a vertex in an undirected graph?",
    "The number of edges incident to the vertex",
    "The number of paths from the vertex",
    "The number of vertices connected to the vertex",
    "The maximum weight of edges incident to the vertex"
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
                                                                              MaterialPageRoute(builder: (context) => DSReportUnit4()),
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
  DataSnapshot snapshot = await databaseReference.child('DS-Unit4').child(enrollmentNo).get();
 
        Duration difference = pageVisitTimeSubmit.difference(pageVisitTime);

int differenceInMinutes = difference.inMinutes;
int differenceInSeconds = difference.inSeconds%60;
  // If the name does not exist, show the result dialog and add the name with marks
  if (!snapshot.exists) {
    await databaseReference.child('DS-Unit4').child(enrollmentNo).set({
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
                await databaseReference.child('DS-Unit4').child(enrollmentNo).set({
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

