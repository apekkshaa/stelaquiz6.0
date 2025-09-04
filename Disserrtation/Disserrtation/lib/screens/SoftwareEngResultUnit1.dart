import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';

// ignore: import_of_legacy_library_into_null_safe
import 'package:csv/csv.dart';
import 'package:universal_html/html.dart' as html;

class SEResultUnit1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Firebase Table Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: COAMCQTablePage(),
    );
  }
}

class COAMCQTablePage extends StatefulWidget {
  @override
  _COAMCQTablePageState createState() => _COAMCQTablePageState();
}

class _COAMCQTablePageState extends State<COAMCQTablePage> {
  final DatabaseReference databaseReference = FirebaseDatabase.instanceFor(
    app: Firebase.app(),
    databaseURL: "https://stela23-f9a52-default-rtdb.asia-southeast1.firebasedatabase.app",
  ).ref();

  List<String> secondColumnData = [];
  List<String> thirdColumnData = [];

  @override
  void initState() {
    super.initState();
    getDataFromFirebase();
  }

  void getDataFromFirebase() {
    databaseReference.child('SE-Unit1').once().then((DatabaseEvent event) {
      if (event.snapshot.value != null) {
        Map<dynamic, dynamic>? values = event.snapshot.value as Map<dynamic, dynamic>?;


          List<String> data1 = [];
          List<String> data3 = [];

          values?.forEach((key, value) {

              // Add the name of the child node to data list (second column)
              data1.add(key.toString());
              String totalMarks =value == null ?"N/A": value['3_Marks obtained'].toString();
              data3.add(totalMarks);

          });
          setState(() {
            secondColumnData = data1;
            thirdColumnData = data3;
          });

      }
    });
  }

  void _exportToExcel() async {
    List<List<dynamic>> rows = [];

    // Add header row
    rows.add([
      'Serial number',
      'Enrollment Number',
      'Total marks out of 20',
      //'Experiment 2',
      // Add more headers as needed for other columns
    ]);

    // Add data rows
    for (int i = 0; i < secondColumnData.length; i++) {
      rows.add([
        (i + 1).toString(),
        secondColumnData[i],
        thirdColumnData.elementAt(i),
        // Add more data columns as needed
      ]);
    }

    String csv = const ListToCsvConverter().convert(rows);

    // Create a blob containing the CSV data
    final List<int> data = utf8.encode(csv);
    final blob = html.Blob([data]);

    // Create a URL for the blob
    final url = html.Url.createObjectUrlFromBlob(blob);

    // Create an anchor element
    final anchor = html.AnchorElement(href: url)
      ..setAttribute("download", "SE-Unit1_MCQ_Results.csv")
      ..style.display = 'none';

    // Trigger a download
    html.document.body!.children.add(anchor);
    anchor.click();

    // Clean up
    html.document.body!.children.remove(anchor);
    html.Url.revokeObjectUrl(url);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('MCQ ASSESSMENT RESULTS'),
        actions: [
          IconButton(
            icon: Icon(Icons.file_download),
            onPressed: _exportToExcel,
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Table(
          border: TableBorder.all(),
          columnWidths: {
            for (int i = 0; i < 13; i++) i: FlexColumnWidth(1.0),
          },
          children: List.generate(
            secondColumnData.length + 1, // Adjusted for headings
            (index) => TableRow(
              children: [
                // Serial number column
                TableCell(
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      (index == 0) ? 'Serial number' : '$index',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.bold, // Make the text bold
                      ),
                    ),
                  ),
                ),
                // Heading for second column
                if (index == 0)
                  TableCell(
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        'Enrollment Number',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontWeight: FontWeight.bold, // Make the text bold
                        ),
                      ),
                    ),
                  )
                else
                  // Populate the second column with Firebase data
                  TableCell(
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        (index <= secondColumnData.length) ? secondColumnData[index - 1] : '',
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),

                if (index == 0)
                  TableCell(
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        'Total Marks out of 20',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontWeight: FontWeight.bold, // Make the text bold
                        ),
                      ),
                    ),
                  )
                else
                  // Populate the second column with Firebase data
                  TableCell(
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        (index <= thirdColumnData.length) ? thirdColumnData[index - 1] : '',
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
