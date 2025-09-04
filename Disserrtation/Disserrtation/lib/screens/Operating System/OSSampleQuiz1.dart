import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:stela_app/screens/globals.dart';
import 'package:stela_app/constants/userDetails.dart';
import 'dart:async';

import 'package:stela_app/constants/colors.dart';
import 'OsReport1.dart';

class OSUnit1 extends StatefulWidget {
  const OSUnit1({super.key});

  @override
  _OSUnit1State createState() => _OSUnit1State();
}

class _OSUnit1State extends State<OSUnit1> {
  // controllers (must be declared before fields that use them)
  final TextEditingController _controller = TextEditingController(text: 'The manipulated value is: 45');
  final TextEditingController controller = TextEditingController(text: 'x=5645\n');

  // quiz state
  List<String> selectedOptions = List<String>.filled(10, '');
  bool alreadySubmitted = false;

  // firebase ref
  final DatabaseReference databaseReference = FirebaseDatabase.instanceFor(
    app: Firebase.app(),
    databaseURL: "https://stela23-f9a52-default-rtdb.asia-southeast1.firebasedatabase.app",
  ).ref();

  // timing
  late DateTime pageVisitTime;
  DateTime? pageVisitTimeSubmit;
  late Timer _timer;
  bool timerExpired = false;
  int _remainingTime = 600; // 10 minutes

  // optional fields shown/saved with report
  String universityName = '';
  String courseName = '';
  String examTypeName = '';
  String place = '';

  // questions & answers
  final List<String> correctAnswers = [
    "Mutual Exclusion", // Q1
    "5", // Q2
    "20.25 ms (SRTF)", // Q3
    "Both incur the same number of page faults", // Q4
    "P: empty, Q: full, R: full, S: empty", // Q5
    "P2", // Q6
    "I, II, III and IV only", // Q7
    "32", // Q8
    "0", // Q9
    "12" // Q10
  ];

  final List<List<String>> questions = [
    [
      "Which condition of deadlock ensures that no two processes can access the same resource simultaneously?",
      "Mutual Exclusion",
      "Hold and Wait",
      "No Preemption",
      "Circular Wait"
    ],
    [
      "For a 57-bit virtual address space, 4KB pages, and 8B page table entries, how many levels are required in a multilevel page table?",
      "3",
      "4",
      "5",
      "6"
    ],
    [
      "A scheduling algorithm gives turnaround time 20.25 ms for a set of processes. Which algorithm is used?",
      "FCFS",
      "SJF",
      "SRTF",
      "RR"
    ],
    [
      "For a reference string and 5 frames, which incurs fewer page faults: FIFO or LRU?",
      "FIFO",
      "LRU",
      "Both incur the same number of page faults",
      "Cannot be determined"
    ],
    [
      "Given a producer-consumer problem with semaphores P, Q, R, S, what is the state of buffers?",
      "P: empty, Q: full, R: full, S: empty",
      "All empty",
      "All full",
      "None"
    ],
    [
      "In resource allocation, which process finishes last in the given scenario?",
      "P1",
      "P2",
      "P3",
      "P4"
    ],
    [
      "Which process state transitions are valid?",
      "I only",
      "I, II, III only",
      "I, II, III and IV only",
      "All invalid"
    ],
    [
      "For a fork program running i=0 to 9, how many child processes are created?",
      "8",
      "16",
      "32",
      "64"
    ],
    [
      "Difference between SSTF and SCAN head movements for the given sequence?",
      "0",
      "5",
      "10",
      "15"
    ],
    [
      "Minimum number of resources required to avoid deadlock for 3, 4, 6 instances?",
      "10",
      "11",
      "12",
      "13"
    ],
  ];

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    pageVisitTime = DateTime.now();

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!mounted) return;
      setState(() {
        if (_remainingTime > 0) {
          _remainingTime--;
        } else {
          timerExpired = true;
          _timer.cancel();
          // set submit time if not set and show result
          pageVisitTimeSubmit ??= DateTime.now();
          _showResultDialog();
        }
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    _controller.dispose();
    controller.dispose();
    super.dispose();
  }

  String _formatTime(int seconds) {
    final Duration duration = Duration(seconds: seconds);
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    final String minutes = twoDigits(duration.inMinutes.remainder(60));
    final String remainingSeconds = twoDigits(duration.inSeconds.remainder(60));
    return "$minutes:$remainingSeconds";
  }

  @override
  Widget build(BuildContext context) {
    // Return a Scaffold only (do not nest MaterialApp)
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: const Text('OS Assessment'),
        backgroundColor: primaryBar,
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(timerExpired ? 'Time\'s up!' : 'Time Left: ${_formatTime(_remainingTime)}'),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: primaryButton,
                ),
                child: const SelectableText(
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
                            // Update the course name here
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
                      text: 'Exam Type: ',
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
                            // Update the exam type here
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
                      text: 'Place: ',
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
                            // Update the place here
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
              
              const SizedBox(height: 20),
              for (int i = 0; i < questions.length; i++) _buildQuestionWidget(i + 1, questions[i]),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: alreadySubmitted
                    ? null
                    : () {
                        // set submit time first, then evaluate
                        pageVisitTimeSubmit = DateTime.now();
                        _showResultDialog();
                      },
                child: const Text('Submit Test'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildQuestionWidget(int questionNumber, List<String> question) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'Question $questionNumber: ${question[0]}',
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          for (int i = 1; i < question.length; i++)
            RadioListTile<String>(
              title: Text(question[i]),
              value: question[i],
              groupValue: selectedOptions[questionNumber - 1],
              onChanged: (value) {
                setState(() {
                  selectedOptions[questionNumber - 1] = value ?? '';
                });
              },
            ),
        ],
      ),
    );
  }

  Future<void> _showResultDialog() async {
    if (alreadySubmitted) {
      // show already submitted notice
      await showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: const Text('ASSESSMENT ALREADY SUBMITTED'),
          content: const Text('Your assessment has already been submitted.'),
          actions: [TextButton(onPressed: () => Navigator.of(context).pop(), child: const Text('OK'))],
        ),
      );
      return;
    }

    // ensure submit time
    pageVisitTimeSubmit ??= DateTime.now();

    int correctCount = 0;
    int incorrectCount = 0;
    int unattemptedCount = 0;
    final List<String> result = [];

    for (int i = 0; i < correctAnswers.length; i++) {
      final sel = selectedOptions[i];
      if (sel.isEmpty) {
        unattemptedCount++;
        result.add('Unattempted');
      } else if (sel == correctAnswers[i]) {
        correctCount++;
        result.add('Correct');
      } else {
        incorrectCount++;
        result.add('Incorrect');
      }
    }

    final String enrollKey = (enrollmentNo ?? '').toString();
    if (enrollKey.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Enrollment number not found. Cannot submit.')));
      return;
    }

    try {
      final DataSnapshot snapshot = await databaseReference.child('OS-Unit1').child(enrollKey).get();

      final Duration diff = pageVisitTimeSubmit!.difference(pageVisitTime);
      final int diffMin = diff.inMinutes;
      final int diffSec = diff.inSeconds % 60;
      final String durationStr = "$diffMin minutes $diffSec seconds";

      if (!snapshot.exists) {
        await databaseReference.child('OS-Unit1').child(enrollKey).set({
          '1_Name': name ?? '',
          '2_Total Marks': questions.length,
          '3_Marks obtained': correctCount,
          '4_Correct': correctCount,
          '5_Incorrect': incorrectCount,
          '6_Unattempted': unattemptedCount,
          '7_Start time': pageVisitTime.toString(),
          '8_End time': pageVisitTimeSubmit!.toString(),
          '11_Duration': durationStr,
          '12_University Name': universityName,
          '13_Course Name': courseName,
          '14_Exam Type': examTypeName,
          '15_Place': place,
        });

        setState(() {
          alreadySubmitted = true;
        });

        await showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('RESULT', style: TextStyle(fontWeight: FontWeight.bold)),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Marks Obtained: $correctCount out of ${correctAnswers.length}'),
                    const SizedBox(height: 10),
                    ...List.generate(
                      correctAnswers.length,
                      (index) {
                        if (result[index] == 'Correct') {
                          return Text('Question ${index + 1}: Correct', style: const TextStyle(color: Colors.green));
                        } else if (result[index] == 'Unattempted') {
                          return Text('Question ${index + 1}: Unattempted, Correct Answer: ${correctAnswers[index]}',
                              style: const TextStyle(color: Colors.grey));
                        } else {
                          return Text('Question ${index + 1}: Incorrect, Correct Answer: ${correctAnswers[index]}',
                              style: const TextStyle(color: Colors.red));
                        }
                      },
                    ),
                  ],
                ),
              ),
              actions: <Widget>[
                TextButton(onPressed: () => Navigator.of(context).pop(), child: const Text('OK')),
              ],
            );
          },
        );
      } else {
        await showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('ASSESSMENT ALREADY SUBMITTED', style: TextStyle(fontWeight: FontWeight.bold)),
              content: const Text('Your assessment has already been submitted.'),
              actions: <Widget>[
                TextButton(onPressed: () => Navigator.of(context).pop(), child: const Text('OK')),
              ],
            );
          },
        );
      }
    } catch (e) {
      // handle errors (e.g. database not reachable)
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Error submitting assessment. Please try again later.')));
    }
  }
}