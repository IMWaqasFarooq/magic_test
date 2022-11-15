

import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:magic_test/Constants/AppConstants.dart';
import 'package:magic_test/Data/Repository.dart';
import 'package:magic_test/DataBox/DataBox.dart';
import 'package:magic_test/Model/DataModel.dart';
import 'package:mockito/mockito.dart';



class MockDataBox extends Mock implements DataBox {}
class MockBox<T> extends Mock implements Box<T> {}


void main() {
  final loyaltyCard1 = DataModel('exercise1','12',"10");
  final loyaltyCard2 = DataModel('exercise2','34',"20");
  final loyaltyCardList = [loyaltyCard1, loyaltyCard2];

  group('Given a Loyalty cards repository', () {
    final mockDataBox = MockDataBox();
    final mockBox = MockBox<DataModel>();

    final dataRepository = DataRepository(mockDataBox);

    when(mockDataBox.box).thenAnswer((_) async => mockBox);
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