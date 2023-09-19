import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mocktail/mocktail.dart';
import 'package:tdd_block_lms/core/errors/exceptions.dart';
import 'package:tdd_block_lms/core/utilities/constants.dart';
import 'package:tdd_block_lms/src/authentication/data/datasources/authentication_remote_data_sources.dart';

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

  group(
    'creat user',
    () {
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
          () => client.post(
              Uri.parse(
                "$kBaseUrl$kCreateUserEndPoint",
              ),
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
          ).thenAnswer(
              (_) async => http.Response('Invalid Email address', 400));

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
              Uri.parse(
                "$kBaseUrl$kCreateUserEndPoint",
              ),
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
    },
  );

  

}
