import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

// import '../myDatabase/DatabaseHelper.dart';
import '../myDatabase/myModels/Model.dart';
import '../myDatabase/myModels/WalletModel.dart';
import 'package:moor/moor.dart';
import '../moor/moor_database.dart';
// import '../myDatabase/myModels/TransactionModel.dart';

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
  // String dateAndTime = 'Add Date & Time';
  DateTime dateTime;
  String dateTimeFormatted = 'Add Date & Time';

  // WalletModel currentChosenWallet;
  Wallet currentChosenWallet;

  List<DropdownMenuItem<String>> dropdownItems = new List();
  // List<Model> walletModels = new List();
  List<Wallet> wallets;
  Map<String, int> transactionTypeMap = {
    'Add Amount': 0,
    'Spend Amount': 1,
    'Transfer Amount': 2
  };

  // void getIdsOfWallets() async {
  //   walletModels = await DatabaseHelper.instance.queryAll(new WalletModel());
  //   walletModels.forEach((m) {
  //     WalletModel wm = m as WalletModel;
  //     setState(() {
  //       dropdownItems.add(DropdownMenuItem<String>(
  //         child: Text('${wm.name} - ${wm.currency} ${wm.initialAmount}'),
  //         value: wm.name,
  //       ));
  //     });
  //   });
  // }

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

    // this.walletModels.forEach((m){
    //   WalletModel wm = m as WalletModel;
    //   if(wm.name == walletName){
    //     return wm;
    //   }
    // });
    // return null;
  }

  bool validate() {
    if (this.currentChosenWallet.name == null ||
        this.currentChosenWallet.name == "") {
      Scaffold.of(context).showSnackBar(new SnackBar(
        content: new Text("Please choose a wallet"),
      ));
      return false;
    }

    if (transactionType == null || transactionType == "") {
      Scaffold.of(context).showSnackBar(new SnackBar(
        content: new Text("Please choose a Transaction Type"),
      ));
      return false;
    }

    if (title == "" || title == null) {
      Scaffold.of(context).showSnackBar(new SnackBar(
        content: new Text("Please choose a Title"),
      ));
      return false;
    }

    if (amount == null) {
      Scaffold.of(context).showSnackBar(new SnackBar(
        content: new Text("Please choose an Amount"),
      ));
      return false;
    }
    if (this.amount > this.currentChosenWallet.initialAmount &&
        transactionTypeMap[transactionType] == 1) {
      Scaffold.of(context).showSnackBar(new SnackBar(
        content:
            new Text("Amount is greater than the amount available in wallet"),
      ));
      return false;
    }
    double amountTotal = this.amount + this.currentChosenWallet.initialAmount;
    if (amountTotal < this.amount ||
        amountTotal < this.currentChosenWallet.initialAmount) {
      Scaffold.of(context).showSnackBar(new SnackBar(
        content: new Text("Overflowed. Please choose the Amount appropriately"),
      ));
      return false;
    }
    return true;
  }

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(milliseconds: 100)).then((_) {
      setUpWalletsForDropdown(context);
    });
    // getIdsOfWallets();
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
                // this.walletId = this.currentChosenWallet.id;
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
              items: transactionTypeMap.keys.map((key) {
                return DropdownMenuItem<String>(
                  child: Text(key),
                  value: key,
                );
              }).toList(),
              // [DropdownMenuItem<String>(child: Text('Add Money'), value: 'Add Money',), DropdownMenuItem<String>(child: Text('Spend Money'), value: 'Spend Money',)],
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
            maxLength: 8,
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
                // setState(() {
                //   DateTime
                //   dateAndTime =
                //       '${onValue.year}-${onValue.month}-${onValue.day}';
                // });
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
                    dateTime = new DateTime(date.year, date.month, date.day,
                        onValue.hour, onValue.minute);
                    dateTimeFormatted = DateFormat('yyyy-MM-dd HH:mm')
                        .format(dateTime)
                        .toString();
                  });
                });
              });

              // Future<TimeOfDay> selectedTime = showTimePicker(
              //   initialTime: TimeOfDay.now(),
              //   context: context,
              //   builder: (BuildContext context, Widget child){
              //     return Theme(
              //       data: Theme.of(context),
              //       child: child,
              //     );
              //   }
              // );
            },
          ),

          FlatButton(
            color: Theme.of(context).primaryColor,
            child: Text(
              'Add Transaction',
              style: TextStyle(color: Colors.white),
            ),
            onPressed: () {
              if (validate()) {
                if (transactionTypeMap[transactionType] == 1) {
                  this.amount *= -1; // Spend Amount
                }
                TransactionsCompanion transaction = TransactionsCompanion(
                  amount: Value(this.amount),
                  datetime: Value(this.dateTime),
                  deleted: Value(false),
                  title: Value(this.title),
                  description:
                      Value(this.description ?? 'No Description was Provided'),
                  transactionType:
                      Value(this.transactionTypeMap[this.transactionType]),
                  categoryName: Value('Other'),
                  walletName: Value(this.currentChosenWallet.name),
                );
                Provider.of<AppDatabase>(context)
                    .inserTransaction(transaction)
                    .then((onValue) {
                  Navigator.of(context).pop(true);
                }).catchError((onError) {
                  print(onError);
                  Navigator.of(context).pop(false);
                });
                // DatabaseHelper.instance.update(currentChosenWallet.getTableName(), currentChosenWallet, currentChosenWallet.id).then((onValue){
                //   TransactionModel trm = new TransactionModel();
                //   trm.title = this.title;
                //   trm.description = this.description;
                //   trm.amount = this.amount;
                //   trm.walletId = this.currentChosenWallet.id;
                //   trm.categoryId = null;
                //   trm.transactionType = this.transactionTypeMap[this.transactionType];
                //   trm.dateTime = this.dateAndTime;
                //   DatabaseHelper.instance.insert(trm.getTableName(), trm).then((onValue){
                //     Navigator.of(context).pop(true);
                //   }).catchError((onError){
                //     print('Adding transaction failed: $onError');
                //     Navigator.of(context).pop(false);
                //   });
                // }).catchError((onError){
                //   Scaffold.of(context).showSnackBar(new SnackBar(
                //     content: new Text("There was some error in updating wallets"),
                //   ));
                // });
              }
            },
          ),
        ],
      ),
    );
  }
}
