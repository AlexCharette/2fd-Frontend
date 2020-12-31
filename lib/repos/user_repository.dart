// import 'dart:async';
// import 'dart:math';
//
// import 'package:uuid/uuid.dart';
// import 'models/models.dart';
//
// class UserRepository {
//   User _user;
//
//   Future<User> getUser() async {
//     if (_user != null) return _user;
//     var rng = new Random();
//     return Future.delayed(
//       const Duration(milliseconds: 300),
//       () => _user = User(Uuid().v4(), "${rng.nextInt(1000)}", Uuid().v4()),
//     );
//   }
// }
