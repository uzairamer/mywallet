import './Model.dart';

class TransactionModel implements Model{

  int walletId;
  int categoryId;

  int _id;
  int transactionType;
  String title;
  String description;
  double amount;
  String dateTime;
  
  TransactionModel();

  @override
  Model fromMap(Map<String,dynamic> map) {
    TransactionModel trm = new TransactionModel();
    trm._id = map[getDbColumns()[0]];
    trm.title = map[getDbColumns()[1]];
    trm.description = map[getDbColumns()[2]];
    trm.amount = map[getDbColumns()[3]];
    trm.walletId = map[getDbColumns()[4]];
    trm.categoryId = map[getDbColumns()[5]];
    trm.transactionType = map[getDbColumns()[6]];
    trm.dateTime = map[getDbColumns()[7]];
    return trm;
  }

  @override
  List<String> getDbColumns() {
    return ['_id', 'title', 'description', 'amount', 'walletId', 'categoryId', 'transactionType', 'dateTime'];
  }

  @override
  String getTableName() {
    return 'Transactions';
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      getDbColumns()[0]: this._id,
      getDbColumns()[1]: this.title,
      getDbColumns()[2]: this.description,
      getDbColumns()[3]: this.amount,
      getDbColumns()[4]: this.walletId,
      getDbColumns()[5]: this.categoryId,
      getDbColumns()[6]: this.transactionType,
      getDbColumns()[7]: this.dateTime
    };
  }
  
}