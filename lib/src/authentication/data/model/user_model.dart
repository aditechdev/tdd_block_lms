import 'dart:convert';

import 'package:tdd_block_lms/core/utilities/typedef.dart';
import 'package:tdd_block_lms/src/authentication/domain/entities/user.dart';

// Entity is the blue print and model is the extension of entity
class UserModel extends User {
  const UserModel({
    required super.id,
    required super.avatar,
    required super.createdAt,
    required super.name,
  });

  factory UserModel.fromJson(String resources) =>
      UserModel.fromMap(jsonDecode(resources) as DataMap);

  UserModel.fromMap(DataMap map)
      : this(
          avatar: map["avatar"] as String,
          createdAt: map["createdAt"] as String,
          id: map["id"] as String,
          name: map["name"] as String,
        );

   const UserModel.empty()
      : this(
          avatar: "_empty.avatar",
          createdAt: "_empty.createdAt",
          name: "_empty.name",
          id: "1",
        );

  DataMap toMap() => {
        "id": id,
        "avatar": avatar,
        "createdAt": createdAt,
        "name": name,
      };

  String toJson() => jsonEncode(toMap());

  UserModel copyWith(
      {String? avatar, String? createdAt, String? name, String? id}) {
    return UserModel(
      id: id ?? this.id,
      avatar: avatar ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      name: name ?? this.name,
    );
  }
}
