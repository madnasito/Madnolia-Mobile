import 'package:flutter/widgets.dart';

import 'package:madnolia/pages/auth/login_page.dart';
import 'package:madnolia/pages/create_match_page.dart';
import 'package:madnolia/pages/user/edit_user_page.dart';
import 'package:madnolia/pages/user/user_page.dart';

import '../pages/home/home_user_page.dart';

Map<String, WidgetBuilder> getApplicationRoutes() {
  return <String, WidgetBuilder>{
    "login": (BuildContext context) => const LoginPage(),
    "loggedHome": (BuildContext context) => const LoggedHome(),
    "user": (BuildContext context) => const UserPage(),
    "user/edit": (BuildContext context) => const UserEditPage(),
    "new": (BuildContext context) => const NewPage()
  };
}
