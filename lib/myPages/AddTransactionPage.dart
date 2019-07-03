import 'package:flutter/material.dart';

import '../myDatabase/DatabaseHelper.dart';
import '../myDatabase/myModels/Model.dart';
import '../myDatabase/myModels/WalletModel.dart';
import '../myDatabase/myModels/TransactionModel.dart';


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

  WalletModel currentChosenWallet;

  List<DropdownMenuItem<String>> dropdownItems = new List();
  List<Model> walletModels = new List();
  Map<String, int> transactionTypeMap = {
    'Add Amount': 0,
    'Spend Amount': 1
  };

  void getIdsOfWallets() async{
    walletModels = await DatabaseHelper.instance.queryAll(new WalletModel());
    walletModels.forEach((m){
      WalletModel wm = m as WalletModel;
      setState(() {
        dropdownItems.add(DropdownMenuItem<String>(child: Text('${wm.name} - ${wm.currency} ${wm.initialAmount}'), value: wm.name,));    
      });
    });

  }

  WalletModel getWalletFromString(String walletName){

    for (WalletModel wm in this.walletModels){
      if (wm.name == walletName)
      return wm;
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

  bool validate(){
    if (walletName == null || walletName == ""){
      Scaffold.of(context).showSnackBar(new SnackBar(
            content: new Text("Please choose a wallet"),
          ));
      return false;
    }
    
    if(transactionType == null || transactionType == ""){
      Scaffold.of(context).showSnackBar(new SnackBar(
            content: new Text("Please choose a Transaction Type"),
          ));
      return false;
    }

    if(title == "" || title == null){
      Scaffold.of(context).showSnackBar(new SnackBar(
            content: new Text("Please choose a Title"),
          ));
      return false;
    }

    if(amount == null){
      Scaffold.of(context).showSnackBar(new SnackBar(
            content: new Text("Please choose an Amount"),
          ));
      return false;
    }
    if (this.amount > this.currentChosenWallet.initialAmount  && transactionTypeMap[transactionType] == 1){
      Scaffold.of(context).showSnackBar(new SnackBar(
            content: new Text("Amount is greater than the amount available in wallet"),
          ));
      return false;
    }
    double amountTotal = this.amount + this.currentChosenWallet.initialAmount; 
    if (amountTotal < this.amount || amountTotal < this.currentChosenWallet.initialAmount){
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

    getIdsOfWallets();
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
            onChanged: (value){
              setState(() {
                print(value);
                this.currentChosenWallet = getWalletFromString(value);
                this.walletId = this.currentChosenWallet.id;
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
            onChanged: (value){
              setState(() {
                this.transactionType = value;
              });
            },
            hint: Text('Choose Transaction Type'),
            items: transactionTypeMap.keys.map((key){
              return DropdownMenuItem<String>(child: Text(key), value: key,);
            }).toList(),
            // [DropdownMenuItem<String>(child: Text('Add Money'), value: 'Add Money',), DropdownMenuItem<String>(child: Text('Spend Money'), value: 'Spend Money',)],
            value: this.transactionType

          ),

          TextField(
            maxLength: 32,
            maxLengthEnforced: true,
            textCapitalization: TextCapitalization.words,
            decoration: InputDecoration(
              labelText: 'Title e.g. Hublot Geneve',
            ),
            onChanged: (value) {
              setState(() {
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
              setState(() {
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
              setState(() {
                  this.amount = double.parse(value);
                },
              );
            },
          ),

          FlatButton(
            color: Theme.of(context).primaryColor,
            child: Text(
              'Add Transaction',
              style: TextStyle(color: Colors.white),
            ),
            onPressed: () {
              if (validate()){
                if (transactionTypeMap[transactionType] == 0){ // Add amount
                  this.currentChosenWallet.initialAmount += this.amount;
                }else if(transactionTypeMap[transactionType] == 1){ // Spend Amount
                  this.currentChosenWallet.initialAmount -= this.amount;
                }
                DatabaseHelper.instance.update(currentChosenWallet.getTableName(), currentChosenWallet, currentChosenWallet.id).then((onValue){
                  TransactionModel trm = new TransactionModel();
                  trm.title = this.title;
                  trm.description = this.description;
                  trm.amount = this.amount;
                  trm.walletId = this.currentChosenWallet.id;
                  trm.categoryId = null;
                  trm.transactionType = this.transactionTypeMap[this.transactionType];
                  DatabaseHelper.instance.insert(trm.getTableName(), trm).then((onValue){
                    Navigator.of(context).pop(true);
                  }).catchError((onError){
                    print('Adding transaction failed: $onError');
                    Navigator.of(context).pop(false);
                  });
                }).catchError((onError){
                  Scaffold.of(context).showSnackBar(new SnackBar(
                    content: new Text("There was some error in updating wallets"),
                  ));
                });
              }
            },
          ),

        ],
      ),
    );
  }

}
