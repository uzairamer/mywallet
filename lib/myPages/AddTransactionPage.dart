import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:mywallet/Utils.dart';

import '../moor/moor_database.dart';

Map<String, int> TransactionTypeMap = {'Add Amount': 0, 'Spend Amount': 1, 'Transfer Amount': 2};

class AddTransactionPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Transaction'),
      ),
      body: AddTransactionPageForm(),
    );
  }
}

class AddTransactionPageForm extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return AddTransactionPageFormState();
  }
}

class AddTransactionPageFormState extends State<AddTransactionPageForm> {
  int walletId;
  int spentOrAdd;
  double amount;
  String walletName; // chosen wallet name from the dropdown
  String title; // title for the transaction
  String description; // description for the transaction
  String transactionType; // chosen transaction type from the dropdown
  String dateTimeFormatted = 'Add Date & Time';
  DateTime dateTime;
  Wallet currentChosenWallet;
  List<DropdownMenuItem<String>> dropdownItems = new List();
  List<Wallet> wallets;

  void setUpWalletsForDropdown(BuildContext context) async {
    this.wallets = await Provider.of<AppDatabase>(context).getAllWallets();
    wallets.forEach((w) {
      setState(() {
        dropdownItems.add(DropdownMenuItem<String>(
          child: Text('${w.name} - ${w.currency} ${w.initialAmount}'),
          value: w.name,
        ));
      });
    });
  }

  Wallet getWalletFromWalletName(String walletName) {
    for (Wallet wm in this.wallets) {
      if (wm.name == walletName) return wm;
    }
    return null;
  }

  validationFlushBar(BuildContext context, {@required title, @required message}){
    Flushbar(
      title: title,
      message: message,
      duration: Duration(seconds: 4),
      icon: Icon(Icons.info_outline, color: Colors.red,),
      forwardAnimationCurve: Curves.elasticInOut,
      reverseAnimationCurve: Curves.decelerate,
    )..show(context);
  }

  bool validate() {
    if (this.walletName == null || this.walletName == "") {
      validationFlushBar(context, title: "Missing Wallet Name", message: 'Please choose a wallet from the respective Dropdown');
      return false;
    }

    if (transactionType == null || transactionType == "") {
      validationFlushBar(context, title: "Missing Transaction Type", message: 'Please choose a Transaction Type from the respective Dropdown');
      return false;
    }

    if (title == "" || title == null) {
      validationFlushBar(context, title: 'Missing Title', message: 'Please choose a title for this Transaction');
      return false;
    }

    if (amount == null) {
      validationFlushBar(context, title: 'Missing Amount', message: 'Please choose an amount for this Transaction');
      return false;
    }
    if (this.amount > this.currentChosenWallet.initialAmount && TransactionTypeMap[transactionType] == 1) {
      validationFlushBar(context, title: 'Invalid Amount', message: 'Amount cannot be greater than the amount available in Wallet');
      return false;
    }

    double amountTotal = this.amount + this.currentChosenWallet.initialAmount;
    if (amountTotal < this.amount || amountTotal < this.currentChosenWallet.initialAmount) {
      validationFlushBar(context, title: 'Invalid Amount', message: 'Amount oveflowed. Please choose a valid amount');
      return false;
    }

    if (dateTime == null) {
      setState(() {
        dateTime = DateTime.now();
        dateTimeFormatted = dateTime_yMedjm(dateTime);
      });
    }

    return true;
  }

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(milliseconds: 100)).then((_) {
      setUpWalletsForDropdown(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListView(
        children: <Widget>[
          //Choose Wallets
          DropdownButton<String>(
            isExpanded: true,
            onChanged: (value) {
              setState(() {
                print(value);
                this.currentChosenWallet = getWalletFromWalletName(value);
                this.walletName = value;
              });
            },
            hint: Text('Choose Wallet'),
            items: dropdownItems,
            value: walletName,
          ),

          //Transaction type
          DropdownButton<String>(
              isExpanded: true,
              onChanged: (value) {
                setState(() {
                  this.transactionType = value;
                });
              },
              hint: Text('Choose Transaction Type'),
              items: TransactionTypeMap.keys.map((key) {
                return DropdownMenuItem<String>(
                  child: Text(key),
                  value: key,
                );
              }).toList(),
              value: this.transactionType),

          TextField(
            maxLength: 32,
            maxLengthEnforced: true,
            textCapitalization: TextCapitalization.words,
            decoration: InputDecoration(
              labelText: 'Title e.g. Hublot Geneve',
            ),
            onChanged: (value) {
              setState(
                () {
                  this.title = value;
                },
              );
            },
          ),

          TextField(
            maxLength: 128,
            maxLengthEnforced: true,
            textCapitalization: TextCapitalization.words,
            decoration: InputDecoration(
              labelText: 'Description(optional)',
            ),
            onChanged: (value) {
              setState(
                () {
                  this.description = value;
                },
              );
            },
          ),

          TextField(
            maxLength: 10,
            maxLengthEnforced: true,
            keyboardType: TextInputType.number,
            textCapitalization: TextCapitalization.words,
            decoration: InputDecoration(
              labelText: 'Amount',
            ),
            onChanged: (value) {
              setState(
                () {
                  this.amount = double.parse(value);
                },
              );
            },
          ),

          FlatButton(
            color: Theme.of(context).primaryColor,
            child: Text(
              this.dateTimeFormatted,
              style: TextStyle(color: Colors.white),
            ),
            onPressed: () {
              Future<DateTime> selectedDate = showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime(2019),
                lastDate: DateTime(2030),
                builder: (BuildContext context, Widget child) {
                  return Theme(
                    data: Theme.of(context),
                    child: child,
                  );
                },
              );

              selectedDate.then((date) {
                Future<TimeOfDay> selectedTime = showTimePicker(
                    initialTime: TimeOfDay.now(),
                    context: context,
                    builder: (BuildContext context, Widget child) {
                      return Theme(
                        data: Theme.of(context),
                        child: child,
                      );
                    });
                selectedTime.then((onValue) {
                  setState(() {
                    dateTime = new DateTime(date.year, date.month, date.day, onValue.hour, onValue.minute);
                    dateTimeFormatted = dateTime_yMedjm(dateTime);
                  });
                });
              });
            },
          ),

          FlatButton(
            color: Theme.of(context).primaryColor,
            child: Text(
              'Add Transaction',
              style: TextStyle(color: Colors.white),
            ),
            onPressed: () async {
              if (validate()) {
                Transaction transaction = new Transaction(
                  amount: this.amount,
                  datetime: this.dateTime,
                  deleted: false,
                  title: this.title,
                  description: this.description ?? 'No Description was Provided',
                  transactionType: TransactionTypeMap[this.transactionType],
                  categoryName: 'Other',
                  walletName: this.currentChosenWallet.name,
                  id: null,
                );
                if (TransactionTypeMap[transactionType] == 1) {
                  this.amount *= -1; // Spend Amount
                }
                Wallet wallet = this
                    .currentChosenWallet
                    .copyWith(initialAmount: this.currentChosenWallet.initialAmount + this.amount);
                final database = Provider.of<AppDatabase>(context);
                database.inserTransaction(transaction).then(
                  (_) async {
                    database.updateWallet(wallet).then((_) {
                      Navigator.of(context).pop(true);
                    }).catchError((_) async {
                      validationFlushBar(context, title: 'Encountered Error', message: 'There was some error in processing the wallet. Rolling back transaction');
                      await database.deleteTransaction(transaction);
                    });
                  },
                ).catchError(
                  (onError) {
                    print(onError);
                    Navigator.of(context).pop(false);
                  },
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
