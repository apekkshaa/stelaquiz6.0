import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:stela_app/screens/globals.dart';
import 'package:stela_app/constants/userDetails.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:stela_app/constants/colors.dart'; // <<-- added import

class OSReportUnit1 extends StatefulWidget {
  const OSReportUnit1({super.key});
  @override
  _OSReportUnit1State createState() => _OSReportUnit1State();
}

class _OSReportUnit1State extends State<OSReportUnit1> {
  String? totalMarks;
  String? code;
  String? starttime;
  String? endtime;
  String? expname;
  String? duration;
  String? universityName;
  String? courseName;
  String? examTypeName;
  String? place;
  String? studentSign;

  late Future<void> _fetchDataFuture;

  @override
  void initState() {
    super.initState();
    _fetchDataFuture = fetchDataFromDatabase();
  }

  Future<DatabaseReference> _getDatabaseRef() async {
    try {
      if (Firebase.apps.isEmpty) {
        await Firebase.initializeApp();
      }
      return FirebaseDatabase.instance.ref();
    } catch (e) {
      rethrow;
    }
  }

  Future<void> fetchDataFromDatabase() async {
    try {
      final DatabaseReference databaseReference = await _getDatabaseRef();

      final String enrollKey = (enrollmentNo ?? '').toString();
      if (enrollKey.isEmpty) return;

      final DatabaseEvent event =
          await databaseReference.child('OS-Unit1').child(enrollKey).once();

      final snapshotValue = event.snapshot.value;
      if (snapshotValue != null) {
        final Map<String, dynamic> values =
            Map<String, dynamic>.from(snapshotValue as Map<dynamic, dynamic>);

        if (!mounted) return;
        setState(() {
          totalMarks = values['3_Marks obtained']?.toString() ?? '';
          code = values['9_Code']?.toString() ?? '';
          starttime = values['7_Start time']?.toString() ?? '';
          endtime = values['8_End time']?.toString() ?? '';
          expname = values['10_Aim']?.toString() ?? '';
          duration = values['11_Duration']?.toString() ?? '';
          universityName = values['12_University Name']?.toString() ?? '';
          courseName = values['13_Course Name']?.toString() ?? '';
          examTypeName = values['14_Exam Type']?.toString() ?? '';
          place = values['15_Place']?.toString() ?? '';
        });
      }
    } catch (e) {
      // ignore: avoid_print
      print('fetchDataFromDatabase error: $e');
    }
  }

  Future<void> _printPdf() async {
    final pdf = pw.Document();

    final String uni = universityName ?? '';
    final String course = courseName ?? '';
    final String examType = examTypeName ?? '';
    final String pl = place ?? '';
    final String nm = name ?? '';
    final String enroll = enrollmentNo ?? '';
    final String st = starttime ?? '';
    final String et = endtime ?? '';
    final String dur = duration ?? '';
    final String marks = totalMarks ?? '';
    final String sSign = studentSign ?? '';

    pdf.addPage(
      pw.Page(
        build: (pw.Context context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Center(
                child: pw.Text(
                  'Report of OS Unit-1',
                  style: pw.TextStyle(fontSize: 20, fontWeight: pw.FontWeight.bold),
                ),
              ),
              pw.SizedBox(height: 20),
              pw.RichText(
                text: pw.TextSpan(
                  children: [
                    pw.TextSpan(text: 'University Name: ',
                        style: pw.TextStyle(fontSize: 17, fontWeight: pw.FontWeight.bold)),
                    pw.TextSpan(text: uni, style: pw.TextStyle(fontSize: 16)),
                  ],
                ),
              ),
              pw.SizedBox(height: 6),
              pw.RichText(
                text: pw.TextSpan(
                  children: [
                    pw.TextSpan(text: 'Course Name: ',
                        style: pw.TextStyle(fontSize: 17, fontWeight: pw.FontWeight.bold)),
                    pw.TextSpan(text: course, style: pw.TextStyle(fontSize: 16)),
                  ],
                ),
              ),
              pw.SizedBox(height: 6),
              pw.RichText(
                text: pw.TextSpan(
                  children: [
                    pw.TextSpan(text: 'Exam Type: ',
                        style: pw.TextStyle(fontSize: 17, fontWeight: pw.FontWeight.bold)),
                    pw.TextSpan(text: examType, style: pw.TextStyle(fontSize: 16)),
                  ],
                ),
              ),
              pw.SizedBox(height: 6),
              pw.RichText(
                text: pw.TextSpan(
                  children: [
                    pw.TextSpan(text: 'Place: ',
                        style: pw.TextStyle(fontSize: 17, fontWeight: pw.FontWeight.bold)),
                    pw.TextSpan(text: pl, style: pw.TextStyle(fontSize: 16)),
                  ],
                ),
              ),
              pw.SizedBox(height: 10),
              pw.RichText(
                text: pw.TextSpan(
                  children: [
                    pw.TextSpan(text: 'Student Name: ',
                        style: pw.TextStyle(fontSize: 17, fontWeight: pw.FontWeight.bold)),
                    pw.TextSpan(text: nm, style: pw.TextStyle(fontSize: 16)),
                  ],
                ),
              ),
              pw.SizedBox(height: 6),
              pw.RichText(
                text: pw.TextSpan(
                  children: [
                    pw.TextSpan(text: 'Enrollment Number: ',
                        style: pw.TextStyle(fontSize: 17, fontWeight: pw.FontWeight.bold)),
                    pw.TextSpan(text: enroll, style: pw.TextStyle(fontSize: 16)),
                  ],
                ),
              ),
              pw.SizedBox(height: 6),
              pw.RichText(
                text: pw.TextSpan(
                  children: [
                    pw.TextSpan(text: 'Start time: ',
                        style: pw.TextStyle(fontSize: 17, fontWeight: pw.FontWeight.bold)),
                    pw.TextSpan(text: st, style: pw.TextStyle(fontSize: 16)),
                  ],
                ),
              ),
              pw.SizedBox(height: 6),
              pw.RichText(
                text: pw.TextSpan(
                  children: [
                    pw.TextSpan(text: 'End time: ',
                        style: pw.TextStyle(fontSize: 17, fontWeight: pw.FontWeight.bold)),
                    pw.TextSpan(text: et, style: pw.TextStyle(fontSize: 16)),
                  ],
                ),
              ),
              pw.SizedBox(height: 6),
              pw.RichText(
                text: pw.TextSpan(
                  children: [
                    pw.TextSpan(text: 'Total Duration: ',
                        style: pw.TextStyle(fontSize: 17, fontWeight: pw.FontWeight.bold)),
                    pw.TextSpan(text: dur, style: pw.TextStyle(fontSize: 16)),
                  ],
                ),
              ),
              pw.SizedBox(height: 6),
              pw.RichText(
                text: pw.TextSpan(
                  children: [
                    pw.TextSpan(text: 'Total Marks out of 20: ',
                        style: pw.TextStyle(fontSize: 17, fontWeight: pw.FontWeight.bold)),
                    pw.TextSpan(text: marks, style: pw.TextStyle(fontSize: 16)),
                  ],
                ),
              ),
              pw.SizedBox(height: 40),
              pw.RichText(
                text: pw.TextSpan(
                  children: [
                    pw.TextSpan(text: 'Student Signature: ',
                        style: pw.TextStyle(fontSize: 17, fontWeight: pw.FontWeight.bold)),
                    pw.TextSpan(text: sSign, style: pw.TextStyle(fontSize: 16)),
                  ],
                ),
              ),
              pw.SizedBox(height: 20),
              pw.RichText(
                text: pw.TextSpan(
                  children: [
                    pw.TextSpan(text: 'Faculty Signature: ',
                        style: pw.TextStyle(fontSize: 17, fontWeight: pw.FontWeight.bold)),
                    pw.TextSpan(text: '', style: pw.TextStyle(fontSize: 16)),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );

    await Printing.layoutPdf(onLayout: (PdfPageFormat format) async => pdf.save());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('OS REPORT'),
        backgroundColor: primaryBar,
        actions: [
          IconButton(
            icon: const Icon(Icons.file_download),
            onPressed: () async {
              try {
                await fetchDataFromDatabase();
                await _printPdf();
              } catch (e) {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Print failed: $e')));
              }
            },
          ),
        ],
      ),
      body: FutureBuilder<void>(
        future: _fetchDataFuture,
        builder: (context, AsyncSnapshot<void> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 10),
                  const Center(
                    child: Text('Report of OS-Unit1', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  ),
                  const SizedBox(height: 20),
                  _labelValue("University Name:", universityName),
                  _labelValue("Course Name:", courseName),
                  _labelValue("Exam Type:", examTypeName),
                  _labelValue("Place:", place),
                  _labelValue("Student Name:", name),
                  _labelValue("Enrollment Number:", enrollmentNo),
                  _labelValue("Start time:", starttime),
                  _labelValue("End time:", endtime),
                  _labelValue("Total Duration:", duration),
                  _labelValue("Total Marks out of 20:", totalMarks),
                  const SizedBox(height: 40),
                  const Text("Student Sign: ", style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
                  SizedBox(
                    width: 300,
                    child: TextField(
                      onChanged: (newValue) {
                        setState(() {
                          studentSign = newValue;
                        });
                      },
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text("Faculty Sign: ", style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _labelValue(String label, String? value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: RichText(
        text: TextSpan(
          style: const TextStyle(color: Colors.black),
          children: [
            TextSpan(text: "$label ", style: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
            TextSpan(text: value ?? '', style: const TextStyle(fontSize: 16)),
          ],
        ),
      ),
    );
  }
}