import 'package:flutter/material.dart';
import 'package:mywallet/Utils.dart';

import '../moor/moor_database.dart';
import '../myPages/TransactionDetailPage.dart';

class TransactionListItem extends StatelessWidget {
  final TransactionWithWalletAndCategory transaction;
  final Function onDelete;

  const TransactionListItem({Key key, this.transaction, this.onDelete}) : super(key: key);

  _dismissDialog(BuildContext context) {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    Color textColor = Theme.of(context).primaryColorDark;
    Wallet wallet = this.transaction.wallet;
    Transaction transaction = this.transaction.transaction;
    String formattedDateTime = dateTime_yMedjm(transaction.datetime);

    return InkWell(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => TransactionDetailPage(this.transaction)));
      },
      onLongPress: () {
        showDialog(
            context: context,
            builder: (context) {
              return SimpleDialog(
                title: Text('Delete Transaction'),
                children: <Widget>[
                  SimpleDialogOption(
                    child: Text('Delete & Refund to Wallet'),
                    onPressed: () {
                      onDelete(this.transaction, true); // refund = true
                      _dismissDialog(context);
                    },
                  ),
                  SimpleDialogOption(
                    child: Text('Delete & No Refund'),
                    onPressed: () {
                      onDelete(this.transaction, false); // refund = true
                      _dismissDialog(context);
                    },
                  ),
                ],
              );
            });
      },
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
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
                        '${transaction.transactionType == 0 ? "To" : "From"} ${wallet.name}',
                        style: TextStyle(fontSize: 16.0, color: textColor),
                      ),
                    ),
                    Text(
                      formattedDateTime,
                      style: TextStyle(fontSize: 14.0, color: textColor),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
