import 'package:flutter/widgets.dart';

import '../models/user_model.dart';

class UserProvider with ChangeNotifier {
  // ignore: prefer_typing_uninitialized_variables
  var _user;

  User get user => _user;

  bool get existsUser => _user ? true : false;

  set user(User user) {
    _user = user;
    notifyListeners();
  }
}
