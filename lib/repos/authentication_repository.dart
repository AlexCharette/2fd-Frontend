import 'dart:async';
import 'package:meta/meta.dart';

enum AuthenticationStatus { unknown, authenticated, unauthenticated, forgotPassword }

class AuthenticationRepository {
  final _controller = StreamController<AuthenticationStatus>();

  Stream<AuthenticationStatus> get status async* {
    await Future<void>.delayed(const Duration(seconds: 1));
    yield AuthenticationStatus.unauthenticated;
    yield* _controller.stream;
  }

  Future<void> logIn({@required String username, @required String password,}) async {
    assert(username != null);
    assert(password != null);

    //simulates the login call to the backend
    //could be change to work with firebase
    await Future.delayed(
      const Duration(milliseconds: 300),
      () => _controller.add(AuthenticationStatus.authenticated),
    );
  }

  void logOut() {
    _controller.add(AuthenticationStatus.unauthenticated);
  }

  // Request one time code
  Future<void> requestOneTimeCode({@required String username}) async{
    //TODO: implement method
  }

  Future<void> validateOneTimeCode({@required String username, @required int oneTimeCode}){
    //TODO: implement method
  }
  void dispose() => _controller.close();
}
