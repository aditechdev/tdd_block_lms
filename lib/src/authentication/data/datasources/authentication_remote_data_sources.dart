import 'package:tdd_block_lms/src/authentication/data/model/user_model.dart';

abstract class AuthenticationRemoteDataSourse {
  Future<void> createUser(
      {required String createdAt,
      required String name,
      required String avatar});

  Future<List<UserModel>> getUsers();
}
