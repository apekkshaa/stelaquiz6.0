import 'package:flutter/material.dart';
import 'package:stela_app/constants/colors.dart';
import 'package:stela_app/screens/profile.dart';
import 'package:stela_app/screens/subjects.dart';
import 'DS-ResultUnit1.dart';
import 'DS-ResultUnit2.dart';
import 'DS-ResultUnit3.dart';
import 'DS-ResultUnit4.dart';
import 'DSUnit1.dart';
import 'DSUnit2.dart';
import 'DSUnit3.dart';
import 'DSUnit4.dart';


var expNum;
bool linkClicked = false;

class DataStructure extends StatefulWidget{
  @override
  _DataStructureState createState() => _DataStructureState();
}

class _DataStructureState extends State<DataStructure> {  

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: primaryWhite,
        appBar: AppBar(
          title: Text('Data Structure Quiz'),
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
        body: Center(
          child: SingleChildScrollView(
            child: Container(
                // margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                alignment: Alignment.center,
                padding: EdgeInsets.all(10),
                child: Column(children: [
                  //Container(padding: EdgeInsets.all(10), child: Text('STELA', style: TextStyle(color: Colors.white, fontSize: 35, fontFamily: 'PTSerif-ExtraBold', fontWeight: FontWeight.bold))),
                  Container(
                    child: Column(
                      children: [
                        Container(
                            padding: EdgeInsets.all(10),
                            child: Text('Unit - 1',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontFamily: 'PTSerif-Bold',
                                  fontWeight: FontWeight.w900,
                                ))),
                       

                                                                        TextButton(
                                                                          child: Container(
                                                                              width: double.infinity,
                                                                              padding: EdgeInsets.symmetric(vertical: 5),
                                                                              decoration: BoxDecoration(
                                                                                color: primaryButton,
                                                                                borderRadius: BorderRadius.circular(10),
                                                                                border: Border.all(width: 2.0, color: primaryBar),
                                                                              ),
                                                                              child: Text(
                                                                                'Unit - 1',
                                                                                style: TextStyle(
                                                                                  //color: Colors.white,
                                                                                  fontSize: 15, fontFamily: 'PTSerif-Bold', fontWeight: FontWeight.bold,
                                                                                  color: primaryBar,
                                                                                ),
                                                                                textAlign: TextAlign.center,
                                                                              )),
                                                                          /*onPressed:
                                                                              () {
                                                                            Navigator.push(
                                                                              context,
                                                                              MaterialPageRoute(builder: (context) => CCAssessmentPage()),
                                                                            );
                                                                          },*/
                                                                          onPressed: () {
  // Show dialog box to enter pin
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
              String predefinedPin = '142615';

              // Check if the entered pin matches the predefined pin
              if (enteredPin == predefinedPin) {
                // Navigate to the desired page
                Navigator.push( 

                  
                  context,
                  MaterialPageRoute(builder: (context) => DSUnit1()),
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
                                                                                border: Border.all(width: 2.0, color: primaryBar),
                                                                              ),
                                                                              child: Text(
                                                                                'Unit - 2',
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
                                                                              MaterialPageRoute(builder: (context) => DSUnit2()),
                                                                            );
                                                                          },
                                                                        ),
],
                                                                    ),
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
                                                                                border: Border.all(width: 2.0, color: primaryBar),
                                                                              ),
                                                                              child: Text(
                                                                                'Unit - 3',
                                                                                style: TextStyle(
                                                                                  //color: Colors.white,
                                                                                  fontSize: 15, fontFamily: 'PTSerif-Bold', fontWeight: FontWeight.bold,
                                                                                  color: primaryBar,
                                                                                ),
                                                                                textAlign: TextAlign.center,
                                                                              )),
                                                                          onPressed:
                                                                              () {
                                                                            
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
                                        MaterialPageRoute(builder: (context) => DSUnit3()),
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
],
                                                                    ),
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
                                                                                border: Border.all(width: 2.0, color: primaryBar),
                                                                              ),
                                                                              child: Text(
                                                                                'Unit - 4',
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
                                                                              MaterialPageRoute(builder: (context) => DSUnit4()),
                                                                            );
                                                                          },
                                                                        ),
],
                                                                    ),
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
                                                                                border: Border.all(width: 2.0, color: primaryBar),
                                                                              ),
                                                                              child: Text(
                                                                                'Results of Unit - 1',
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
                                                                              MaterialPageRoute(builder: (context) => DSResultUnit1()),
                                                                            );
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
                  MaterialPageRoute(builder: (context) => DSResultUnit1()),
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
],
                                                                    ),
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
                                                                                border: Border.all(width: 2.0, color: primaryBar),
                                                                              ),
                                                                              child: Text(
                                                                                'Results of Unit - 2',
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
                                                                              MaterialPageRoute(builder: (context) => DSResultUnit2()),
                                                                            );
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
                  MaterialPageRoute(builder: (context) => DSResultUnit2()),
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
],
                                                                    ),
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
                                                                                border: Border.all(width: 2.0, color: primaryBar),
                                                                              ),
                                                                              child: Text(
                                                                                'Results of Unit - 3',
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
                                                                              MaterialPageRoute(builder: (context) => DSResultUnit3()),
                                                                            );
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
                  MaterialPageRoute(builder: (context) => DSResultUnit3()),
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
],
                                                                    ),
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
                                                                                border: Border.all(width: 2.0, color: primaryBar),
                                                                              ),
                                                                              child: Text(
                                                                                'Results of Unit - 4',
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
                                                                              MaterialPageRoute(builder: (context) => DSResultUnit4()),
                                                                            );
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
                  MaterialPageRoute(builder: (context) => DSResultUnit4()),
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
],
                                                                    ),
                                                                  ),

                                                                  
                            //],
                          //),
                       // ),
                     
                      ]
                   ),
        ),
                ])),
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
