import 'package:madnolia/blocs/validators.dart';
import 'package:madnolia/models/user/update_profile_picture_response.dart';
// import 'package:madnolia/services/upload_service.dart';
import 'package:madnolia/services/user_service.dart';
import 'package:rxdart/rxdart.dart';

class EditUserBloc with Validators {
  
  
  final _imgController = BehaviorSubject<String>();
  final _loadingController = BehaviorSubject<bool>();
  final _loadingPercentageController = BehaviorSubject<int>();

  // Get STREAM data
  Stream<String> get imgStream => _imgController.stream;
  Stream<bool> get loadingStream => _loadingController.stream;
  Stream<int> get loadingPercentage => _loadingPercentageController.stream;

  // Update values
  Function(String) get changeImg => _imgController.sink.add;
  Function(int) get changePercentaje => _loadingPercentageController.sink.add;

  Future<UpdateProfilePictureResponse> uploadImage(String path) async {
    try {
      _loadingController.sink.add(true);
      _loadingPercentageController.sink.add(0);
      final imageUrl = await UserService().updateProfilePicture(path, changePercentaje);
      _loadingController.sink.add(false);
      _loadingPercentageController.sink.add(0);
      return imageUrl;
    } catch (e) {
      _loadingController.sink.add(false);
      _loadingPercentageController.sink.add(0);
      rethrow;
    }
  }

  String get img => _imgController.value;
  int get percentage => _loadingPercentageController.value;
}
