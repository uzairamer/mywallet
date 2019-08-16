import 'package:moor_flutter/moor_flutter.dart';

part 'moor_database.g.dart';

class Transactions extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get walletName =>
      text().nullable().customConstraint('NULL REFERENCES wallets(name)')();
  TextColumn get categoryName =>
      text().nullable().customConstraint('NULL REFERENCES categories(name)')();

  // TODO: Check if we need this or not
  IntColumn get transactionType => integer()();
  TextColumn get title => text().withLength(min: 1, max: 32)();
  TextColumn get description => text().nullable()();
  RealColumn get amount => real()();
  DateTimeColumn get datetime => dateTime()();
  BoolColumn get deleted => boolean().withDefault(Constant(false))();
}

class Wallets extends Table {
  // IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text().withLength(min: 1, max: 32)();
  TextColumn get description => text().nullable()();
  TextColumn get color => text()();
  RealColumn get initialAmount => real()();
  TextColumn get currency => text()();
  BoolColumn get deleted => boolean().withDefault(Constant(false))();

  @override
  Set<Column> get primaryKey => {name};
}

@DataClassName('Category')
class Categories extends Table {
  // IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text().withLength(min: 1, max: 32)();
  BoolColumn get deleted => boolean().withDefault(Constant(false))();

  @override
  Set<Column> get primaryKey => {name};
}

@UseMoor(tables: [Transactions, Wallets, Categories])
class AppDatabase extends _$AppDatabase {
  AppDatabase()
      : super((FlutterQueryExecutor.inDatabaseFolder(
          path: 'moor.sqlite',
          logStatements: true,
        )));
  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration => MigrationStrategy(
        beforeOpen: (db, details) async {
          await db.customStatement('PRAGMA foreign_keys = ON');
        },
      );

  Stream<List<TransactionWithWalletAndCategory>> watchAllTransactions() {
    return (select(transactions)
          ..orderBy(
            ([
              (t) =>
                  OrderingTerm(expression: t.datetime, mode: OrderingMode.desc)
            ]),
          ))
        .join(
          [
            leftOuterJoin(
                wallets, wallets.name.equalsExp(transactions.walletName)),
            leftOuterJoin(categories,
                categories.name.equalsExp(transactions.categoryName)),
          ],
        )
        .watch()
        .map((rows) => rows.map(
              (row) {
                return TransactionWithWalletAndCategory(
                  transaction: row.readTable(transactions),
                  wallet: row.readTable(wallets),
                  category: row.readTable(categories),
                );
              },
            ).toList());
  }
}

class TransactionWithWalletAndCategory {
  final Transaction transaction;
  final Wallet wallet;
  final Category category;

  TransactionWithWalletAndCategory(
      {@required this.transaction,
      @required this.wallet,
      @required this.category});
}
