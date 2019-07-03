import './Model.dart';

class CategoryModel implements Model{

  int _id;
  String name;

  CategoryModel();

  @override
  Model fromMap(Map<String, dynamic> map) {
    CategoryModel cm = new CategoryModel();
    cm._id = map[getDbColumns()[0]];
    cm.name = map[getDbColumns()[1]];
    return cm;
  }

  @override
  List<String> getDbColumns() {
    return ['_id', 'name'];
  }

  @override
  String getTableName() {
    return 'Categories';
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      getDbColumns()[0]: this._id,
      getDbColumns()[1]: this.name
    };
  }

}