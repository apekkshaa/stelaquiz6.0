import 'package:flutter/material.dart';
import 'package:stela_app/constants/colors.dart';
import 'package:stela_app/screens/profile.dart';
import 'package:stela_app/screens/subjects.dart';
import 'package:url_launcher/url_launcher.dart';

import 'AnnuResultUnit1.dart';
import 'AnubhavAssessmentPage.dart';
import 'OSSampleQuiz1.dart';
import 'OSResultQuiz1.dart';

var expNum;
String forms =
    "https://docs.google.com/forms/d/e/1FAIpQLSdZ83klo9SO6-3p2drq2upikWs9zxkXld24I5ZHPD92EbAHNg/viewform?usp=sf_link";

class OSlist extends StatefulWidget {
  const OSlist({super.key});

  @override
  _OSlistlistState createState() => _OSlistlistState();
}

class _OSlistlistState extends State<OSlist> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: primaryWhite,
        appBar: AppBar(
          title: const Text('STELA'),
          backgroundColor: primaryBar,
          leading: TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Icon(
              Icons.arrow_back,
              color: primaryWhite,
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: 100, horizontal: 10),
            alignment: Alignment.center,
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                Container(
                    padding: const EdgeInsets.all(10),
                    child: const Text('Operating System LIST',
                        style: TextStyle(
                            fontSize: 20,
                            fontFamily: 'PTSerif-Bold',
                            fontWeight: FontWeight.bold))),

                // Buttons column
                Column(
                  children: [
                    TextButton(
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        margin: const EdgeInsets.symmetric(vertical: 7),
                        decoration: BoxDecoration(
                          color: primaryButton,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(width: 2.0, color: primaryBar),
                        ),
                        child: const Text(
                          'Practice Quiz',
                          style: TextStyle(
                            fontSize: 15,
                            fontFamily: 'PTSerif',
                            color: primaryBar,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => OSassessmentpage()),
                        );
                      },
                    ),

                    TextButton(
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        margin: const EdgeInsets.symmetric(vertical: 7),
                        decoration: BoxDecoration(
                          color: primaryButton,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(width: 2.0, color: primaryBar),
                        ),
                        child: const Text(
                          'Sample Quiz 1',
                          style: TextStyle(
                            fontSize: 15,
                            fontFamily: 'PTSerif',
                            color: primaryBar,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      onPressed: () {
                        // OSSampleQuiz1.dart defines OSUnit1 — navigate to that screen
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const OSUnit1()),
                        );
                      },
                    ),

                    TextButton(
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        margin: const EdgeInsets.symmetric(vertical: 7),
                        decoration: BoxDecoration(
                          color: primaryButton,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(width: 2.0, color: primaryBar),
                        ),
                        child: const Text(
                          'Result',
                          style: TextStyle(
                            fontSize: 15,
                            fontFamily: 'PTSerif',
                            color: primaryBar,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            String enteredPin = ''; // Variable to store the entered pin
                            return AlertDialog(
                              title: const Text('Enter Pin'),
                              content: TextField(
                                onChanged: (value) {
                                  enteredPin = value; // Update entered pin as the user types
                                },
                                obscureText: true, // Hide entered pin characters
                                keyboardType: TextInputType.number,
                                decoration: const InputDecoration(
                                  hintText: 'Enter 6-digit Pin',
                                ),
                              ),
                              actions: <Widget>[
                                TextButton(
                                  child: const Text('Submit'),
                                  onPressed: () {
                                    const String predefinedPin = '784567';
                                    if (enteredPin == predefinedPin) {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => OSResultUnit1()),
                                      );
                                    } else {
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(
                                          content: Text('Incorrect Pin. Please try again.'),
                                        ),
                                      );
                                    }
                                  },
                                ),
                              ],
                            );
                          },
                        );
                      },
                    ),

                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      margin: const EdgeInsets.symmetric(vertical: 7),
                      decoration: BoxDecoration(
                        color: primaryButton,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(width: 2.0, color: primaryBar),
                      ),
                      child: InkWell(
                        onTap: () async {
                          if (await canLaunch(forms)) {
                            await launch(forms, forceSafariVC: false, forceWebView: false);
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Could not launch $forms')),
                            );
                          }
                        },
                        child: const Text(
                          'Feedback form',
                          style: TextStyle(
                            fontSize: 15,
                            fontFamily: 'PTSerif',
                            color: primaryBar,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: Container(
          color: primaryBar,
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