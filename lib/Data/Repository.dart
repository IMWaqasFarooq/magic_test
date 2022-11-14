import 'package:hive/hive.dart';

import '../Constants/AppConstants.dart';
import '../Model/DataModel.dart';

abstract class Repository<T extends HiveObject> {

  Future<void> save(T newObject);

  Future<void> delete(DataModel objectToDelete);

  Future<void> update(int index, T objectToUpdate );

  Future<List<DataModel>> getAll();
}




class DataRepository implements Repository<DataModel> {

  final HiveInterface hive;

  DataRepository(this.hive);

  @override
  Future<List<DataModel>> getAll() async {
    final box = await _openBox(AppConstants.dataBox);
    return box.values.toList().cast();
  }

  @override
  Future<void> save(DataModel newObject) async {
    final box = await _openBox(AppConstants.dataBox);

    box.add(newObject);
  }

  @override
  Future<void> delete(DataModel objectToDelete) async {
    final box = await _openBox(AppConstants.dataBox);

    box.delete(objectToDelete.key);
  }

  @override
  Future<void> update(int index, DataModel objectToUpdate) async {
    // TODO: implement update
    final box = await _openBox(AppConstants.dataBox);

    box.putAt(index,objectToUpdate);
  }

  Future<Box> _openBox(String type) async {
    try {
      final box = await hive.openBox<DataModel>(type);
      return box;
    } catch (e) {
      throw Exception();
    }
  }

}