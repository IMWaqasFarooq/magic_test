import 'package:hive/hive.dart';

import '../Constants/AppConstants.dart';
import '../DataBox/DataBox.dart';
import '../Model/DataModel.dart';

abstract class Repository<T extends HiveObject> {

  Future<void> save(T newObject);

  Future<void> delete(DataModel objectToDelete);

  Future<void> update(int index, T objectToUpdate );

  Future<List<DataModel>> getAll();
}




class DataRepository implements Repository<DataModel> {


  final DataBox dataBox;

  DataRepository(this.dataBox);

  @override
  Future<List<DataModel>> getAll() async {
    final box = await dataBox.box;
    return box.values.toList().cast();
  }

  @override
  Future<void> save(DataModel newObject) async {
    final box = await dataBox.box;

    box.add(newObject);
  }

  @override
  Future<void> delete(DataModel objectToDelete) async {
    final box = await dataBox.box;

    box.delete(objectToDelete.key);
  }

  @override
  Future<void> update(int index, DataModel objectToUpdate) async {
    // TODO: implement update
    final box = await dataBox.box;

    box.putAt(index,objectToUpdate);
  }



}