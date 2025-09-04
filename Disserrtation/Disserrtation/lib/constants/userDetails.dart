import 'package:cloud_firestore/cloud_firestore.dart';

var userUID;

String name = "",
    email = "",
    enrollmentNo = "",
    contactNum = "",
    password = "",
    confirmPassword = "",
    userRole="";

Map<String, dynamic>? data, document;
var userDetails;

void getDetails() async {
  userDetails = await FirebaseFirestore.instance
      .collection('students')
      .doc(userUID)
      .get(); //gets user

  data = userDetails.data(); //gets details in the form of a map

  /*contactNum = data?['contactNumber'];
  email = data?['emailAddress'];
  enrollmentNo = data?['enrollmentNumber'];
  name = data?["name"];
  password = data?["password"];*/
  name = data?["name"];
  email = data?['emailAddress'];
  enrollmentNo = data?['enrollmentNumber'];
  contactNum = data?['contactNumber'];
  userRole = data?['userRole'];
  //getAssessmentLink();
}

/*void getAssessmentLink() async {
  final assesmentLinks = await FirebaseFirestore.instance
      .collection('assessments')
      .doc('Assessments')
      .get(); //gets user

  document = assesmentLinks.data();
}*/
