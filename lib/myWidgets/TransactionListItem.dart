import 'package:intl/intl.dart';
import 'package:flutter/material.dart';

import '../moor/moor_database.dart';
import '../myPages/TransactionDetailPage.dart';
import '../myDatabase/myModels/WalletModel.dart';

class TransactionListItem extends StatelessWidget {
  // final TransactionModel trm;
  // final WalletModel wm;
  // final Function onDelete;
  final TransactionWithWalletAndCategory transaction;
  final List<String> monthNames = const [
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December'
  ];

  const TransactionListItem({Key key, this.transaction}) : super(key: key);

  String dateTimeParser(String dateTimeStr) {
    final formatter = DateFormat('yyyy-mm-dd hh:mm');
    String timeStr = DateFormat().add_jm().format(formatter.parse(dateTimeStr));

    List<String> dateSplit = dateTimeStr.split(' ');
    List<String> date = dateSplit[0].split('-');
    var dateOnly =
        DateTime(int.parse(date[0]), int.parse(date[1]), int.parse(date[2]));
    String result =
        '${this.monthNames[dateOnly.month - 1]} ${dateOnly.day}, ${dateOnly.year} at $timeStr';
    return result;
  }

  _dismissDialog(BuildContext context) {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    Color textColor = Theme.of(context).primaryColorDark;
    Wallet wallet = this.transaction.wallet;
    Transaction transaction = this.transaction.transaction;
    Category category = this.transaction.category;
    String addOrSpend = transaction.transactionType == 0 ? '+' : '-';
    // String dateTime = this.transaction.datetime == null
    //     ? 'Date & Time NA'
    //     : this.dateTimeParser(trm.dateTime);

    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) {
            print('Transaction tapped');
          }
              // TransactionDetailPage(this.trm, this.wm, dateTime),
              ),
        );
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
                      // onDelete(trm, true); // refund = true
                      _dismissDialog(context);
                    },
                  ),
                  SimpleDialogOption(
                    child: Text('Delete & No Refund'),
                    onPressed: () {
                      // onDelete(trm, false); // refund = true
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
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18.0,
                        color: textColor),
                  )),
                  Text(
                    '$addOrSpend ${wallet.currency} ${transaction.amount.toString()}',
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
                      transaction.datetime.toString(),
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
