import 'package:flutter/material.dart';
import 'package:flutter_fab_dialer/flutter_fab_dialer.dart';
// import 'package:fluttertoast/fluttertoast.dart';
import './moor/moor_database.dart';
import 'package:provider/provider.dart';
import 'package:easy_alert/easy_alert.dart';

import './myWidgets/WalletWidget.dart';
import './myWidgets/AddWalletWidget.dart';
import './myWidgets/TransactionListItem.dart';

import './myPages/AddWalletPage.dart';
import './myPages/AddTransactionPage.dart';

// import './myDatabase/DatabaseHelper.dart';
// import './myDatabase/myModels/Model.dart';
// import './myDatabase/myModels/WalletModel.dart';
// import './myDatabase/myModels/TransactionModel.dart';

void main() => runApp(AlertProvider(child: MyApp()));

class AddWalletWidgetClickable extends StatelessWidget {
  // final Function addWalletCallback;
  AddWalletWidgetClickable();

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        final bool result = await Navigator.push(
            context, MaterialPageRoute(builder: (context) => AddWalletPage()));
        String response = '';
        if (result)
          response = 'New Wallet has been added.';
        else
          response =
              'There was an error while adding the Wallet. Perhaps you should check the name';
        // this.addWalletCallback();
        // Fluttertoast.showToast(
        //     msg: response,
        //     toastLength: Toast.LENGTH_LONG,
        //     gravity: ToastGravity.BOTTOM,
        //     backgroundColor: Theme.of(context).accentColor,
        //     textColor: Colors.white,
        //     fontSize: 16.0);
      },
      child: AddWalletWidget(),
    );
  }
}

class MyApp extends StatelessWidget {
  final String appName = "Auditor";

  @override
  Widget build(BuildContext context) {
    return Provider(
      builder: (_) => AppDatabase(),
      child: MaterialApp(
        title: this.appName,
        theme: ThemeData(
          primarySwatch: Colors.blueGrey,
        ),
        home: MyHomePage(title: this.appName),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

typedef void MyAddWalletCallback();

class _MyHomePageState extends State<MyHomePage> {
  List<Widget> wallets;
  List<Widget> transactionList;
  // List<Model> transactionModels = List();
  // List<WalletModel> wms = List();
  String totalRemainingAmountWithCurrency = "";

  void _onAddTransaction() async {
    bool result = await Navigator.push(
        context, MaterialPageRoute(builder: (context) => AddTransactionPage()));
  }

  void _onAddWallet(BuildContext context) async {
    final bool result = await Navigator.push(
        context, MaterialPageRoute(builder: (context) => AddWalletPage()));

    String response = '';
    if (result)
      response = 'New Wallet has been added.';
    else
      response =
          'There was an error while adding the Wallet. Perhaps you should check the name';
    Alert.toast(context, response,
        position: ToastPosition.bottom, duration: ToastDuration.long);
  }

  void _onAddCategory() {}

  FabDialer mainFabDialer(BuildContext context) {
    final color = Theme.of(context).accentColor;
    return FabDialer([
      FabMiniMenuItem.withText(
          new Icon(Icons.account_balance_wallet), color, 4.0, "Add Wallet", () {
        this._onAddWallet(context);
      }, "Add Wallet", color, Colors.white, true),
      FabMiniMenuItem.withText(
          new Icon(Icons.category),
          color,
          4.0,
          "Add Category",
          this._onAddCategory,
          "Add Category",
          color,
          Colors.white,
          true),
      FabMiniMenuItem.withText(
          new Icon(Icons.import_export),
          color,
          4.0,
          "Add Transaction",
          this._onAddTransaction,
          "Add Transaction",
          color,
          Colors.white,
          true),
    ], color, Icon(Icons.add));
  }

  // _read() async {
  //   List<Model> transactionModels = await DatabaseHelper.instance
  //       .queryAll(new TransactionModel(), reverse: true);
  //   List<WalletModel> wms = new List();
  //   for (TransactionModel m in transactionModels) {
  //     WalletModel wm = await DatabaseHelper.instance
  //         .query(m.walletId, new WalletModel()) as WalletModel;
  //     wms.add(wm);
  //   }

  //   setState(() {
  //     this.transactionModels = transactionModels;
  //     this.wms = wms;
  //   });

  //   // List of models is returned here and now we need to convert
  //   // it into list of widgets
  //   List<Model> models =
  //       await DatabaseHelper.instance.queryAll(new WalletModel());
  //   List<Widget> walletsMore = [AddWalletWidgetClickable()];

  //   double totalAmount = 0.0;
  //   String curr;

  //   if (models.length > 0) {
  //     print('Lenght of Wallet models: ${models.length}');
  //     models.forEach((mo) {
  //       WalletModel w = mo as WalletModel;
  //       walletsMore.add(WalletWidget(
  //           w.name, w.initialAmount, CircularColorMap[w.color], w.currency));
  //       totalAmount += w.initialAmount;
  //       curr = w.currency;
  //     });
  //   }
  //   setState(() {
  //     wallets = walletsMore;
  //     totalRemainingAmountWithCurrency = curr + " " + totalAmount.toString();
  //   });
  // }

  @override
  void initState() {
    super.initState();
    // wallets = [AddWalletWidgetClickable()];
    // _read();
  }

  // handleTransactionDelete(TransactionModel tm, bool refund) async {
  //   await DatabaseHelper.instance.delete(tm.getTableName(), tm, tm.getId());
  //   if (refund) {
  //     WalletModel wm =
  //         await DatabaseHelper.instance.query(tm.walletId, new WalletModel());
  //     wm.initialAmount = wm.initialAmount + tm.amount;
  //     await DatabaseHelper.instance.update(wm.getTableName(), wm, wm.id);
  //   }
  //   _read();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).canvasColor,
      appBar: AppBar(
        title: Text(widget.title),
      ),
      // floatingActionButton: FloatingActionButton(
      //   child: Icon(Icons.add),
      //   onPressed: () async {
      //     bool result = await Navigator.push(context,
      //         MaterialPageRoute(builder: (context) => AddTransactionPage()));
      //     if (result) {
      //       print('Dope');
      //       // _read();
      //     } else {
      //       print('It was a fucking no');
      //     }
      //   },
      // ),
      body: Builder(
        builder: (BuildContext context) {
          return Stack(
            children: [
              Column(
                children: <Widget>[
                  Container(
                      margin: EdgeInsets.only(top: 5.0),
                      height: 100,
                      child: this._allWalletsBuilder(context)),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          'Money Statistics',
                          style:
                              TextStyle(color: Theme.of(context).primaryColor),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: Container(
                              width: 20,
                              height: 1,
                              color: Theme.of(context).primaryColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      child: Card(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                'Total Amount Available:',
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    fontSize: 20.0,
                                    color: Theme.of(context).primaryColorDark),
                              ),
                              Text(
                                totalRemainingAmountWithCurrency,
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    fontSize: 25.0,
                                    fontWeight: FontWeight.bold,
                                    color: Theme.of(context).primaryColorDark),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          'Most Recent Transactions',
                          style:
                              TextStyle(color: Theme.of(context).primaryColor),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: Container(
                              width: 20,
                              height: 1,
                              color: Theme.of(context).primaryColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Padding(
                        padding: const EdgeInsets.only(
                            left: 8.0, right: 8.0, bottom: 8.0),
                        child: MaterialButton(
                          onPressed: () {
                            Alert.toast(context, 'This is a toast',
                                position: ToastPosition.bottom,
                                duration: ToastDuration.long);
                            // Fluttertoast.showToast(
                            //     msg:
                            //         'There was an error while adding the Wallet. Perhaps you should check the name',
                            //     toastLength: Toast.LENGTH_SHORT,
                            //   gravity: ToastGravity.BOTTOM,
                            //     backgroundColor: Theme.of(context).accentColor,
                            //     textColor: Colors.white,
                            //     fontSize: 16.0);
                          },
                          child: _allTransactionsBuilder(context),
                        )
                        // ListView.builder(
                        //   itemCount: this.transactionModels.length,
                        //   itemBuilder: (BuildContext context, int index) {
                        //     return TransactionListItem(
                        //         trm: this.transactionModels[index],
                        //         wm: this.wms[index],
                        //         onDelete: this.handleTransactionDelete);
                        //   },
                        // ),
                        // // child: ListView(children: (this.transactionList == null || this.transactionList.length == 0) ? [Center(child: Text('Transactions will be shown here'))] : this.transactionList),
                        ),
                  ),
                ],
              ),
              this.mainFabDialer(context)
            ],
          );
        },
      ),
    );
  }

  FutureBuilder _allTransactionsBuilder(BuildContext context) {
    final database = Provider.of<AppDatabase>(context);
    return FutureBuilder(
      // initialData: [CircularProgressIndicator()],
      future: database.getAllTransactions(),
      builder: (context, snapshot) {
        final transactions = snapshot.data ?? [];
        print('Transactions length ${transactions.length}');
        return ListView.builder(
          itemCount: transactions.length,
          itemBuilder: (_, index) {
            final transaction = transactions[index];
            return TransactionListItem(transaction: transaction);
          },
        );
      },
    );
  }

  FutureBuilder _allWalletsBuilder(BuildContext context) {
    final database = Provider.of<AppDatabase>(context);
    return FutureBuilder(
      // initialData: [CircularProgressIndicator()],
      future: database.getAllWallets(),
      builder: (context, snapshot) {
        final wallets = snapshot.data ?? [];
        print('Wallets length ${wallets.length}');
        return ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: wallets.length,
          itemBuilder: (_, index) {
            final wallet = wallets[index];
            return WalletWidget(wallet);
          },
        );
      },
    );
  }
}
