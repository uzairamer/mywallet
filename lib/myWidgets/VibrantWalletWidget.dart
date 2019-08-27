import 'package:flutter/material.dart';

import '../moor/moor_database.dart';
import '../myWidgets/CircularColors.dart';

class VibrantWalletWidget extends StatelessWidget {
  final Wallet wallet;

  const VibrantWalletWidget({Key key, this.wallet}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    MaterialColor color = CircularColorMap[this.wallet.color];

    return Container(
      width: 200.0,
      height: 80.0,
      margin: EdgeInsets.all(8),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.grey,
            blurRadius: 4.0,
            spreadRadius: 0.5,
            offset: Offset(
              1.5, // horizontal, move right 10
              0.0, // vertical, move down 10
            ),
          )
        ],
        borderRadius: BorderRadius.all(Radius.circular(5)),
        gradient:
            LinearGradient(begin: Alignment.centerLeft, end: Alignment.centerRight, colors: [color[900], color[300]]),
      ),
      child: Stack(
        overflow: Overflow.clip,
        children: <Widget>[
          Positioned(
            height: 200,
            width: 200,
            top: 40,
            right: -20,
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: color[200].withOpacity(0.2),
              ),
            ),
          ),
          Positioned(
            height: 100,
            width: 100,
            right: -20,
            top: -20,
            child: Container(
              decoration: BoxDecoration(shape: BoxShape.circle, color: color[600].withOpacity(0.4)),
            ),
          ),
          Align(
            alignment: Alignment(0, -1),
            child: Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Text(
                wallet.name,
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.white, fontSize: 20, fontFamily: 'Montserrat'),
              ),
            ),
          ),
          Align(
            alignment: Alignment(0, 1),
            child: Padding(
              padding: const EdgeInsets.only(bottom: 10.0, left: 8.0),
              child: Text(
//                "PKR 5555555555.0",
                '${this.wallet.currency} ${this.wallet.initialAmount}',
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold, fontFamily: 'Montserrat'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
