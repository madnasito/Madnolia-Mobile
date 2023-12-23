import 'package:flutter/material.dart';

import 'package:Madnolia/blocs/message_bloc.dart';
export 'package:Madnolia/blocs/message_bloc.dart';

class MessageProvider extends InheritedWidget {
  static MessageProvider? _instance;

  factory MessageProvider({Key? key, required Widget child}) {
    _instance ??= MessageProvider._internal(key: key, child: child);

    return _instance!;
  }

  final messageBloc = MessageBloc();

  MessageProvider._internal({super.key, required super.child});

  // Provider({required Key key, required Widget child})
  //     : super(key: key, child: child);

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) => true;

  static MessageBloc of(BuildContext context) {
    return (context.getInheritedWidgetOfExactType<MessageProvider>()!)
        .messageBloc;
  }
}
