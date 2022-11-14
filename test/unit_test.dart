

import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:magic_test/Constants/AppConstants.dart';
import 'package:magic_test/Data/Repository.dart';
import 'package:magic_test/Model/DataModel.dart';
import 'package:mockito/mockito.dart';



class MockHiveInterface extends Mock implements HiveInterface {}
class MockBox<T> extends Mock implements Box<T> {}


void main() {
  final loyaltyCard1 = DataModel('exercise1','12',"10");
  final loyaltyCard2 = DataModel('exercise2','34',"20");
  final loyaltyCardList = [loyaltyCard1, loyaltyCard2];

  group('Given a Loyalty cards repository', () {
    final mockHiveInterface = MockHiveInterface();
    final mockBox = MockBox<DataModel>();

    final dataRepository = DataRepository(mockHiveInterface);

    when(mockHiveInterface.openBox(AppConstants.dataBox)).thenAnswer((_) async => mockBox);
    when(mockBox.values).thenReturn(loyaltyCardList);

    test('should retrieve all LoyaltyCards', () async {
      final result = await dataRepository.getAll();

      expect(result, loyaltyCardList);
    });

    test('should save loyalty card in the box', () async {
      final newCard = DataModel('exerciseNew','32',"14");

      await dataRepository.save(newCard);

      verify(mockBox.add(newCard));
    });

    test('should delete loyalty card from the box', () async {
      final existingCard = DataModel('exerciseExisting','75',"21");

      await dataRepository.delete(existingCard);

      verify(mockBox.delete(existingCard.key));
    });

  });
}