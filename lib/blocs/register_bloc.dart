import 'package:Madnolia/blocs/validators.dart';
import 'package:rxdart/rxdart.dart';

class RegisterBloc with Validators {
  final _nameController = BehaviorSubject<String>();
  final _usernameController = BehaviorSubject<String>();
  final _emailController = BehaviorSubject<String>();
  final _passwordController = BehaviorSubject<String>();

  // Get STREAM data
  Stream<String> get nameStream =>
      _nameController.stream.transform(validateName);
  Stream<String> get usernameStream =>
      _usernameController.stream.transform(validateUsername);
  Stream<String> get emailStream =>
      _emailController.stream.transform(validateEmail);
  Stream<String> get passwordStream =>
      _passwordController.stream.transform(validatePassword);

  Stream<bool> get userValidStream => CombineLatestStream.combine4(nameStream,
      usernameStream, emailStream, passwordStream, (n, u, e, p) => true);

  // Update values
  Function(String) get changeName => _nameController.sink.add;
  Function(String) get changeUsername => _usernameController.sink.add;
  Function(String) get changeEmail => _emailController.sink.add;
  Function(String) get changePassword => _passwordController.sink.add;

  String? get name => _nameController.valueOrNull;
  String? get password => _passwordController.valueOrNull;
  String? get email => _emailController.valueOrNull;
  String? get username => _usernameController.valueOrNull;
}
