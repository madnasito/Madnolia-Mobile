import 'dart:async';

import 'package:Madnolia/blocs/validators.dart';
import 'package:rxdart/rxdart.dart';

class MessageBloc with Validators {
  final _messageController = BehaviorSubject<String>();
  // Get STREAM data
  Stream<String> get messageStream => _messageController.stream;

  // Update values
  Function(String) get changeMessage => _messageController.sink.add;

  String get message => _messageController.value;
}
