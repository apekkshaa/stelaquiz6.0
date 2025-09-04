import 'package:flutter/material.dart';
import 'package:stela_app/constants/colors.dart';
import 'package:stela_app/constants/userDetails.dart';
import 'package:stela_app/screens/subjects.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SignUp extends StatelessWidget {
  final _auth = FirebaseAuth.instance;
 final List<String> userRoles = ['Admin', 'Faculty', 'Student'];
  @override
  Widget build(BuildContext context) {
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
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    child: Text('SIGN UP',
                        style: TextStyle(
                            fontSize: 25,
                            fontFamily: 'PTSerif',
                            fontWeight: FontWeight.bold)),
                    alignment: Alignment.center,
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Container(
                      child: TextField(
                    showCursor: false,
                    textAlign: TextAlign.center,
                    onChanged: (value) {
                      name = value;
                    },
                    decoration: InputDecoration(
                      hintText: "Enter Name",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                    ),
                  )),
                  SizedBox(
                    height: 15,
                  ),
                  Container(
                      child: TextField(
                    showCursor: false,
                    textAlign: TextAlign.center,
                    keyboardType: TextInputType.number,
                    onChanged: (value) {
                      enrollmentNo = value;
                    },
                    decoration: InputDecoration(
                      hintText: "Enter Enrollment Number",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                    ),
                  )),
                  SizedBox(
                    height: 15,
                  ),
                  Container(
                      child: TextField(
                    showCursor: false,
                    textAlign: TextAlign.center,
                    keyboardType: TextInputType.number,
                    onChanged: (value) {
                      contactNum = value;
                    },
                    decoration: InputDecoration(
                      hintText: "Enter Contact Number",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                    ),
                  )),
                  SizedBox(
                    height: 15,
                  ),
                  Container(
                      child: TextField(
                    showCursor: false,
                    textAlign: TextAlign.center,
                    keyboardType: TextInputType.emailAddress,
                    onChanged: (value) {
                      email = value;
                    },
                    decoration: InputDecoration(
                      hintText: "Enter Email ID",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                    ),
                  )),
                  SizedBox(
                    height: 15,
                  ),
                  Container(
                      child: TextField(
                    showCursor: false,
                    textAlign: TextAlign.center,
                    obscureText: true,
                    onChanged: (value) {
                      password = value;
                    },
                    decoration: InputDecoration(
                      hintText: "Enter Password",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                    ),
                  )),
                  SizedBox(
                    height: 15,
                  ),
                  Container(
                      child: TextField(
                    showCursor: false,
                    textAlign: TextAlign.center,
                    obscureText: true,
                    onChanged: (value) {
                      confirmPassword = value;
                    },
                    decoration: InputDecoration(
                      hintText: "Confirm Password",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                    ),
                  )),
                  SizedBox(
                    height: 15,
                  ),
                    // DropdownButtonFormField for selecting user role
          /* Container(
  padding: EdgeInsets.symmetric(horizontal: 16.0),
  decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(10.0),
    border: Border.all(color: Colors.grey),
  ),
  child: DropdownButtonFormField<String>(
    decoration: InputDecoration(
      hintText: 'Select User Role',
      hintStyle: TextStyle(
        fontSize: 16.0,
        fontWeight: FontWeight.normal,
        color: Colors.grey, // Adjust hint text color if needed
      ),
      border: InputBorder.none,
      contentPadding: EdgeInsets.symmetric(horizontal: 16.0), // Adjust horizontal padding for the content area
    ),
    style: TextStyle(fontSize: 16.0, color: Colors.black), // Adjust text style
    dropdownColor: Colors.white, // Adjust dropdown background color if needed
    icon: Icon(Icons.arrow_drop_down, color: Colors.grey), // Add dropdown icon
    iconEnabledColor: Colors.grey, // Adjust dropdown icon color
    iconSize: 24.0, // Adjust dropdown icon size
    elevation: 8, // Adjust dropdown elevation
    value: userRole.isEmpty ? null : userRole,
    onChanged: (value) {
      userRole = value!;
    },
    items: userRoles.map((role) {
      return DropdownMenuItem<String>(
        value: role,
        child: Container(
          alignment: Alignment.center,
          child: Text(
            role,
            style: TextStyle(
              fontSize: 16.0,
              color: Colors.black,
            ),
          ),
        ),
      );
    }).toList(),
    selectedItemBuilder: (BuildContext context) {
      return userRoles.map<Widget>((String role) {
        return Container(
          alignment: Alignment.center,
          child: Text(
            role,
            style: TextStyle(
              fontSize: 16.0,
              color: Colors.black,
            ),
          ),
        );
      }).toList();
    },
  ),
),


                  SizedBox(
                    height: 15,
                  ),*/
                  TextButton(
                    child: Container(
                        padding:
                            EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                        decoration: BoxDecoration(
                          color: primaryButton,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(width: 2.0, color: primaryBar),
                        ),
                        child: Text(
                          'SIGN UP',
                          style: TextStyle(
                              fontSize: 15,
                              fontFamily: 'PTSerif',
                              fontWeight: FontWeight.bold,
                              color: primaryBar),
                          textAlign: TextAlign.center,
                        )),
                    onPressed: () async {
                      if (password == confirmPassword) {
                        try {
                          final newUser =
                              await _auth.createUserWithEmailAndPassword(
                                  email: email, password: password);

                          final userUID =
                              FirebaseAuth.instance.currentUser?.uid;

                          FirebaseFirestore.instance
                              .collection('students')
                              .doc(userUID)
                              .set({
                            'name': name,
                            'contactNumber': contactNum,
                            'emailAddress': email,
                            'enrollmentNumber': enrollmentNo,
                            'password': password,
                            'userRole': userRole,
                          });
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Subjects()),
                          );
                                                }  catch (e) {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text('Signup Failed, please ensure password is strong or the email id has not been used previously/ check internet'),
                                //content: Text(e.toString()),
                                actions: [
                                  TextButton(
                                    child: Text('OK'),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                ],
                              );
                            },
                          );
                        }
                      }
                    },
                  ),
                  // SizedBox(
                  //   height: 40,
                  // )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
