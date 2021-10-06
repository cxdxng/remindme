import 'package:flutter/material.dart';
import 'package:remindme/PersonInfo.dart';
import 'package:remindme/Worker.dart';

void main() {
  runApp(MaterialApp(
    routes: {
      "/": (context) => Home(),
      "/personInfo": (context) => PersonInfo(),
    },
  ));
}

class Home extends StatefulWidget {
  const Home({Key key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<String> test = [
    "Theresa Sommerhäuser (Datum)",
    "Jakob Schneider (Datum)",
    "Lena Hersch (Datum)",
    "Lisa Kelzenberg (Datum)",
  ];

  List<String> test1 = [
    "Theresa Sommerhäuser",
    "Theresa Sommerhäuser",
    "Theresa Sommerhäuser",
    "Theresa Sommerhäuser",
    "Theresa Sommerhäuser",
    "Theresa Sommerhäuser",
    "Theresa Sommerhäuser",
    "Theresa Sommerhäuser",
    "Theresa Sommerhäuser",
    "Theresa Sommerhäuser",
    "Theresa Sommerhäuser",
    "Theresa Sommerhäuser",
    "Theresa Sommerhäuser",
    "Theresa Sommerhäuser",
    "Theresa Sommerhäuser",
    "Theresa Sommerhäuser",
    "Theresa Sommerhäuser",
    "Theresa Sommerhäuser",
    "Theresa Sommerhäuser",
    "Jakob Schneider",
    "Lena Hersch",
    "Lisa Kelzenberg",
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(top: 25),
              child: Text(
                "Demnächst",
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.w900),
              ),
            ),
            ListView.builder(
              shrinkWrap: true,
              padding: const EdgeInsets.all(10),
              itemCount: test.length,
              itemBuilder: (BuildContext context, int index) {
                return InkWell(
                  onTap: () {
                    showAlertDialog(context, index);
                  },
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(
                        test[index],
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                  ),
                );
              },
            ),
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Divider(
                thickness: 2,
                color: Colors.grey[200],
              ),
            ),
            Padding(
              padding: EdgeInsets.all(10),
              child: Text(
                "Alle",
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.w900),
              ),
            ),
            Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                padding: const EdgeInsets.all(10),
                itemCount: test1.length,
                itemBuilder: (BuildContext context, int index) {
                  return Card(
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(
                        test1[index],
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  showAlertDialog(BuildContext context, int index) {
    var info = BackgroundWorker().getDataFromPerson(test[index]);
    // set up the button
    Widget okButton = TextButton(
      child: Text("OK"),
      onPressed: () => Navigator.pop(context),
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Bithday is at"),
      content: Text(test[index]),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
