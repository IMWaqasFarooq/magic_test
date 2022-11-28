import 'package:hive/hive.dart';

import '../model/data_model.dart';


class DataBox {
  var box = Hive.openBox<DataModel>('data_box');
}