import 'package:flutter/material.dart';

import '../moor/moor_database.dart';
import 'package:mywallet/Utils.dart';

class TransactionDetailPage extends StatelessWidget {
  final TransactionWithWalletAndCategory transaction;

  TransactionDetailPage(this.transaction);

  @override
  Widget build(BuildContext context) {
    Color textColor = Theme.of(context).primaryColorDark;
    final transaction = this.transaction.transaction;
    final wallet = this.transaction.wallet;

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
                      transaction.title,
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0, color: textColor),
                    )),
                    Text(
                      '${transaction.transactionType == 1 ? "- " : ""}${wallet.currency} ${transaction.amount.toString()}',
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
                          'Wallet Used: ${wallet.name}',
                          style: TextStyle(fontSize: 16.0, color: textColor),
                        ),
                      ),
                      Text(
                        dateTime_yMedjm(transaction.datetime),
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
                      style: TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold, color: Theme.of(context).primaryColorDark),
                      children: <TextSpan>[
                        TextSpan(
                          text: transaction.description,
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.normal, color: Theme.of(context).primaryColorDark),
                        )
                      ],
                    ),
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
