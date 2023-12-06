import 'package:madnolia/blocs/validators.dart';
import 'package:rxdart/rxdart.dart';

class EditUserBloc with Validators {
  final _nameController = BehaviorSubject<String>();
  final _usernameController = BehaviorSubject<String>();
  final _emailController = BehaviorSubject<String>();

  // Get STREAM data
  Stream<String> get nameStream =>
      _nameController.stream.transform(validateName);
  Stream<String> get usernameStream =>
      _usernameController.stream.transform(validateUsername);
  Stream<String> get emailStream =>
      _emailController.stream.transform(validateEmail);

  Stream<bool> get userValidStream => CombineLatestStream.combine3(
      nameStream, usernameStream, emailStream, (n, u, e) => true);

  // Update values
  Function(String) get changeName => _nameController.sink.add;
  Function(String) get changeUsername => _usernameController.sink.add;
  Function(String) get changeEmail => _emailController.sink.add;

  String get name => _nameController.value;
  String get email => _emailController.value;
  String get username => _usernameController.value;
}
