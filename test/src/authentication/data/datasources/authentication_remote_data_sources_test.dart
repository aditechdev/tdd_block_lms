import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mocktail/mocktail.dart';
import 'package:tdd_block_lms/core/errors/exceptions.dart';
import 'package:tdd_block_lms/core/utilities/constants.dart';
import 'package:tdd_block_lms/src/authentication/data/datasources/authentication_remote_data_sources.dart';
import 'package:tdd_block_lms/src/authentication/data/model/user_model.dart';

class MockClient extends Mock implements http.Client {}

void main() {
  late http.Client client;
  late AuthenticationRemoteDataSourse remoteDataSourse;

  setUp(() async {
    client = MockClient();

    remoteDataSourse = AuthenticationRemoteDataSrcImpl(client);
    registerFallbackValue(Uri());
  });

  // final

  group('creat user', () {
    test('should complete sccessfully when the status code is 200 || 201',
        () async {
      when(
        () => client.post(any(), body: any(named: 'body')),
      ).thenAnswer(
          (_) async => http.Response("User Created Successfully", 201));

      final methodCall = remoteDataSourse.createUser;

      expect(
          methodCall(
            createdAt: "createdAt",
            name: "name",
            avatar: "avatar",
          ),
          completes);

      verify(
        () => client.post(Uri.https(kBaseUrl, kCreateUserEndPoint),
            // Uri.parse(
            //   "$kBaseUrl$kCreateUserEndPoint",
            // ),
            body: jsonEncode({
              'createdAt': 'createdAt',
              'name': 'name',
              'avatar': 'avatar'
            })),
      ).called(1);

      verifyNoMoreInteractions(client);
    });

    test(
      'should throws [APIException] when the status code is not 200 || 201',
      () async {
        when(
          () => client.post(
            any(),
            body: any(named: 'body'),
          ),
        ).thenAnswer((_) async => http.Response('Invalid Email address', 400));

        final methodCall = remoteDataSourse.createUser;

        expect(
          () async => methodCall(
            createdAt: "createdAt",
            name: "name",
            avatar: "avatar",
          ),
          throwsA(
            const APIExceptions(
              message: "Invalid Email address",
              statusCode: 400,
            ),
          ),
        );

        verify(
          () => client.post(
            Uri.https(kBaseUrl, kCreateUserEndPoint),
            // Uri.parse(
            //   "$kBaseUrl$kCreateUserEndPoint",
            // ),
            body: jsonEncode(
              {
                'createdAt': 'createdAt',
                'name': 'name',
                'avatar': 'avatar',
              },
            ),
          ),
        ).called(1);
        verifyNoMoreInteractions(client);
      },
    );
  });

  group('get user', () {
    const tUsers = [UserModel.empty()];
    test('Should return a [list<User>] when the response code 200 || 201',
        () async {
      when(() => client.get(any())).thenAnswer(
          (_) async => http.Response(jsonEncode([tUsers.first.toMap()]), 200));

      final result = await remoteDataSourse.getUsers();

      expect(result, equals(tUsers));

      verify(
        () => client.get(Uri.https(kBaseUrl, kGetUsers)),
      ).called(1);

      verifyNoMoreInteractions(client);
    });

    test("should throw [APIException] when the status code is not 200",
        () async {
      const tMessage = 'server down, server down';
      when(() => client.get(any()))
          .thenAnswer((_) async => http.Response(tMessage, 500));

      final methodCall = remoteDataSourse.getUsers;

      expect(() => methodCall(),
          throwsA(const APIExceptions(message: tMessage, statusCode: 500)));

       verify(
        () => client.get(Uri.https(kBaseUrl, kGetUsers)),
      ).called(1);

      verifyNoMoreInteractions(client);
    });


  });
}
