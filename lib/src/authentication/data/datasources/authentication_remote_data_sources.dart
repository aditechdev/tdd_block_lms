import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:tdd_block_lms/core/errors/exceptions.dart';
import 'package:tdd_block_lms/core/utilities/constants.dart';
import 'package:tdd_block_lms/src/authentication/data/model/user_model.dart';

abstract class AuthenticationRemoteDataSourse {
  Future<void> createUser(
      {required String createdAt,
      required String name,
      required String avatar});

  Future<List<UserModel>> getUsers();
}

const kCreateUserEndPoint = "/users";
const kGetUsers = "/user";

class AuthenticationRemoteDataSrcImpl extends AuthenticationRemoteDataSourse {
  AuthenticationRemoteDataSrcImpl(this._client);
  final http.Client _client;

  @override
  Future<void> createUser(
      {required String createdAt,
      required String name,
      required String avatar}) async {
    try {
      final response = await _client.post(
          Uri.parse("$kBaseUrl$kCreateUserEndPoint"),
          body: jsonEncode(
              {"createdAt": createdAt, "name": name, "avatar": avatar}));
      // Check make sure return right data
      // Check when responsse code is 200
      // Make sure that it throws an exception
      // throw UnimplementedError();

      if (response.statusCode != 200 && response.statusCode != 201) {
        throw APIExceptions(
            message: response.body, statusCode: response.statusCode);
      }
    } on APIExceptions {
      rethrow;
    } catch (e) {
      throw APIExceptions(message: e.toString(), statusCode: 505);
    }
  }

  @override
  Future<List<UserModel>> getUsers() {
    // TODO: implement getUsers
    throw UnimplementedError();
  }
}
