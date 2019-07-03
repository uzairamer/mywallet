import 'package:flutter/material.dart';

class CircularColorDropdownItem extends StatelessWidget{

  final Color color;
  final String colorName;

  const CircularColorDropdownItem({Key key, this.color, this.colorName}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Row(children: <Widget>[
      Container(width: 30, height: 30, decoration: BoxDecoration(shape: BoxShape.circle, color: this.color),),
      Padding(
        padding: const EdgeInsets.only(left: 8.0),
        child: Text(this.colorName),
      )
    ],);
  }
}