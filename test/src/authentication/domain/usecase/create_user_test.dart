import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tdd_block_lms/src/authentication/domain/repositories/authentication_repositories.dart';
import 'package:tdd_block_lms/src/authentication/domain/usecase/create_user.dart';

// What does the class depend on
// Ans: Authentication Repository
// How can we create a fake version on the dependency
// Ans: Use Mocktail [Mocktail , Mockito]
// How do we control what dependecy work
// Ans: Using the mocktail API

class MockAuthRepo extends Mock implements AuthenticationRepository {}

void main() {
  late CreateUser usecase;
  late AuthenticationRepository repository;

  setUp(() {
    repository = MockAuthRepo();
    usecase = CreateUser(repository);
  });

  const params = CreateUserParam.empty();
  test("Should call the [Repository.createUser]", () async {
    // Arrange
    // STUB

    when(
      () => repository.createUser(
        createdAt: any(named: "createdAt"),
        name: any(named: "name"),
        avatar: any(named: "avatar"),
      ),
    ).thenAnswer((_) async => const Right(null));

    // Act

    final result = await usecase(params);

    // Assert

    expect(result, equals(const Right<dynamic, void>(null)));
    verify(
      () => repository.createUser(
        createdAt: params.createdAt,
        name: params.name,
        avatar: params.avatar,
      ),
    ).called(1);

    verifyNoMoreInteractions(repository);
  });
}
