import 'package:flutter/material.dart';

import 'package:madnolia/blocs/register_bloc.dart';
export 'package:madnolia/blocs/register_bloc.dart';

class RegisterProvider extends InheritedWidget {
  // static RegisterProvider? _instance;

  // factory RegisterProvider({Key? key, required Widget child}) {
  //   _instance ??= RegisterProvider._internal(key: key, child: child);

  //   return _instance!;
  // }

  final registerBloc = RegisterBloc();

  RegisterProvider({super.key, required super.child});

  // RegisterProvider._internal({super.key, required super.child});

  // Provider({required Key key, required Widget child})
  //     : super(key: key, child: child);

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) => true;

  static RegisterBloc of(BuildContext context) {
    return (context.getInheritedWidgetOfExactType<RegisterProvider>()!)
        .registerBloc;
  }
}
