import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tdd_block_lms/src/authentication/domain/entities/user.dart';
import 'package:tdd_block_lms/src/authentication/domain/usecase/create_user.dart';
import 'package:tdd_block_lms/src/authentication/domain/usecase/get_users.dart';

part 'authentication_state.dart';

class AuthenticationCubit extends Cubit<AuthenticationState> {
  AuthenticationCubit(
      {required CreateUser createUser, required GetUsers getUsers})
      : _createUser = createUser,
        _getUsers = getUsers,
        super(const AuthenticationInitial());

  final CreateUser _createUser;
  final GetUsers _getUsers;

  Future<void> createUser(
      {required String createdAt,
      required String name,
      required String avatar}) async {
    emit(const CreatingUser());

    final result = await _createUser(
        CreateUserParam(avatar: avatar, createdAt: createdAt, name: name));

    result.fold((failure) => emit(AuthenticationError(failure.errorMessage)),
        (_) => emit(const UserCreated()));
  }

  Future<void> getUser() async{
     emit(const GetingUser());

    final result = await _getUsers();

    result.fold((failure) => emit(AuthenticationError(failure.errorMessage)),
        (users) => emit(UserLoaded(users)));
  }
}
