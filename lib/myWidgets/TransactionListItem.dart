import 'package:intl/intl.dart';
import 'package:flutter/material.dart';

import '../myPages/TransactionDetailPage.dart';

import '../myDatabase/myModels/TransactionModel.dart';
import '../myDatabase/myModels/WalletModel.dart';

class TransactionListItem extends StatelessWidget {
  final TransactionModel trm;
  final WalletModel wm;
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

  const TransactionListItem({Key key, this.trm, this.wm}) : super(key: key);

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

  @override
  Widget build(BuildContext context) {
    Color textColor = Theme.of(context).primaryColorDark;
    String addOrSpend = trm.transactionType == 0 ? '+' : '-';
    String dateTime = trm.dateTime == null
        ? 'Date & Time NA'
        : this.dateTimeParser(trm.dateTime);

    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    TransactionDetailPage(this.trm, this.wm, dateTime)));
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
                      dateTime,
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
