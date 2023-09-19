import 'package:equatable/equatable.dart';

class User extends Equatable {
  const User({
    required this.id,
    required this.avatar,
    required this.createdAt,
    required this.name,
  });

  final String id;
  final String createdAt;
  final String name;
  final String avatar;

  const User.empty()
      : this(
          avatar: "_empty.avatar",
          createdAt: "_empty.createdAt",
          name: "_empty.name",
          id: "1",
        );

  @override
  List<Object?> get props => [id, name, avatar];

  //* Instead of below code use equitable
  // Dart check refererance equality => It check whether it is checking to the same referance
  //https://api.dart.dev/stable/3.1.2/dart-core/Object/operator_equals.html#:~:text=The%20equality%20operator.,equality%20relation%20on%20a%20class.
  //
  //*/
  // @override
  // bool operator ==(other) {
  //   return identical(this, other) ||
  //       other is User && other.runtimeType == runtimeType && other.id == id && other.name == name;
  // }

  // @override
  // int get hashCode => id.hashCode ^ name.hashCode;
}
