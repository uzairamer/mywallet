import 'package:flutter/material.dart';

import './CircularColor.dart';

const CircularColorMap = {
  'Red': Colors.red,
  'Pink': Colors.pink,
  'Purple': Colors.purple,
  'Deep Purple': Colors.deepPurple,
  'Indigo': Colors.indigo,
  'Blue': Colors.blue,
  'Light Blue': Colors.lightBlue,
  'Cyan': Colors.cyan,
  'Teal': Colors.teal,
  'Green': Colors.green,
  'Light Green': Colors.lightGreen,
  'Lime': Colors.lime,
  'Yellow': Colors.yellow,
  'Amber': Colors.amber,
  'Orange': Colors.orange,
  'Deep Orange': Colors.deepOrange,
  'Brown': Colors.brown,
  'Grey': Colors.grey,
  'Blue Grey': Colors.blueGrey
};

class CircularColors extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return CircularColorState();
  }
}

class CircularColorState extends State<CircularColors> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.2),
          
        ),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Wrap(
              children: <Widget>[
                CircularColor(Colors.red),
                CircularColor(Colors.pink),
                CircularColor(Colors.purple),
                CircularColor(Colors.deepPurple),
                CircularColor(Colors.indigo),
                CircularColor(Colors.blue),
                CircularColor(Colors.lightBlue),
                CircularColor(Colors.cyan),
                CircularColor(Colors.teal),
                CircularColor(Colors.green),
                CircularColor(Colors.lightGreen),
                CircularColor(Colors.lime),
                CircularColor(Colors.yellow),
                CircularColor(Colors.amber),
                CircularColor(Colors.orange),
                CircularColor(Colors.deepOrange),
                CircularColor(Colors.brown),
                CircularColor(Colors.grey),
                CircularColor(Colors.blueGrey),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
