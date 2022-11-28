import 'package:hive/hive.dart';

part 'data_model.g.dart';

@HiveType(typeId: 0)
class DataModel extends HiveObject {

  @HiveField(0)
  String exercise;

  @HiveField(1)
  String weight;

  @HiveField(2)
  String repetitions;

  DataModel(this.exercise,this.weight, this.repetitions);
}