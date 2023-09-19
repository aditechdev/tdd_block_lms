import 'package:equatable/equatable.dart';
import 'package:tdd_block_lms/core/usecase/usecase.dart';
import 'package:tdd_block_lms/core/utilities/typedef.dart';
import 'package:tdd_block_lms/src/authentication/domain/repositories/authentication_repositories.dart';

class CreateUser extends UseCaseWithParams<void, CreateUserParam> {
  CreateUser(this._repository);

  final AuthenticationRepository _repository;

  @override
  ResultFuture call(params) async => _repository.createUser(
        createdAt: params.createdAt,
        name: params.name,
        avatar: params.avatar,
      );
}

class CreateUserParam extends Equatable {
  const CreateUserParam({
    required this.avatar,
    required this.createdAt,
    required this.name,
  });

  final String createdAt;
  final String name;
  final String avatar;

  const CreateUserParam.empty()
      : this(
          avatar: "_empty.avatar",
          createdAt: "_empty.createdAt",
          name: "_empty.name",
        );

  @override
  List<Object?> get props => [
        createdAt,
        name,
        avatar,
      ];
}
