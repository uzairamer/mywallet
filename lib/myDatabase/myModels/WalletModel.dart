
import './Model.dart';

class WalletModel implements Model{

  int id;
  String name;
  String description;
  String color;
  double initialAmount;
  String currency;

  WalletModel();

  String getTableName(){
    return 'Wallets';
  }

  List<String> getDbColumns(){
    return ['_id', 'name', 'description', 'initialAmount', 'color', 'currency'];
  }

  // The expected behavior for this method is to always return a new instance
  // of the objects that has all the properties copied from the map in to this
  // model
  WalletModel fromMap(Map<String, dynamic> map){
    WalletModel wm = new WalletModel();
    wm.id = map[getDbColumns()[0]];
    wm.name = map[getDbColumns()[1]];
    wm.description = map[getDbColumns()[2]];
    wm.initialAmount = map[getDbColumns()[3]];
    wm.color = map[getDbColumns()[4]];
    wm.currency = map[getDbColumns()[5]];
    return wm;
  }

  Map<String, dynamic> toMap(){
    return {
      getDbColumns()[0]: this.id,
      getDbColumns()[1]: this.name,
      getDbColumns()[2]: this.description,
      getDbColumns()[3]: this.initialAmount,
      getDbColumns()[4]: this.color,
      getDbColumns()[5]: this.currency
    };
  }

}