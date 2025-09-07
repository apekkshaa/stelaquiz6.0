import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:stela_app/screens/globals.dart';
import 'package:stela_app/constants/userDetails.dart';
import 'dart:async';

import 'package:stela_app/constants/colors.dart';
import 'OsReport2.dart';

class OSUnit2 extends StatefulWidget {
  const OSUnit2({super.key});

  @override
  _OSUnit2State createState() => _OSUnit2State();
}

class _OSUnit2State extends State<OSUnit2> {
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
    "16384", // Q2
    "8 ms", // Q3
    "Both incur the same number of faults", // Q4
    "7 empty, 3 full", // Q5
    "Ordering of resources", // Q6
    "I, II, III, IV", // Q7
    "4", // Q8
    "0", // Q9
    "15" // Q10
  ];

  final List<List<String>> questions = [
    [
      "Which property is always ensured by a lock variable in a concurrent system?",
      "Bounded Waiting",
      "Mutual Exclusion",
      "Fairness",
      "Deadlock Avoidance"
    ],
    [
      "For a 32-bit address space with a page size of 2 KB and each PTE of 4 bytes, how many entries are in a single-level page table?",
      "1024",
      "2048",
      "4096",
      "16384"
    ],
    [
      "Four processes arrive as follows: P1 at 0ms(7ms), P2 at 2ms(5ms), P3 at 4ms(3ms), P4 at 6ms(6ms). What is the average turnaround time using SRTF?",
      "6.5 ms",
      "8 ms",
      "10 ms",
      "11 ms"
    ],
    [
      "Given a page reference sequence 4, 3, 5, 2, 1, 2, 4, 3, 5, 2 with 3 frames, which statement holds for FIFO and LRU faults?",
      "FIFO has fewer faults than LRU",
      "LRU has fewer faults than FIFO",
      "Both incur the same number of faults",
      "FIFO incurs 2 more faults than LRU"
    ],
    [
      "If in the producer-consumer buffer empty=7, full=3, mutex=1, what does this mean for a buffer of 10?",
      "10 produced, 3 consumed",
      "3 produced, 7 consumed",
      "7 empty, 3 full",
      "None"
    ],
    [
      "Which mechanism avoids deadlock in a resource allocation graph?",
      "Resource allocation graphs",
      "Preemption",
      "Ordering of resources",
      "Request matrix update"
    ],
    [
      "With these transitions: I. Blocked to Ready II. Ready to Running III. Running to Blocked IV. Running to Ready. Pick the valid ones.",
      "I, II only",
      "I, III only",
      "II, III, IV only",
      "I, II, III, IV"
    ],
    [
      "for (i=0; i<4; i++) if (i % 2 == 0) fork(); How many total child processes?",
      "2",
      "3",
      "4",
      "8"
    ],
    [
      "Disk: 20, 40, 90, 100, 10 (start at 30). SSTF vs. SCAN difference in travel (toward larger tracks)?",
      "0",
      "8",
      "12",
      "15"
    ],
    [
      "Considering the demands of 3 processes (4, 5, 7), what is minimum m (resource units) needed for deadlock avoidance?",
      "15",
      "16",
      "14",
      "17"
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
            child: Text(
              timerExpired ? 'Time\'s up!' : 'Time Left: ${_formatTime(_remainingTime)}',
              style: const TextStyle(color: Colors.white),
            ),
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
      final DataSnapshot snapshot = await databaseReference.child('OS-Unit2').child(enrollKey).get();

      final Duration diff = pageVisitTimeSubmit!.difference(pageVisitTime);
      final int diffMin = diff.inMinutes;
      final int diffSec = diff.inSeconds % 60;
      final String durationStr = "$diffMin minutes $diffSec seconds";

      if (!snapshot.exists) {
        await databaseReference.child('OS-Unit2').child(enrollKey).set({
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



