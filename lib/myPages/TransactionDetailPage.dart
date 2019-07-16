import 'package:flutter/material.dart';

import '../myDatabase/myModels/TransactionModel.dart';
import '../myDatabase/myModels/WalletModel.dart';

class TransactionDetailPage extends StatelessWidget {
  final TransactionModel trm;
  final String dateTimeStr;
  final WalletModel wm;
  TransactionDetailPage(this.trm, this.wm, this.dateTimeStr);

  @override
  Widget build(BuildContext context) {
    Color textColor = Theme.of(context).primaryColorDark;
    String addOrSpend = trm.transactionType == 0 ? '+' : '-';

    return Scaffold(
      appBar: AppBar(
        title: Text('Transaction Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Wrap(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Expanded(
                        child: Text(
                      trm.title,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18.0,
                          color: textColor),
                    )),
                    Text(
                      '$addOrSpend ${wm.currency} ${trm.amount.toString()}',
                      style: TextStyle(fontSize: 18.0, color: textColor),
                    )
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Expanded(
                        child: Text(
                          'Wallet Used: ${wm.name}',
                          style: TextStyle(fontSize: 16.0, color: textColor),
                        ),
                      ),
                      Text(
                        dateTimeStr,
                        style: TextStyle(fontSize: 14.0, color: textColor),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: RichText(
                    text: TextSpan(
                        text: 'Description: ',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Theme.of(context).primaryColorDark),
                        children: <TextSpan>[TextSpan(text: trm.description, style: TextStyle(fontSize: 16, fontWeight: FontWeight.normal ,color: Theme.of(context).primaryColorDark),)]),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
