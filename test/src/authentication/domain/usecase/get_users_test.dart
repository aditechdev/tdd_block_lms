import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tdd_block_lms/src/authentication/domain/entities/user.dart';
import 'package:tdd_block_lms/src/authentication/domain/repositories/authentication_repositories.dart';
import 'package:tdd_block_lms/src/authentication/domain/usecase/get_users.dart';

import 'authentication_repository_mock.dart';

// What does the class depend on
// Ans: Authentication Repository
// How can we create a fake version on the dependency
// Ans: Use Mocktail [Mocktail , Mockito]
// How do we control what dependecy work
// Ans: Using the mocktail API

void main() {
  late GetUsers usecase;
  late AuthenticationRepository repository;

  setUp(() {
    repository = MockAuthRepo();
    usecase = GetUsers(repository);
  });

  final tResponse = [const User.empty()];
  test("Should call the [Repository.getUsers] and it should return List<User>",
      () async {
    // Arrange
    // STUB

    when(() => repository.getUser()).thenAnswer((_) async => Right(tResponse));

    // Act

    final result = await usecase();

    // Assert

    expect(result, equals(Right<dynamic, List<User>>(tResponse)));
    verify(() => repository.getUser()).called(1);

    verifyNoMoreInteractions(repository);
  });
}
