import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';

void showAlert(BuildContext context, String message) {
  showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.transparent,
          icon: const Icon(Icons.warning),
          titleTextStyle: const TextStyle(color: Colors.white),
          shape: Border.all(color: Colors.red, width: 1, strokeAlign: 2),
          iconColor: Colors.yellow,
          title: Text(
            message,
          ),
        );
      });
}

void showErrorServerAlert(BuildContext context, Map resp){
  String message = resp["message"];
  showAlert(context, translate("ERRORS.SERVER.$message"));
}