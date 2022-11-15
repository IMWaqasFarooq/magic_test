import 'package:hive/hive.dart';

import '../Model/DataModel.dart';

class DataBox {
  var box = Hive.openBox<DataModel>('data_box');
}