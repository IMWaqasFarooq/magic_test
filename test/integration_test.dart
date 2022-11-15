import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:magic_test/Data/Repository.dart';
import 'package:magic_test/DataBox/DataBox.dart';
import 'package:magic_test/Model/DataModel.dart';

void initialiseHive() async {
  var path = Directory.current.path;
  Hive
    ..init(path)
    ..registerAdapter(DataModelAdapter());

  //Always starts from a clean box
  Hive.deleteBoxFromDisk('loyalty_card');
}

void main() async {
  initialiseHive();

  final newCard = DataModel('exercise', '45',"20");

  group('Given a real loyalty cards repository instance and a real Hive box', () {
    test('should save and then retrieve saved loyalty card from the repository', () async {
      final dataRepository = DataRepository(DataBox());

      await dataRepository.save(newCard);

      expect(await dataRepository.getAll(), [newCard]);
    });
  });
}