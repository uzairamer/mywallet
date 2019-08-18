import 'package:flutter/material.dart';

import '../myWidgets/CircularColors.dart';
import '../moor/moor_database.dart';

class WalletWidget extends StatelessWidget {
  // final String walletName;
  // final double walletAmount;
  final Wallet wallet;

  // color must be of only 100 shade
  // color must be a proper MaterialColor
  // final MaterialColor color;
  // final String currency;

  WalletWidget(this.wallet);

  @override
  Widget build(BuildContext context) {
    MaterialColor color = CircularColorMap[this.wallet.color];
    print('The color is $color from ${this.wallet.color}');

    return InkWell(
      onTap: () {
        // print('${this.walletName} ${this.walletAmount}');
      },
      child: Padding(
        padding: const EdgeInsets.fromLTRB(8.0, 8.0, 4.0, 8.0),
        child: SizedBox(
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                // Wallet name
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      this.wallet.name,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15.0,
                          color: Theme.of(context).primaryColorDark),
                    ),
                  ),
                ),

                // Wallet currency
                // Padding(
                //   padding: const EdgeInsets.all(8.0),
                //   child: Text(
                //     '${this.currency}',
                //     style: TextStyle(fontSize: 12.0, color: Theme.of(context).primaryColorDark)
                //   ),
                // ),

                // Wallet Amount
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                      '${this.wallet.currency}\n${this.wallet.initialAmount}',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 14.0,
                          color: Theme.of(context).primaryColorDark,
                          fontWeight: FontWeight.bold)),
                ),
              ],
            ),
            decoration: BoxDecoration(
                color: color.shade100,
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
                border: Border.all(color: color[500], width: 2.0)),
          ),
          width: 100,
          height: 100,
        ),
      ),
    );
  }
}
