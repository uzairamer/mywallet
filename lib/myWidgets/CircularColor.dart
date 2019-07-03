import 'package:flutter/material.dart';

class CircularColor extends StatelessWidget {
  final Color color;

  CircularColor(this.color);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        Navigator.pop(context);
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(shape: BoxShape.circle, color: this.color),
        ),
      ),
    );
  }
}
