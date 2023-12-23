import 'dart:async';

import 'package:Madnolia/blocs/validators.dart';
import 'package:rxdart/rxdart.dart';

class LoginBloc with Validators {
  final _usernameController = BehaviorSubject<String>();
  final _passwordController = BehaviorSubject<String>();

  // Get Stream data
  Stream<String> get usernameStream =>
      _usernameController.stream.transform(validateUsername);
  Stream<String> get passwordStream =>
      _passwordController.stream.transform(validatePassword);

  Stream<bool> get formValidStream => CombineLatestStream.combine2(
      usernameStream, passwordStream, (e, p) => true);

  // Insert values to string
  Function(String) get changeEmail => _usernameController.sink.add;
  Function(String) get changePassword => _passwordController.sink.add;

  // Get last inserted value from streams
  String get username => _usernameController.value;
  String get password => _passwordController.value;

  dispose() {
    _usernameController.close();
    _passwordController.close();
  }
}
