import 'package:flutter/material.dart';

import 'package:madnolia/blocs/message_bloc.dart';
export 'package:madnolia/blocs/message_bloc.dart';

class MessageProvider extends InheritedWidget {
  static MessageProvider? _instance;

  factory MessageProvider({Key? key, required Widget child}) {
    _instance ??= MessageProvider._internal(key: key, child: child);

    return _instance!;
  }

  final messageBloc = MessageInputBloc();

  MessageProvider._internal({super.key, required super.child});

  // Provider({required Key key, required Widget child})
  //     : super(key: key, child: child);

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) => true;

  static MessageInputBloc of(BuildContext context) {
    return (context.getInheritedWidgetOfExactType<MessageProvider>()!)
        .messageBloc;
  }
}
