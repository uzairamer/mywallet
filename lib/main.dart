import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_fab_dialer/flutter_fab_dialer.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';

import './moor/moor_database.dart';
import './myWidgets/WalletWidget.dart';
import './myWidgets/TransactionListItem.dart';

import './myPages/AddWalletPage.dart';
import './myPages/AddTransactionPage.dart';

void main() => runApp(MyApp());
final String appName = "Auditor";

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provider(
      builder: (_) => AppDatabase(),
      child: MaterialApp(
        title: appName,
        theme: ThemeData(
          primarySwatch: Colors.blueGrey,
        ),
        home: SplashScreenApp(),
      ),
    );
  }
}

class SplashScreenApp extends StatefulWidget {
  @override
  _SplashScreenAppState createState() => _SplashScreenAppState();
}

class _SplashScreenAppState extends State<SplashScreenApp> {
  Future checkForFirstLoad(BuildContext context) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    if (preferences.getBool('firstTime') ?? false) {
    } else {
      // First time
      final database = Provider.of<AppDatabase>(context);
      await database.insertCategory(Category(deleted: false, name: 'Other'));
      preferences.setBool('firstTime', true);
    }
    Navigator.of(context).pushReplacement(MaterialPageRoute(
      builder: (context) => MyHomePage(
        title: appName,
      ),
    ));
  }

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(milliseconds: 100)).then(
      (_) {
        checkForFirstLoad(context);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Provider(
      builder: (_) => AppDatabase(),
      child: Scaffold(
        body: Container(
          child: Center(
            child: Text('Loading...'),
          ),
        ),
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
  String totalRemainingAmountWithCurrency = "";

  void _onAddTransaction() async {
    await Navigator.push(context, MaterialPageRoute(builder: (context) => AddTransactionPage()));
  }

  void _onAddWallet(BuildContext context) async {
    final bool result = await Navigator.push(context, MaterialPageRoute(builder: (context) => AddWalletPage()));

    String response = '';
    if (result)
      response = 'New Wallet has been added.';
    else
      response = 'There was an error while adding the Wallet. Perhaps you should check the name';
    Flushbar(
      message: response,
      icon: result ? Icon(Icons.check, color: Colors.blue,) : Icon(Icons.error_outline, color: Colors.red,),
      duration: Duration(seconds: 4),
    )..show(context);
//    Alert.toast(context, response, position: ToastPosition.bottom, duration: ToastDuration.long);
  }

  void _onAddCategory() {}

  FabDialer mainFabDialer(BuildContext context) {
    final color = Theme.of(context).accentColor;
    return FabDialer([
      FabMiniMenuItem.withText(new Icon(Icons.account_balance_wallet), color, 4.0, "Add Wallet", () {
        this._onAddWallet(context);
      }, "Add Wallet", color, Colors.white, true),
      FabMiniMenuItem.withText(new Icon(Icons.category), color, 4.0, "Add Category", this._onAddCategory,
          "Add Category", color, Colors.white, true),
      FabMiniMenuItem.withText(new Icon(Icons.import_export), color, 4.0, "Add Transaction", this._onAddTransaction,
          "Add Transaction", color, Colors.white, true),
    ], color, Icon(Icons.add));
  }


  @override
  void initState() {
    super.initState();
  }

  void handleTransactionDelete(
      BuildContext context, TransactionWithWalletAndCategory transaction, bool refundPolicy) async {
    final database = Provider.of<AppDatabase>(context);
    double amount = transaction.transaction.amount;
    int transactionType = transaction.transaction.transactionType;
    double walletAmount = transaction.wallet.initialAmount;

    if (refundPolicy) {
      if (transactionType == 0) { // Add transaction type should be subtracted
        amount *= -1;
      }
      print('Amount to refund is $amount and transaction type is $transactionType');
      await database.updateWallet(transaction.wallet.copyWith(initialAmount: (walletAmount + amount).abs()));
    }
    await database.deleteTransaction(transaction.transaction);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).canvasColor,
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Builder(
        builder: (BuildContext context) {
          return Stack(
            children: [
              Column(
                children: <Widget>[
                  Container(margin: EdgeInsets.only(top: 5.0), height: 100, child: this._watchAllWallets(context)),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          'Money Statistics',
                          style: TextStyle(color: Theme.of(context).primaryColor),
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
                                style: TextStyle(fontSize: 20.0, color: Theme.of(context).primaryColorDark),
                              ),
                              _watchAllWalletsForMoneyStatistics(context)
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
                          style: TextStyle(color: Theme.of(context).primaryColor),
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
                      padding: const EdgeInsets.only(left: 8.0, right: 8.0, bottom: 8.0),
                      child: _watchAllTransactionsBuilder(context),
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

  FutureBuilder totalAmountWithCurrency(BuildContext context) {
    final database = Provider.of<AppDatabase>(context);

    return FutureBuilder(
      future: database.getAllWallets(),
      builder: (context, snapshot) {
        final List<Wallet> wallets = snapshot.data ?? [];
        double amount = 0.0;
        String currency = "";
        wallets.forEach((w) {
          amount += w.initialAmount;
          currency = w.currency; // I know that's not scalable
        });

        return Text(
          "$currency $amount",
          textAlign: TextAlign.left,
          style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold, color: Theme.of(context).primaryColorDark),
        );
      },
    );
  }

  FutureBuilder _allWalletsBuilder(BuildContext context) {
    final database = Provider.of<AppDatabase>(context);
    return FutureBuilder(
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

  StreamBuilder _watchAllWallets(BuildContext context){
    final database = Provider.of<AppDatabase>(context);
    return StreamBuilder(
      stream: database.watchAllWallets(),
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

  StreamBuilder _watchAllWalletsForMoneyStatistics(BuildContext context){
    final database = Provider.of<AppDatabase>(context);
    return StreamBuilder(
      stream: database.watchAllWallets(),
      builder: (context, snapshot) {
        final List<Wallet> wallets = snapshot.data ?? [];
        double amount = 0.0;
        String currency = "";
        wallets.forEach((w) {
          amount += w.initialAmount;
          currency = w.currency; // I know that's not scalable
        });

        return Text(
          "$currency $amount",
          textAlign: TextAlign.left,
          style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold, color: Theme.of(context).primaryColorDark),
        );
      },
    );
  }

  StreamBuilder _watchAllTransactionsBuilder(BuildContext context){
    final database = Provider.of<AppDatabase>(context);
    return StreamBuilder(
      stream: database.watchAllTransactions(),
      builder: (context, snapshot) {
        final transactions = snapshot.data ?? [];
        print('Transactions length ${transactions.length}');
        return ListView.builder(
          itemCount: transactions.length,
          itemBuilder: (_, index) {
            final transaction = transactions[index];
            return TransactionListItem(
              transaction: transaction,
              onDelete: (tr, refundPolicy) => handleTransactionDelete(context, tr, refundPolicy),
            );
          },
        );
      },
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
            return TransactionListItem(
              transaction: transaction,
              onDelete: (tr, refundPolicy) => handleTransactionDelete(context, tr, refundPolicy),
            );
          },
        );
      },
    );
  }

}
