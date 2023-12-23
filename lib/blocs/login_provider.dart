import 'package:flutter/material.dart';
import 'package:Madnolia/blocs/login_bloc.dart';
export 'package:Madnolia/blocs/login_bloc.dart';

class LoginProvider extends InheritedWidget {
  static LoginProvider? _instance;

  factory LoginProvider({Key? key, required Widget child}) {
    _instance ??= LoginProvider._internal(key: key, child: child);

    return _instance!;
  }

  final loginBloc = LoginBloc();

  LoginProvider._internal({super.key, required super.child});

  // Provider({required Key key, required Widget child})
  //     : super(key: key, child: child);

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) => true;

  static LoginBloc of(BuildContext context) {
    return (context.getInheritedWidgetOfExactType<LoginProvider>()!).loginBloc;
  }
}
