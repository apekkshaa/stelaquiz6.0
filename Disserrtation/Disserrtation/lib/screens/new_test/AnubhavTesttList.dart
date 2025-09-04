import 'package:flutter/material.dart';
import 'package:stela_app/constants/colors.dart';
import 'package:stela_app/constants/experimentDesc.dart';
import 'package:stela_app/screens/modules.dart';
import 'package:stela_app/screens/profile.dart';
import 'package:stela_app/screens/subjects.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:stela_app/screens/new_test/AnubhavAssessmentPage.dart';
import 'package:stela_app/screens/new_test/AnnuResultUnit1.dart';


var expNum;
String forms="https://docs.google.com/forms/d/e/1FAIpQLSdZ83klo9SO6-3p2drq2upikWs9zxkXld24I5ZHPD92EbAHNg/viewform?usp=sf_link";

class Anubhavtesttlist extends StatefulWidget {
  @override
  _AnubhavtesttlistState createState() => _AnubhavtesttlistState();
}

class _AnubhavtesttlistState extends State<Anubhavtesttlist> {
  final colChildren = <Widget>[];

  @override
  Widget build(BuildContext context) {
    print("wefwefwe");
    for (var i = 0; i < 10; i++) {
      colChildren.add(new ListTile());
    }

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: primaryWhite,
        appBar: AppBar(
          title: Text('STELA'),
          backgroundColor: primaryBar,
          leading: TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Icon(
                Icons.arrow_back,
                color: primaryWhite,
              )),
        ),
        body: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.symmetric(vertical: 100, horizontal: 10),
            alignment: Alignment.center,
            padding: EdgeInsets.all(10),
            child: Column(
              children: [
                Container(
                    padding: EdgeInsets.all(10),
                    child: Text('BASICS NOde js LIST',
                        style: TextStyle(
                            fontSize: 20,
                            fontFamily: 'PTSerif-Bold',
                            fontWeight: FontWeight.bold))),
                            Container(
  child: Column(
    children: [

         TextButton(
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(vertical: 5),
          margin: EdgeInsets.symmetric(vertical: 7),
          decoration: BoxDecoration(
            color: primaryButton,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(width: 2.0, color: primaryBar),
          ),
          child: Text(
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
            MaterialPageRoute(builder: (context) => Anubhavassessmentpage()),
          );
        },
      ),
         TextButton(
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(vertical: 5),
          margin: EdgeInsets.symmetric(vertical: 7),
          decoration: BoxDecoration(
            color: primaryButton,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(width: 2.0, color: primaryBar),
          ),
          child: Text(
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
                title: Text('Enter Pin'),
                content: TextField(
                  onChanged: (value) {
                    enteredPin = value; // Update entered pin as the user types
                  },
                  obscureText: true, // Hide entered pin characters
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    hintText: 'Enter 6-digit Pin',
                  ),
                ),
                actions: <Widget>[
                  TextButton(
                    child: Text('Submit'),
                    onPressed: () {
                      // Predefined 6-digit pin for comparison
                      String predefinedPin = '784567';

                      // Check if the entered pin matches the predefined pin
                      if (enteredPin == predefinedPin) {
                        // Navigate to the desired page
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Annuresultunit1()),
                        );
                        // Add this variable to track whether the link has been clicked
                      } else {
                        // Show an error message if the pin is incorrect
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
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
          padding: EdgeInsets.symmetric(vertical: 5),
          margin: EdgeInsets.symmetric(vertical: 7),
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
                  throw 'Could not launch $forms';
                }
              },
             child: Text(
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
),

               /* Container(
                  child: Column(
                    children: List.generate(
                      expNo.length,
                      (index) {
                        return TextButton(
                          child: Container(
                              width: double.infinity,
                              padding: EdgeInsets.symmetric(vertical: 5),
                              margin: EdgeInsets.symmetric(vertical: 7),
                              decoration: BoxDecoration(
                                color: primaryButton,
                                borderRadius: BorderRadius.circular(10),
                                border:
                                    Border.all(width: 2.0, color: primaryBar),
                              ),
                              child: Text('Experiment No. ' + expNo[index],
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontFamily: 'PTSerif',
                                    color: primaryBar,
                                  ),
                                  textAlign: TextAlign.center)),
                          onPressed: () {
                            expNum = index;
                            getBasicsExperiment(index);
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Modules()),
                                  //builder: (context) => Experiment()),
                                  
                            );
                          },
                        );
                      },
                    ),
                  ),
                ),*/
              ],
            ),
          ),
        ),
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
                icon: Icon(
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
                icon: Icon(
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
