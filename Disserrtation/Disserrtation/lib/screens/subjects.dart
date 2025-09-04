import 'package:flutter/material.dart';
import 'package:stela_app/constants/colors.dart';
import 'package:stela_app/screens/MyFiles.dart';
//import 'import 'package:stela_app/screens/BasicsexperimentList.dart';
import 'package:stela_app/screens/pythontutorial.dart';
import 'package:stela_app/screens/CCtutorial.dart';
import 'package:stela_app/screens/COAtutorial.dart';
import 'package:stela_app/screens/new_test/AnbhavTestTutorial.dart';
import 'package:stela_app/screens/profile.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:stela_app/screens/AI-basedProgrammingTools.dart';
import '../constants/userDetails.dart';
import 'Cloud Computing/AnbhavTestTutorial.dart';
import 'DataStructure.dart';
import 'Operating System/AnbhavTestTutorial.dart';
import 'SoftwareEng.dart';

String usermanual1 = "https://docs.google.com/document/d/1-55-CJP_Be6KlZgdGFk6K_j7sFQeqGulqfCrZPD2bcA/edit?usp=sharing";
String usermanual2 = "https://docs.google.com/document/d/17BSKS0CJfcuGD0yRM-QXVqvQIPX1B32bSlrwduvC8KU/edit?usp=sharing";
String feedback = "https://docs.google.com/spreadsheets/d/1SOxjjg91ezT3o8LFjrQ5F0GPOmRKqdrrGuBjVyYdo5A/edit?usp=sharing";

class Subjects extends StatefulWidget {
  @override
  _SubjectsState createState() => _SubjectsState();
}

class _SubjectsState extends State<Subjects> {
  @override
  Widget build(BuildContext context) {
    bool isFaculty = enrollmentNo == "FACULTY" || enrollmentNo == "Faculty";

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: primaryWhite,
        appBar: AppBar(
          title: const Text('STELA'),
          backgroundColor: primaryBar,
          // leading: TextButton(
          //     onPressed: () {
          //       Navigator.pop(context);
          //     },
          //     child: Icon(
          //       Icons.arrow_back,
          //       color: primaryWhite,
          //     )),
        ),
        body: SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
            child: Column(
              children: [
                // TextButton(
                //   onPressed: () {
                //     Navigator.push(
                //       context,
                //       MaterialPageRoute(builder: (context) => Anbhavtesttutorial()),
                //     );
                //   },
                //   child: Container(
                //     alignment: Alignment.center,
                //     padding: const EdgeInsets.all(10),
                //     decoration: BoxDecoration(
                //       color: primaryButton,
                //       border: Border.all(
                //         color: primaryBar,
                //         width: 1,
                //         style: BorderStyle.solid,
                //       ),
                //       borderRadius: const BorderRadius.all(
                //         Radius.circular(10),
                //       ),
                //       boxShadow: [
                //         BoxShadow(
                //           color: Colors.grey.withOpacity(0.5),
                //           spreadRadius: 5,
                //           blurRadius: 7,
                //           offset: const Offset(0, 3), // changes position of shadow
                //         ),
                //       ],
                //     ),
                //     child: const Column(
                //       children: [
                //         // Text(
                //         //   '1. Anubhav Test',
                //         //   style: TextStyle(
                //         //     fontSize: 20,
                //         //     fontFamily: 'PTSerif-Bold',
                //         //     color: primaryBar,
                //         //   ),
                //         // ),
                //       ],
                //     ),
                //   ),
                // ),
                // const SizedBox(height: 20), //

                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => OStutorial()),
                    );
                  },
                  child: Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: primaryButton,
                      border: Border.all(
                        color: primaryBar,
                        width: 1,
                        style: BorderStyle.solid,
                      ),
                      borderRadius: const BorderRadius.all(
                        Radius.circular(10),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset: const Offset(0, 3), // changes position of shadow
                        ),
                      ],
                    ),
                    child: const Column(
                      children: [
                        Text(
                          '1. Operating System',
                          style: TextStyle(
                            fontSize: 20,
                            fontFamily: 'PTSerif-Bold',
                            color: primaryBar,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => CCtutorial()),
                    );
                  },
                  child: Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: primaryButton,
                      border: Border.all(
                        color: primaryBar,
                        width: 1,
                        style: BorderStyle.solid,
                      ),
                      borderRadius: const BorderRadius.all(
                        Radius.circular(10),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset: const Offset(0, 3), // changes position of shadow
                        ),
                      ],
                    ),
                    child: const Column(
                      children: [
                        Text(
                          '2. Cloud Computing',
                          style: TextStyle(
                            fontSize: 20,
                            fontFamily: 'PTSerif-Bold',
                            color: primaryBar,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20), //

                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => PythonTutorial()),
                    );
                  },
                  child: Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: primaryButton,
                      border: Border.all(
                        color: primaryBar,
                        width: 1,
                        style: BorderStyle.solid,
                      ),
                      borderRadius: const BorderRadius.all(
                        Radius.circular(10),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset: const Offset(0, 3), // changes position of shadow
                        ),
                      ],
                    ),
                    child: const Column(
                      children: [
                        Text(
                          '2. Artificial Intelligence - Programming Tools',
                          style: TextStyle(
                            fontSize: 20,
                            fontFamily: 'PTSerif-Bold',
                            color: primaryBar,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20), // Add spacing between buttons
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => CCTutorial()),
                    );
                    // Handle the onPressed for the second button
                  },
                  child: Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: primaryButton,
                      border: Border.all(
                        color: primaryBar,
                        width: 1,
                        style: BorderStyle.solid,
                      ),
                      borderRadius: const BorderRadius.all(
                        Radius.circular(10),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset: const Offset(0, 3), // changes position of shadow
                        ),
                      ],
                    ),
                    child: const Text(
                      '3. Cloud Computing',
                      style: TextStyle(
                        fontSize: 20,
                        fontFamily: 'PTSerif-Bold',
                        color: primaryBar,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20), // Add spacing between buttons
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => COATutorial()),
                    );
                    // Handle the onPressed for the third button
                  },
                  child: Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: primaryButton,
                      border: Border.all(
                        color: primaryBar,
                        width: 1,
                        style: BorderStyle.solid,
                      ),
                      borderRadius: const BorderRadius.all(
                        Radius.circular(10),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset: const Offset(0, 3), // changes position of shadow
                        ),
                      ],
                    ),
                    child: const Text(
                      '4. Computer Organization and Architecture',
                      style: TextStyle(
                        fontSize: 20,
                        fontFamily: 'PTSerif-Bold',
                        color: primaryBar,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => MyFiles()),
                    );
                    // Handle the onPressed for the second button
                  },
                  child: Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: primaryButton,
                      border: Border.all(
                        color: primaryBar,
                        width: 1,
                        style: BorderStyle.solid,
                      ),
                      borderRadius: const BorderRadius.all(
                        Radius.circular(10),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset: const Offset(0, 3), // changes position of shadow
                        ),
                      ],
                    ),
                    child: const Text(
                      '5. My Python Codes and Practice',
                      style: TextStyle(
                        fontSize: 20,
                        fontFamily: 'PTSerif-Bold',
                        color: primaryBar,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: primaryButton,
                    border: Border.all(
                      color: primaryBar,
                      width: 1,
                      style: BorderStyle.solid,
                    ),
                    borderRadius: const BorderRadius.all(
                      Radius.circular(10),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: const Offset(0, 3), // changes position of shadow
                      ),
                    ],
                  ),
                  child: InkWell(
                    onTap: () async {
                      if (await canLaunch(usermanual1)) {
                        await launch(usermanual1, forceSafariVC: false, forceWebView: false);
                      } else {
                        throw 'Could not launch $usermanual1';
                      }
                    },
                    child: const Text(
                      '6. User Manual for using the application for students',
                      style: TextStyle(
                        fontSize: 20,
                        fontFamily: 'PTSerif-Bold',
                        color: primaryBar,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: primaryButton,
                    border: Border.all(
                      color: primaryBar,
                      width: 1,
                      style: BorderStyle.solid,
                    ),
                    borderRadius: const BorderRadius.all(
                      Radius.circular(10),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: const Offset(0, 3), // changes position of shadow
                      ),
                    ],
                  ),
                  child: InkWell(
                    onTap: () async {
                      if (await canLaunch(feedback)) {
                        await launch(feedback, forceSafariVC: false, forceWebView: false);
                      } else {
                        throw 'Could not launch $feedback';
                      }
                    },
                    child: const Text(
                      '7. Feedback of the users',
                      style: TextStyle(
                        fontSize: 20,
                        fontFamily: 'PTSerif-Bold',
                        color: primaryBar,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => AIbasedProgrammingTools()),
                    );
                    // Handle the onPressed for the second button
                  },
                  child: Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: primaryButton,
                      border: Border.all(
                        color: primaryBar,
                        width: 1,
                        style: BorderStyle.solid,
                      ),
                      borderRadius: const BorderRadius.all(
                        Radius.circular(10),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset: const Offset(0, 3), // changes position of shadow
                        ),
                      ],
                    ),
                    child: const Text(
                      '8.AIPT: AI-based Programming Tools',
                      style: TextStyle(
                        fontSize: 20,
                        fontFamily: 'PTSerif-Bold',
                        color: primaryBar,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => DataStructure()),
                    );
                    // Handle the onPressed for the second button
                  },
                  child: Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: primaryButton,
                      border: Border.all(
                        color: primaryBar,
                        width: 1,
                        style: BorderStyle.solid,
                      ),
                      borderRadius: const BorderRadius.all(
                        Radius.circular(10),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset: const Offset(0, 3), // changes position of shadow
                        ),
                      ],
                    ),
                    child: const Text(
                      'DS: Data Structure',
                      style: TextStyle(
                        fontSize: 20,
                        fontFamily: 'PTSerif-Bold',
                        color: primaryBar,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 20),
//
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SoftwareEng()),
                    );
                    // Handle the onPressed for the second button
                  },
                  child: Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: primaryButton,
                      border: Border.all(
                        color: primaryBar,
                        width: 1,
                        style: BorderStyle.solid,
                      ),
                      borderRadius: const BorderRadius.all(
                        Radius.circular(10),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset: const Offset(0, 3), // changes position of shadow
                        ),
                      ],
                    ),
                    child: const Text(
                      'SE: Software Engineering',
                      style: TextStyle(
                        fontSize: 20,
                        fontFamily: 'PTSerif-Bold',
                        color: primaryBar,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 20),
              ],
            ),
          ),
        ),

        /*body: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.symmetric(vertical: 200, horizontal: 10),
            child: TextButton(
              child: Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: primaryButton,
                    border: Border.all(
                      color: primaryBar,
                      width: 1,
                      style: BorderStyle.solid,
                    ),
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: Offset(0, 3), // changes position of shadow
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Text('Artificial Intelligence - Programming Tools',
                          style: TextStyle(
                            fontSize: 20,
                            fontFamily: 'PTSerif-Bold',
                            color: primaryBar,
                          )),
                      Text('M. Tech.',
                          style: TextStyle(
                            fontSize: 15,
                            fontFamily: 'PTSerif',
                            color: primaryBar,
                          )),
                      /*Text('>>>',
                          style: TextStyle(
                            fontSize: 20,
                            fontFamily: 'PTSerif',
                            color: primaryBar,
                          ))*/
                    ],
                  )),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PythonTutorial()),
                );
              },
            ),
          ),
        ),*/
        bottomNavigationBar: Container(
          color: primaryBar,
          // padding: EdgeInsets.all(7),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Subjects()),
                  );
                },
                icon: const Icon(
                  Icons.home,
                  color: primaryWhite,
                  size: 35,
                ),
              ),
              // IconButton(
              //   onPressed: () {
              //     Navigator.push(
              //       context,
              //       MaterialPageRoute(builder: (context) => AnalysisSubjects()),
              //     );
              //   },
              //   icon: Icon(
              //     Icons.saved_search_rounded,
              //     color: primaryWhite,
              //     size: 40,
              //   ),
              // ),
              IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Profile()),
                  );
                },
                icon: const Icon(
                  Icons.account_circle,
                  color: primaryWhite,
                  size: 35,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
