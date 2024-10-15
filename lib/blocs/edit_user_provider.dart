import 'package:flutter/material.dart';
import 'package:madnolia/blocs/edit_user_bloc.dart';

export 'package:madnolia/blocs/register_bloc.dart';

class EditUserProvider extends InheritedWidget {
  final editUserBloc = EditUserBloc();

  EditUserProvider({super.key, required super.child});

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) => true;

  static EditUserBloc of(BuildContext context) {
    return (context.getInheritedWidgetOfExactType<EditUserProvider>()!)
        .editUserBloc;
  }
}
