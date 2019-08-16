// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'moor_database.dart';

// **************************************************************************
// MoorGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps
class Transaction extends DataClass implements Insertable<Transaction> {
  final int id;
  final String walletName;
  final String categoryName;
  final int transactionType;
  final String title;
  final String description;
  final double amount;
  final DateTime datetime;
  final bool deleted;
  Transaction(
      {@required this.id,
      this.walletName,
      this.categoryName,
      @required this.transactionType,
      @required this.title,
      this.description,
      @required this.amount,
      @required this.datetime,
      @required this.deleted});
  factory Transaction.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final intType = db.typeSystem.forDartType<int>();
    final stringType = db.typeSystem.forDartType<String>();
    final doubleType = db.typeSystem.forDartType<double>();
    final dateTimeType = db.typeSystem.forDartType<DateTime>();
    final boolType = db.typeSystem.forDartType<bool>();
    return Transaction(
      id: intType.mapFromDatabaseResponse(data['${effectivePrefix}id']),
      walletName: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}wallet_name']),
      categoryName: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}category_name']),
      transactionType: intType
          .mapFromDatabaseResponse(data['${effectivePrefix}transaction_type']),
      title:
          stringType.mapFromDatabaseResponse(data['${effectivePrefix}title']),
      description: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}description']),
      amount:
          doubleType.mapFromDatabaseResponse(data['${effectivePrefix}amount']),
      datetime: dateTimeType
          .mapFromDatabaseResponse(data['${effectivePrefix}datetime']),
      deleted:
          boolType.mapFromDatabaseResponse(data['${effectivePrefix}deleted']),
    );
  }
  factory Transaction.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer = const ValueSerializer.defaults()}) {
    return Transaction(
      id: serializer.fromJson<int>(json['id']),
      walletName: serializer.fromJson<String>(json['walletName']),
      categoryName: serializer.fromJson<String>(json['categoryName']),
      transactionType: serializer.fromJson<int>(json['transactionType']),
      title: serializer.fromJson<String>(json['title']),
      description: serializer.fromJson<String>(json['description']),
      amount: serializer.fromJson<double>(json['amount']),
      datetime: serializer.fromJson<DateTime>(json['datetime']),
      deleted: serializer.fromJson<bool>(json['deleted']),
    );
  }
  @override
  Map<String, dynamic> toJson(
      {ValueSerializer serializer = const ValueSerializer.defaults()}) {
    return {
      'id': serializer.toJson<int>(id),
      'walletName': serializer.toJson<String>(walletName),
      'categoryName': serializer.toJson<String>(categoryName),
      'transactionType': serializer.toJson<int>(transactionType),
      'title': serializer.toJson<String>(title),
      'description': serializer.toJson<String>(description),
      'amount': serializer.toJson<double>(amount),
      'datetime': serializer.toJson<DateTime>(datetime),
      'deleted': serializer.toJson<bool>(deleted),
    };
  }

  @override
  T createCompanion<T extends UpdateCompanion<Transaction>>(bool nullToAbsent) {
    return TransactionsCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      walletName: walletName == null && nullToAbsent
          ? const Value.absent()
          : Value(walletName),
      categoryName: categoryName == null && nullToAbsent
          ? const Value.absent()
          : Value(categoryName),
      transactionType: transactionType == null && nullToAbsent
          ? const Value.absent()
          : Value(transactionType),
      title:
          title == null && nullToAbsent ? const Value.absent() : Value(title),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
      amount:
          amount == null && nullToAbsent ? const Value.absent() : Value(amount),
      datetime: datetime == null && nullToAbsent
          ? const Value.absent()
          : Value(datetime),
      deleted: deleted == null && nullToAbsent
          ? const Value.absent()
          : Value(deleted),
    ) as T;
  }

  Transaction copyWith(
          {int id,
          String walletName,
          String categoryName,
          int transactionType,
          String title,
          String description,
          double amount,
          DateTime datetime,
          bool deleted}) =>
      Transaction(
        id: id ?? this.id,
        walletName: walletName ?? this.walletName,
        categoryName: categoryName ?? this.categoryName,
        transactionType: transactionType ?? this.transactionType,
        title: title ?? this.title,
        description: description ?? this.description,
        amount: amount ?? this.amount,
        datetime: datetime ?? this.datetime,
        deleted: deleted ?? this.deleted,
      );
  @override
  String toString() {
    return (StringBuffer('Transaction(')
          ..write('id: $id, ')
          ..write('walletName: $walletName, ')
          ..write('categoryName: $categoryName, ')
          ..write('transactionType: $transactionType, ')
          ..write('title: $title, ')
          ..write('description: $description, ')
          ..write('amount: $amount, ')
          ..write('datetime: $datetime, ')
          ..write('deleted: $deleted')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(
      $mrjc(
          $mrjc(
              $mrjc(
                  $mrjc(
                      $mrjc(
                          $mrjc(
                              $mrjc($mrjc(0, id.hashCode), walletName.hashCode),
                              categoryName.hashCode),
                          transactionType.hashCode),
                      title.hashCode),
                  description.hashCode),
              amount.hashCode),
          datetime.hashCode),
      deleted.hashCode));
  @override
  bool operator ==(other) =>
      identical(this, other) ||
      (other is Transaction &&
          other.id == id &&
          other.walletName == walletName &&
          other.categoryName == categoryName &&
          other.transactionType == transactionType &&
          other.title == title &&
          other.description == description &&
          other.amount == amount &&
          other.datetime == datetime &&
          other.deleted == deleted);
}

class TransactionsCompanion extends UpdateCompanion<Transaction> {
  final Value<int> id;
  final Value<String> walletName;
  final Value<String> categoryName;
  final Value<int> transactionType;
  final Value<String> title;
  final Value<String> description;
  final Value<double> amount;
  final Value<DateTime> datetime;
  final Value<bool> deleted;
  const TransactionsCompanion({
    this.id = const Value.absent(),
    this.walletName = const Value.absent(),
    this.categoryName = const Value.absent(),
    this.transactionType = const Value.absent(),
    this.title = const Value.absent(),
    this.description = const Value.absent(),
    this.amount = const Value.absent(),
    this.datetime = const Value.absent(),
    this.deleted = const Value.absent(),
  });
}

class $TransactionsTable extends Transactions
    with TableInfo<$TransactionsTable, Transaction> {
  final GeneratedDatabase _db;
  final String _alias;
  $TransactionsTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  GeneratedIntColumn _id;
  @override
  GeneratedIntColumn get id => _id ??= _constructId();
  GeneratedIntColumn _constructId() {
    return GeneratedIntColumn('id', $tableName, false, hasAutoIncrement: true);
  }

  final VerificationMeta _walletNameMeta = const VerificationMeta('walletName');
  GeneratedTextColumn _walletName;
  @override
  GeneratedTextColumn get walletName => _walletName ??= _constructWalletName();
  GeneratedTextColumn _constructWalletName() {
    return GeneratedTextColumn('wallet_name', $tableName, true,
        $customConstraints: 'NULL REFERENCES wallets(name)');
  }

  final VerificationMeta _categoryNameMeta =
      const VerificationMeta('categoryName');
  GeneratedTextColumn _categoryName;
  @override
  GeneratedTextColumn get categoryName =>
      _categoryName ??= _constructCategoryName();
  GeneratedTextColumn _constructCategoryName() {
    return GeneratedTextColumn('category_name', $tableName, true,
        $customConstraints: 'NULL REFERENCES categories(name)');
  }

  final VerificationMeta _transactionTypeMeta =
      const VerificationMeta('transactionType');
  GeneratedIntColumn _transactionType;
  @override
  GeneratedIntColumn get transactionType =>
      _transactionType ??= _constructTransactionType();
  GeneratedIntColumn _constructTransactionType() {
    return GeneratedIntColumn(
      'transaction_type',
      $tableName,
      false,
    );
  }

  final VerificationMeta _titleMeta = const VerificationMeta('title');
  GeneratedTextColumn _title;
  @override
  GeneratedTextColumn get title => _title ??= _constructTitle();
  GeneratedTextColumn _constructTitle() {
    return GeneratedTextColumn('title', $tableName, false,
        minTextLength: 1, maxTextLength: 32);
  }

  final VerificationMeta _descriptionMeta =
      const VerificationMeta('description');
  GeneratedTextColumn _description;
  @override
  GeneratedTextColumn get description =>
      _description ??= _constructDescription();
  GeneratedTextColumn _constructDescription() {
    return GeneratedTextColumn(
      'description',
      $tableName,
      true,
    );
  }

  final VerificationMeta _amountMeta = const VerificationMeta('amount');
  GeneratedRealColumn _amount;
  @override
  GeneratedRealColumn get amount => _amount ??= _constructAmount();
  GeneratedRealColumn _constructAmount() {
    return GeneratedRealColumn(
      'amount',
      $tableName,
      false,
    );
  }

  final VerificationMeta _datetimeMeta = const VerificationMeta('datetime');
  GeneratedDateTimeColumn _datetime;
  @override
  GeneratedDateTimeColumn get datetime => _datetime ??= _constructDatetime();
  GeneratedDateTimeColumn _constructDatetime() {
    return GeneratedDateTimeColumn(
      'datetime',
      $tableName,
      false,
    );
  }

  final VerificationMeta _deletedMeta = const VerificationMeta('deleted');
  GeneratedBoolColumn _deleted;
  @override
  GeneratedBoolColumn get deleted => _deleted ??= _constructDeleted();
  GeneratedBoolColumn _constructDeleted() {
    return GeneratedBoolColumn('deleted', $tableName, false,
        defaultValue: Constant(false));
  }

  @override
  List<GeneratedColumn> get $columns => [
        id,
        walletName,
        categoryName,
        transactionType,
        title,
        description,
        amount,
        datetime,
        deleted
      ];
  @override
  $TransactionsTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'transactions';
  @override
  final String actualTableName = 'transactions';
  @override
  VerificationContext validateIntegrity(TransactionsCompanion d,
      {bool isInserting = false}) {
    final context = VerificationContext();
    if (d.id.present) {
      context.handle(_idMeta, id.isAcceptableValue(d.id.value, _idMeta));
    } else if (id.isRequired && isInserting) {
      context.missing(_idMeta);
    }
    if (d.walletName.present) {
      context.handle(_walletNameMeta,
          walletName.isAcceptableValue(d.walletName.value, _walletNameMeta));
    } else if (walletName.isRequired && isInserting) {
      context.missing(_walletNameMeta);
    }
    if (d.categoryName.present) {
      context.handle(
          _categoryNameMeta,
          categoryName.isAcceptableValue(
              d.categoryName.value, _categoryNameMeta));
    } else if (categoryName.isRequired && isInserting) {
      context.missing(_categoryNameMeta);
    }
    if (d.transactionType.present) {
      context.handle(
          _transactionTypeMeta,
          transactionType.isAcceptableValue(
              d.transactionType.value, _transactionTypeMeta));
    } else if (transactionType.isRequired && isInserting) {
      context.missing(_transactionTypeMeta);
    }
    if (d.title.present) {
      context.handle(
          _titleMeta, title.isAcceptableValue(d.title.value, _titleMeta));
    } else if (title.isRequired && isInserting) {
      context.missing(_titleMeta);
    }
    if (d.description.present) {
      context.handle(_descriptionMeta,
          description.isAcceptableValue(d.description.value, _descriptionMeta));
    } else if (description.isRequired && isInserting) {
      context.missing(_descriptionMeta);
    }
    if (d.amount.present) {
      context.handle(
          _amountMeta, amount.isAcceptableValue(d.amount.value, _amountMeta));
    } else if (amount.isRequired && isInserting) {
      context.missing(_amountMeta);
    }
    if (d.datetime.present) {
      context.handle(_datetimeMeta,
          datetime.isAcceptableValue(d.datetime.value, _datetimeMeta));
    } else if (datetime.isRequired && isInserting) {
      context.missing(_datetimeMeta);
    }
    if (d.deleted.present) {
      context.handle(_deletedMeta,
          deleted.isAcceptableValue(d.deleted.value, _deletedMeta));
    } else if (deleted.isRequired && isInserting) {
      context.missing(_deletedMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Transaction map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return Transaction.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  Map<String, Variable> entityToSql(TransactionsCompanion d) {
    final map = <String, Variable>{};
    if (d.id.present) {
      map['id'] = Variable<int, IntType>(d.id.value);
    }
    if (d.walletName.present) {
      map['wallet_name'] = Variable<String, StringType>(d.walletName.value);
    }
    if (d.categoryName.present) {
      map['category_name'] = Variable<String, StringType>(d.categoryName.value);
    }
    if (d.transactionType.present) {
      map['transaction_type'] = Variable<int, IntType>(d.transactionType.value);
    }
    if (d.title.present) {
      map['title'] = Variable<String, StringType>(d.title.value);
    }
    if (d.description.present) {
      map['description'] = Variable<String, StringType>(d.description.value);
    }
    if (d.amount.present) {
      map['amount'] = Variable<double, RealType>(d.amount.value);
    }
    if (d.datetime.present) {
      map['datetime'] = Variable<DateTime, DateTimeType>(d.datetime.value);
    }
    if (d.deleted.present) {
      map['deleted'] = Variable<bool, BoolType>(d.deleted.value);
    }
    return map;
  }

  @override
  $TransactionsTable createAlias(String alias) {
    return $TransactionsTable(_db, alias);
  }
}

class Wallet extends DataClass implements Insertable<Wallet> {
  final String name;
  final String description;
  final String color;
  final double initialAmount;
  final String currency;
  final bool deleted;
  Wallet(
      {@required this.name,
      this.description,
      @required this.color,
      @required this.initialAmount,
      @required this.currency,
      @required this.deleted});
  factory Wallet.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final stringType = db.typeSystem.forDartType<String>();
    final doubleType = db.typeSystem.forDartType<double>();
    final boolType = db.typeSystem.forDartType<bool>();
    return Wallet(
      name: stringType.mapFromDatabaseResponse(data['${effectivePrefix}name']),
      description: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}description']),
      color:
          stringType.mapFromDatabaseResponse(data['${effectivePrefix}color']),
      initialAmount: doubleType
          .mapFromDatabaseResponse(data['${effectivePrefix}initial_amount']),
      currency: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}currency']),
      deleted:
          boolType.mapFromDatabaseResponse(data['${effectivePrefix}deleted']),
    );
  }
  factory Wallet.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer = const ValueSerializer.defaults()}) {
    return Wallet(
      name: serializer.fromJson<String>(json['name']),
      description: serializer.fromJson<String>(json['description']),
      color: serializer.fromJson<String>(json['color']),
      initialAmount: serializer.fromJson<double>(json['initialAmount']),
      currency: serializer.fromJson<String>(json['currency']),
      deleted: serializer.fromJson<bool>(json['deleted']),
    );
  }
  @override
  Map<String, dynamic> toJson(
      {ValueSerializer serializer = const ValueSerializer.defaults()}) {
    return {
      'name': serializer.toJson<String>(name),
      'description': serializer.toJson<String>(description),
      'color': serializer.toJson<String>(color),
      'initialAmount': serializer.toJson<double>(initialAmount),
      'currency': serializer.toJson<String>(currency),
      'deleted': serializer.toJson<bool>(deleted),
    };
  }

  @override
  T createCompanion<T extends UpdateCompanion<Wallet>>(bool nullToAbsent) {
    return WalletsCompanion(
      name: name == null && nullToAbsent ? const Value.absent() : Value(name),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
      color:
          color == null && nullToAbsent ? const Value.absent() : Value(color),
      initialAmount: initialAmount == null && nullToAbsent
          ? const Value.absent()
          : Value(initialAmount),
      currency: currency == null && nullToAbsent
          ? const Value.absent()
          : Value(currency),
      deleted: deleted == null && nullToAbsent
          ? const Value.absent()
          : Value(deleted),
    ) as T;
  }

  Wallet copyWith(
          {String name,
          String description,
          String color,
          double initialAmount,
          String currency,
          bool deleted}) =>
      Wallet(
        name: name ?? this.name,
        description: description ?? this.description,
        color: color ?? this.color,
        initialAmount: initialAmount ?? this.initialAmount,
        currency: currency ?? this.currency,
        deleted: deleted ?? this.deleted,
      );
  @override
  String toString() {
    return (StringBuffer('Wallet(')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('color: $color, ')
          ..write('initialAmount: $initialAmount, ')
          ..write('currency: $currency, ')
          ..write('deleted: $deleted')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(
      $mrjc(
          $mrjc(
              $mrjc($mrjc($mrjc(0, name.hashCode), description.hashCode),
                  color.hashCode),
              initialAmount.hashCode),
          currency.hashCode),
      deleted.hashCode));
  @override
  bool operator ==(other) =>
      identical(this, other) ||
      (other is Wallet &&
          other.name == name &&
          other.description == description &&
          other.color == color &&
          other.initialAmount == initialAmount &&
          other.currency == currency &&
          other.deleted == deleted);
}

class WalletsCompanion extends UpdateCompanion<Wallet> {
  final Value<String> name;
  final Value<String> description;
  final Value<String> color;
  final Value<double> initialAmount;
  final Value<String> currency;
  final Value<bool> deleted;
  const WalletsCompanion({
    this.name = const Value.absent(),
    this.description = const Value.absent(),
    this.color = const Value.absent(),
    this.initialAmount = const Value.absent(),
    this.currency = const Value.absent(),
    this.deleted = const Value.absent(),
  });
}

class $WalletsTable extends Wallets with TableInfo<$WalletsTable, Wallet> {
  final GeneratedDatabase _db;
  final String _alias;
  $WalletsTable(this._db, [this._alias]);
  final VerificationMeta _nameMeta = const VerificationMeta('name');
  GeneratedTextColumn _name;
  @override
  GeneratedTextColumn get name => _name ??= _constructName();
  GeneratedTextColumn _constructName() {
    return GeneratedTextColumn('name', $tableName, false,
        minTextLength: 1, maxTextLength: 32);
  }

  final VerificationMeta _descriptionMeta =
      const VerificationMeta('description');
  GeneratedTextColumn _description;
  @override
  GeneratedTextColumn get description =>
      _description ??= _constructDescription();
  GeneratedTextColumn _constructDescription() {
    return GeneratedTextColumn(
      'description',
      $tableName,
      true,
    );
  }

  final VerificationMeta _colorMeta = const VerificationMeta('color');
  GeneratedTextColumn _color;
  @override
  GeneratedTextColumn get color => _color ??= _constructColor();
  GeneratedTextColumn _constructColor() {
    return GeneratedTextColumn(
      'color',
      $tableName,
      false,
    );
  }

  final VerificationMeta _initialAmountMeta =
      const VerificationMeta('initialAmount');
  GeneratedRealColumn _initialAmount;
  @override
  GeneratedRealColumn get initialAmount =>
      _initialAmount ??= _constructInitialAmount();
  GeneratedRealColumn _constructInitialAmount() {
    return GeneratedRealColumn(
      'initial_amount',
      $tableName,
      false,
    );
  }

  final VerificationMeta _currencyMeta = const VerificationMeta('currency');
  GeneratedTextColumn _currency;
  @override
  GeneratedTextColumn get currency => _currency ??= _constructCurrency();
  GeneratedTextColumn _constructCurrency() {
    return GeneratedTextColumn(
      'currency',
      $tableName,
      false,
    );
  }

  final VerificationMeta _deletedMeta = const VerificationMeta('deleted');
  GeneratedBoolColumn _deleted;
  @override
  GeneratedBoolColumn get deleted => _deleted ??= _constructDeleted();
  GeneratedBoolColumn _constructDeleted() {
    return GeneratedBoolColumn('deleted', $tableName, false,
        defaultValue: Constant(false));
  }

  @override
  List<GeneratedColumn> get $columns =>
      [name, description, color, initialAmount, currency, deleted];
  @override
  $WalletsTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'wallets';
  @override
  final String actualTableName = 'wallets';
  @override
  VerificationContext validateIntegrity(WalletsCompanion d,
      {bool isInserting = false}) {
    final context = VerificationContext();
    if (d.name.present) {
      context.handle(
          _nameMeta, name.isAcceptableValue(d.name.value, _nameMeta));
    } else if (name.isRequired && isInserting) {
      context.missing(_nameMeta);
    }
    if (d.description.present) {
      context.handle(_descriptionMeta,
          description.isAcceptableValue(d.description.value, _descriptionMeta));
    } else if (description.isRequired && isInserting) {
      context.missing(_descriptionMeta);
    }
    if (d.color.present) {
      context.handle(
          _colorMeta, color.isAcceptableValue(d.color.value, _colorMeta));
    } else if (color.isRequired && isInserting) {
      context.missing(_colorMeta);
    }
    if (d.initialAmount.present) {
      context.handle(
          _initialAmountMeta,
          initialAmount.isAcceptableValue(
              d.initialAmount.value, _initialAmountMeta));
    } else if (initialAmount.isRequired && isInserting) {
      context.missing(_initialAmountMeta);
    }
    if (d.currency.present) {
      context.handle(_currencyMeta,
          currency.isAcceptableValue(d.currency.value, _currencyMeta));
    } else if (currency.isRequired && isInserting) {
      context.missing(_currencyMeta);
    }
    if (d.deleted.present) {
      context.handle(_deletedMeta,
          deleted.isAcceptableValue(d.deleted.value, _deletedMeta));
    } else if (deleted.isRequired && isInserting) {
      context.missing(_deletedMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {name};
  @override
  Wallet map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return Wallet.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  Map<String, Variable> entityToSql(WalletsCompanion d) {
    final map = <String, Variable>{};
    if (d.name.present) {
      map['name'] = Variable<String, StringType>(d.name.value);
    }
    if (d.description.present) {
      map['description'] = Variable<String, StringType>(d.description.value);
    }
    if (d.color.present) {
      map['color'] = Variable<String, StringType>(d.color.value);
    }
    if (d.initialAmount.present) {
      map['initial_amount'] = Variable<double, RealType>(d.initialAmount.value);
    }
    if (d.currency.present) {
      map['currency'] = Variable<String, StringType>(d.currency.value);
    }
    if (d.deleted.present) {
      map['deleted'] = Variable<bool, BoolType>(d.deleted.value);
    }
    return map;
  }

  @override
  $WalletsTable createAlias(String alias) {
    return $WalletsTable(_db, alias);
  }
}

class Category extends DataClass implements Insertable<Category> {
  final String name;
  final bool deleted;
  Category({@required this.name, @required this.deleted});
  factory Category.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final stringType = db.typeSystem.forDartType<String>();
    final boolType = db.typeSystem.forDartType<bool>();
    return Category(
      name: stringType.mapFromDatabaseResponse(data['${effectivePrefix}name']),
      deleted:
          boolType.mapFromDatabaseResponse(data['${effectivePrefix}deleted']),
    );
  }
  factory Category.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer = const ValueSerializer.defaults()}) {
    return Category(
      name: serializer.fromJson<String>(json['name']),
      deleted: serializer.fromJson<bool>(json['deleted']),
    );
  }
  @override
  Map<String, dynamic> toJson(
      {ValueSerializer serializer = const ValueSerializer.defaults()}) {
    return {
      'name': serializer.toJson<String>(name),
      'deleted': serializer.toJson<bool>(deleted),
    };
  }

  @override
  T createCompanion<T extends UpdateCompanion<Category>>(bool nullToAbsent) {
    return CategoriesCompanion(
      name: name == null && nullToAbsent ? const Value.absent() : Value(name),
      deleted: deleted == null && nullToAbsent
          ? const Value.absent()
          : Value(deleted),
    ) as T;
  }

  Category copyWith({String name, bool deleted}) => Category(
        name: name ?? this.name,
        deleted: deleted ?? this.deleted,
      );
  @override
  String toString() {
    return (StringBuffer('Category(')
          ..write('name: $name, ')
          ..write('deleted: $deleted')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc($mrjc(0, name.hashCode), deleted.hashCode));
  @override
  bool operator ==(other) =>
      identical(this, other) ||
      (other is Category && other.name == name && other.deleted == deleted);
}

class CategoriesCompanion extends UpdateCompanion<Category> {
  final Value<String> name;
  final Value<bool> deleted;
  const CategoriesCompanion({
    this.name = const Value.absent(),
    this.deleted = const Value.absent(),
  });
}

class $CategoriesTable extends Categories
    with TableInfo<$CategoriesTable, Category> {
  final GeneratedDatabase _db;
  final String _alias;
  $CategoriesTable(this._db, [this._alias]);
  final VerificationMeta _nameMeta = const VerificationMeta('name');
  GeneratedTextColumn _name;
  @override
  GeneratedTextColumn get name => _name ??= _constructName();
  GeneratedTextColumn _constructName() {
    return GeneratedTextColumn('name', $tableName, false,
        minTextLength: 1, maxTextLength: 32);
  }

  final VerificationMeta _deletedMeta = const VerificationMeta('deleted');
  GeneratedBoolColumn _deleted;
  @override
  GeneratedBoolColumn get deleted => _deleted ??= _constructDeleted();
  GeneratedBoolColumn _constructDeleted() {
    return GeneratedBoolColumn('deleted', $tableName, false,
        defaultValue: Constant(false));
  }

  @override
  List<GeneratedColumn> get $columns => [name, deleted];
  @override
  $CategoriesTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'categories';
  @override
  final String actualTableName = 'categories';
  @override
  VerificationContext validateIntegrity(CategoriesCompanion d,
      {bool isInserting = false}) {
    final context = VerificationContext();
    if (d.name.present) {
      context.handle(
          _nameMeta, name.isAcceptableValue(d.name.value, _nameMeta));
    } else if (name.isRequired && isInserting) {
      context.missing(_nameMeta);
    }
    if (d.deleted.present) {
      context.handle(_deletedMeta,
          deleted.isAcceptableValue(d.deleted.value, _deletedMeta));
    } else if (deleted.isRequired && isInserting) {
      context.missing(_deletedMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {name};
  @override
  Category map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return Category.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  Map<String, Variable> entityToSql(CategoriesCompanion d) {
    final map = <String, Variable>{};
    if (d.name.present) {
      map['name'] = Variable<String, StringType>(d.name.value);
    }
    if (d.deleted.present) {
      map['deleted'] = Variable<bool, BoolType>(d.deleted.value);
    }
    return map;
  }

  @override
  $CategoriesTable createAlias(String alias) {
    return $CategoriesTable(_db, alias);
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(const SqlTypeSystem.withDefaults(), e);
  $TransactionsTable _transactions;
  $TransactionsTable get transactions =>
      _transactions ??= $TransactionsTable(this);
  $WalletsTable _wallets;
  $WalletsTable get wallets => _wallets ??= $WalletsTable(this);
  $CategoriesTable _categories;
  $CategoriesTable get categories => _categories ??= $CategoriesTable(this);
  @override
  List<TableInfo> get allTables => [transactions, wallets, categories];
}
