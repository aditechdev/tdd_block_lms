import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tdd_block_lms/core/errors/exceptions.dart';
import 'package:tdd_block_lms/core/errors/failure.dart';
import 'package:tdd_block_lms/src/authentication/data/datasources/authentication_remote_data_sources.dart';
import 'package:tdd_block_lms/src/authentication/data/repositories/authentication_repository_implementation.dart';
import 'package:tdd_block_lms/src/authentication/domain/entities/user.dart';

class MockAuthRemoteDataSource extends Mock
    implements AuthenticationRemoteDataSourse {}

void main() {
  late AuthenticationRemoteDataSourse authenticationRemoteDataSourse;
  late AuthenticationRepositoryImplementation
      authenticationRepositoryImplementation;

  setUp(() {
    authenticationRemoteDataSourse = MockAuthRemoteDataSource();
    authenticationRepositoryImplementation =
        AuthenticationRepositoryImplementation(authenticationRemoteDataSourse);
  });

  const tException = APIExceptions(
    message: "Unknown error occured",
    statusCode: 500,
  );

  group("createUser", () {
    const createdAt = "whatever.createdAt";
    const avatar = "whatever.avatar";
    const name = "whatever.name";
    test(
        "Should call [RemoteDataSource] and complete successfully when the call to remote is successfully",
        () async {
//arrange
      when(() => authenticationRemoteDataSourse.createUser(
              createdAt: any(named: "createdAt"),
              name: any(named: "name"),
              avatar: any(named: "avatar")))
          .thenAnswer((invocation) async => Future.value(null));

      // assert

      final result = await authenticationRepositoryImplementation.createUser(
          avatar: avatar, createdAt: createdAt, name: name);

      expect(result, equals(const Right(null)));

      // Check remote shource is called
      verify(
        () => authenticationRemoteDataSourse.createUser(
            createdAt: createdAt, name: name, avatar: avatar),
      ).called(1);

      verifyNoMoreInteractions(authenticationRemoteDataSourse);
    });

    test("Return [APIFailure] when the call to remote", () async {
      // arrange
      when(() => authenticationRemoteDataSourse.createUser(
          createdAt: any(named: "createdAt"),
          name: any(named: "name"),
          avatar: any(named: "avatar"))).thenThrow(tException);

      final result = await authenticationRepositoryImplementation.createUser(
          createdAt: createdAt, name: name, avatar: avatar);

      expect(
        result,
        equals(
          Left(
            ApiFailure(
              message: tException.message,
              statusCode: tException.statusCode,
            ),
          ),
        ),
      );

      verify(() => authenticationRemoteDataSourse.createUser(
          createdAt: createdAt, name: name, avatar: avatar)).called(1);
      verifyNoMoreInteractions(authenticationRemoteDataSourse);
    });
  });

  group('get user', () {
    test(
        'should call remote data Source get users and return [List<User>] from the remote source and is successful',
        () async {
      when(
        () => authenticationRemoteDataSourse.getUsers(),
      ).thenAnswer((_) async => []);

      final result = await authenticationRepositoryImplementation.getUser();

      expect(result, isA<Right<dynamic, List<User>>>());
      verify(
        () => authenticationRemoteDataSourse.getUsers(),
      ).called(1);

      verifyNoMoreInteractions(authenticationRemoteDataSourse);
    });

    test("Return [APIFailure] when the call to remote", () async {
      when(() => authenticationRemoteDataSourse.getUsers())
          .thenThrow(tException);

      final result = await authenticationRepositoryImplementation.getUser();

      expect(result, equals(Left(ApiFailure.fromException(tException))));

      verify(() => authenticationRemoteDataSourse.getUsers()).called(1);

      verifyNoMoreInteractions(authenticationRemoteDataSourse);
    });
  });
}
