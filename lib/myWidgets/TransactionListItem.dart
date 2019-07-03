import 'package:flutter/material.dart';

import '../myDatabase/myModels/TransactionModel.dart';
import '../myDatabase/myModels/WalletModel.dart';

class TransactionListItem extends StatelessWidget {
  final TransactionModel trm;
  final WalletModel wm;

  const TransactionListItem({Key key, this.trm, this.wm}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    Color textColor = Theme.of(context).primaryColorDark;
    String addOrSpend = trm.transactionType == 0 ? '+' : '-';
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Expanded(child: Text(trm.title, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0, color: textColor),)),
                Text('$addOrSpend ${wm.currency} ${trm.amount.toString()}', style: TextStyle(fontSize: 18.0, color: textColor), )
            ],),

            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Text('Wallet Used: ${wm.name}', style: TextStyle(fontSize: 16.0, color: textColor),),
            )

          ],
        ),
      ),
    );
  }
}
