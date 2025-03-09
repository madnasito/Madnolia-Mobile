import 'dart:async';

mixin class Validators {
  final validateName = StreamTransformer<String, String>.fromHandlers(
    handleData: (name, sink) {
      RegExp regExp = RegExp(r'^(?!.*\s.*\s.*)[a-zA-Z0-9.\$\_-]*$');

      if (regExp.hasMatch(name)) {
        sink.add(name);
      } else {
        sink.addError("No valid name");
      }

      if (name.length >= 20) {
        sink.addError("Name too long");
      }
    },
  );

  final validateEmail = StreamTransformer<String, String>.fromHandlers(
    handleData: (email, sink) {
      Pattern pattern =
          r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
      RegExp regExp = RegExp(pattern.toString());

      if (regExp.hasMatch(email)) {
        sink.add(email);
      } else {
        sink.addError("Invalid email");
      }
    },
  );

  final validateUsername = StreamTransformer<String, String>.fromHandlers(
      handleData: (username, sink) {
    RegExp regExp = RegExp(r'^[a-zA-Z][-_a-zA-Z0-9.]{0,24}$');

    if (regExp.hasMatch(username)) {
      sink.add(username);
    } else {
      sink.addError("No valid username");
    }
  });

  final validatePassword = StreamTransformer<String, String>.fromHandlers(
      handleData: (password, sink) {
    if (password.length >= 6) {
      sink.add(password);
    } else {
      sink.addError("Min 6 characters");
    }
  });
}
