import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:tdd_block_lms/core/utilities/typedef.dart';
import 'package:tdd_block_lms/src/authentication/data/model/user_model.dart';
import 'package:tdd_block_lms/src/authentication/domain/entities/user.dart';

import '../../../../fixtures/fixture_reader.dart';

void main() {
  const tModel = UserModel.empty();
  final tJson = fixture('user.json');
  final tMap = jsonDecode(tJson) as DataMap;

  test("should be a subclass of [User] entity", () {
    // Arrange

    // Act

    //Assert
    expect(tModel, isA<User>());
  });
  group("From Map", () {
    test("should return a UserModel with correct data", () {
      // Act

      final result = UserModel.fromMap(tMap);

      expect(result, equals(tModel));
      //Assert
    });
  });

  group("From Json", () {
    test("should return a UserModel with correct data", () {
      // Act

      final result = UserModel.fromJson(tJson);

      expect(result, equals(tModel));
      //Assert
    });
  });

  group("To MAP", () {
    test("should return a Map with correct data", () {
      // ARRANGE
      final result = tModel.toMap();

      // Act

      // final result = UserModel.fromJson(tJson);

      expect(result, equals(tMap));
      //Assert
    });
  });

  group("To Json", () {
    test("should return a Map with correct data", () {
      // ARRANGE
      final result = tModel.toJson();

      // Act

      final tJson = jsonEncode({
        "id": "1",
        "avatar": "_empty.avatar",
        "createdAt": "_empty.createdAt",
        "name": "_empty.name"
      });

      // final result = UserModel.fromJson(tJson);

      expect(result, equals(tJson));
      //Assert
    });
  });

  group("Copy with", () {
    test("should return a [UserModel] with different data", () {
      // ARRANGE
      const String name = "Aditya";
      final result = tModel.copyWith(name: name);

      // Act

      // final result = UserModel.fromJson(tJson);

      expect(result.name, equals(name));
      expect(result, );
      //Assert
    });
  });
}
