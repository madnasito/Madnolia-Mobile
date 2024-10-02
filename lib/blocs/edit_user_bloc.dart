import 'package:image_picker/image_picker.dart';
import 'package:Madnolia/blocs/validators.dart';
import 'package:Madnolia/services/upload_service.dart';
import 'package:rxdart/rxdart.dart';

class EditUserBloc with Validators {
  final _nameController = BehaviorSubject<String>();
  final _usernameController = BehaviorSubject<String>();
  final _emailController = BehaviorSubject<String>();
  final _imgController = BehaviorSubject<String>();
  final _thumbController = BehaviorSubject<String>();

  final _loadingController = BehaviorSubject<bool>();

  // Get STREAM data
  Stream<String> get nameStream =>
      _nameController.stream.transform(validateName);
  Stream<String> get usernameStream =>
      _usernameController.stream.transform(validateUsername);
  Stream<String> get emailStream =>
      _emailController.stream.transform(validateEmail);

  Stream<String> get imgStream => _imgController.stream;
  Stream<String> get thumbStream => _thumbController.stream;

  Stream<bool> get loadingStream => _loadingController.stream;

  Stream<bool> get userValidStream => CombineLatestStream.combine3(
      nameStream, usernameStream, emailStream, (n, u, e) => true);

  // Update values
  Function(String) get changeName => _nameController.sink.add;
  Function(String) get changeUsername => _usernameController.sink.add;
  Function(String) get changeEmail => _emailController.sink.add;
  Function(String) get changeImg => _imgController.sink.add;
  Function(String) get changeThumb => _thumbController.sink.add;

  Future uploadImage(XFile image) async {
    _loadingController.sink.add(true);
    final imageUrl = await UploadFileService().uploadImage(image);
    _loadingController.sink.add(false);

    if (imageUrl["ok"] == true) {
      changeImg(imageUrl["img"]);
      changeThumb(imageUrl["thumb_img"]);
    }

    return imageUrl;
  }

  String get name => _nameController.value;
  String get email => _emailController.value;
  String get username => _usernameController.value;
  String get img => _imgController.value;
  String get thumb => _thumbController.value;
}
