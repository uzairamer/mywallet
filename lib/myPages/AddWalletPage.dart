import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../myWidgets/CircularColors.dart';
import '../myWidgets/CircularColorDropdownItem.dart';
// import '../myDatabase/myModels/WalletModel.dart';
import '../moor/moor_database.dart';
// import '../myDatabase/DatabaseHelper.dart';

class AddWalletPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).canvasColor,
      appBar: AppBar(
        title: Text('Add New Wallet'),
      ),
      body: AddWalletFormWidget(),
    );
  }
}

class AddWalletFormWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return AddWalletFormWidgetState();
  }
}

class AddWalletFormWidgetState extends State<AddWalletFormWidget> {
  String name;
  String description;
  double initalAmount;
  String materialColorStr;
  String currency =
      'PKR'; // by default value because this dropdown is currently disabled

  @override
  Widget build(BuildContext context) {
    final database = Provider.of<AppDatabase>(context);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListView(
        children: <Widget>[
          TextField(
            maxLength: 9,
            maxLengthEnforced: true,
            textCapitalization: TextCapitalization.words,
            decoration: InputDecoration(
              labelText: 'Name of Wallet e.g. MCB or My Pocket',
            ),
            onChanged: (value) {
              setState(() {
                this.name = value;
              });
            },
          ),

          TextField(
            maxLength: 64,
            maxLengthEnforced: true,
            textCapitalization: TextCapitalization.words,
            decoration: InputDecoration(
              labelText: 'Description (optional)',
            ),
            onChanged: (value) {
              setState(() {
                this.description = description;
              });
            },
          ),

          TextField(
            maxLength: 8,
            maxLengthEnforced: true,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              labelText: 'Initial Amount e.g. 5000',
            ),
            onChanged: (value) {
              setState(() {
                this.initalAmount = double.parse(value);
              });
            },
          ),

          // Center(
          //   child: Padding(
          //     padding: const EdgeInsets.only(top: 15.0, bottom: 15),
          //     child: Text('Choose Wallet color'),
          //   ),
          // ),

          // Row of dropdowns
          Padding(
            padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                DropdownButton<String>(
                  onChanged: (value) {
                    setState(() {
                      this.materialColorStr = value;
                    });
                  },
                  hint: Text('Color for Wallet'),
                  value: materialColorStr,
                  items: CircularColorMap.keys.map(
                    (String key) {
                      return DropdownMenuItem<String>(
                        child: CircularColorDropdownItem(
                          color: CircularColorMap[key],
                          colorName: key,
                        ),
                        value: key,
                      );
                    },
                  ).toList(),
                ),
                DropdownButton<String>(
                    onChanged: (value) {
                      setState(() {
                        this.currency = value;
                      });
                    },
                    disabledHint: Text('PKR'),
                    hint: Text('Currency'),
                    value: this.currency,
                    items: null
                    // <DropdownMenuItem<String>>[
                    //   DropdownMenuItem<String>(child: Text('PKR'), value: 'PKR',),
                    // ],

                    ),
              ],
            ),
          ),

          FlatButton(
            color: Theme.of(context).primaryColor,
            child: Text(
              'Add Wallet',
              style: TextStyle(color: Colors.white),
            ),
            onPressed: () {
              print('Going to add wallet');
              Wallet wallet = Wallet(
                  name: this.name,
                  description: this.description,
                  currency: this.currency,
                  color: this.materialColorStr,
                  initialAmount: this.initalAmount,
                  deleted: false);
              // WalletModel w = new WalletModel();
              // w.name = this.name;
              // w.description = this.description;
              // w.currency = this.currency;
              // w.color = this.materialColorStr;
              // w.initialAmount = this.initalAmount;
              // DatabaseHelper.instance.insert(w.getTableName(), w).then((onValue){
              //   Navigator.of(context).pop(true);
              // }).catchError((onError){
              //   Navigator.of(context).pop(false);
              // });
              database.insertWallet(wallet).then((onValue) {
                Navigator.of(context).pop(true);
              }).catchError((onError) {
                Navigator.of(context).pop(false);
              });
            },
          ),
        ],
      ),
    );
  }
}
