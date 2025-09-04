import 'package:flutter/material.dart';
import 'package:stela_app/constants/colors.dart';
import 'package:stela_app/constants/userDetails.dart';
import 'package:stela_app/screens/profile.dart';
import 'package:stela_app/screens/subjects.dart';
import 'package:stela_app/screens/new_test/AnubhavTesttList.dart';
import 'package:stela_app/screens/NumpyexperimentList copy.dart';
import 'package:stela_app/screens/MatplotlibexperimentList copy.dart';
import 'package:stela_app/screens/PandasexperimentList copy.dart';
import 'package:stela_app/screens/SeabornexperimentList copy.dart';
import 'package:stela_app/screens/TensorflowexperimentList copy.dart';
import 'package:stela_app/screens/SklearnexperimentList copy.dart';
import 'package:stela_app/screens/PytorchexperimentList copy.dart';
import 'package:stela_app/screens/AIPTCodingAssessmentexperimentList.dart';
import 'package:stela_app/screens/AIPTcodingTestResults.dart';

import 'AnubhavTesttList.dart';



var expNum;

class CCtutorial extends StatefulWidget {
  @override
  _CCtutorialState createState() => _CCtutorialState();
}

class _CCtutorialState extends State<CCtutorial> {

  @override
  Widget build(BuildContext context) {
    bool isFaculty = enrollmentNo == "FACULTY" || enrollmentNo == "Faculty";


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
                        child: Text('OPERATING SYSTEM TUTORIAL',
                            style: TextStyle(
                              fontSize: 20,
                              fontFamily: 'PTSerif-Bold',
                              fontWeight: FontWeight.w900,
                            ))),
                    /*Container(
                          width: 50,
                          margin: EdgeInsets.all(10),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(150),
                            /*child: Image(
                              image: NetworkImage(
                                  'https://png.pngitem.com/pimgs/s/77-775088_take-the-free-assessment-findings-icon-png-transparent.png'),
                            ),*/
                          ),
                        ),*/
                    TextButton(
                      child: Container(
                          width: double.infinity,
                          padding: EdgeInsets.symmetric(vertical: 5),
                          decoration: BoxDecoration(
                            color: primaryButton,
                            borderRadius: BorderRadius.circular(10),
                            border:
                            Border.all(width: 2.0, color: primaryBar),
                          ),
                          child: Text(
                            'Cloud Computing',
                            style: TextStyle(
                              //color: Colors.white,
                              fontSize: 15,
                              fontFamily: 'PTSerif-Bold',
                              fontWeight: FontWeight.bold,
                              color: primaryBar,
                            ),
                            textAlign: TextAlign.center,
                          )),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => CClist()),
                        );
                      },
                    ),
                    // ],
                    // ),
                    //  ),
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
