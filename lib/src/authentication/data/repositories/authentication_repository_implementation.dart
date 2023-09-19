import 'package:dartz/dartz.dart';
import 'package:tdd_block_lms/core/errors/exceptions.dart';
import 'package:tdd_block_lms/core/errors/failure.dart';
import 'package:tdd_block_lms/core/utilities/typedef.dart';
import 'package:tdd_block_lms/src/authentication/data/datasources/authentication_remote_data_sources.dart';
import 'package:tdd_block_lms/src/authentication/domain/entities/user.dart';
import 'package:tdd_block_lms/src/authentication/domain/repositories/authentication_repositories.dart';

class AuthenticationRepositoryImplementation
    implements AuthenticationRepository {
  const AuthenticationRepositoryImplementation(this._remoteDataSourse);

  final AuthenticationRemoteDataSourse _remoteDataSourse;
  @override
  ResultFutureVoid createUser(
      {required String createdAt,
      required String name,
      required String avatar}) async {
    try {
      await _remoteDataSourse.createUser(
          createdAt: createdAt, name: name, avatar: avatar);
      return const Right(null);
    } on APIExceptions catch (e) {
      return Left(
        ApiFailure.fromException(e),
      );
    }
  }

  @override
  ResultFuture<List<User>> getUser() async {
    try {
      final result = await _remoteDataSourse.getUsers();
      return Right(result);
    } on APIExceptions catch (e) {
      return Left(ApiFailure.fromException(e));
    }
    // throw UnimplementedError();
  }
}
