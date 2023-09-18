import 'package:tdd_block_lms/core/usecase/usecase.dart';
import 'package:tdd_block_lms/core/utilities/typedef.dart';
import 'package:tdd_block_lms/src/authentication/domain/entities/user.dart';
import 'package:tdd_block_lms/src/authentication/domain/repositories/authentication_repositories.dart';

class GetUsers extends UseCaseWithoutParams<List<User>> {
  const GetUsers(this._authenticationRepository);

  final AuthenticationRepository _authenticationRepository;

  @override
  ResultFuture<List<User>> call() async => _authenticationRepository.getUser();
}
