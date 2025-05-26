import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';

void showAlert(BuildContext context, String message) {
  showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.black12,
          icon: const Icon(Icons.warning),
          titleTextStyle: const TextStyle(color: Colors.white),
          shape: RoundedRectangleBorder(side: const BorderSide(color: Colors.red, width: 2), borderRadius: BorderRadius.circular(20)),
          iconColor: Colors.yellow,
          title: Text(
            message,
          ),
        );
      });
}

void showSuccesfulAlert(BuildContext context, String message) {
  showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.black12,
          icon: const Icon(Icons.check_rounded),
          titleTextStyle: const TextStyle(color: Colors.white),
          shape: RoundedRectangleBorder(side: const BorderSide(color: Colors.lightBlue, width: 2), borderRadius: BorderRadius.circular(20)),
          iconColor: Colors.green,
          title: Text(
            message,
          ),
        );
      });
}

void showErrorServerAlert(BuildContext context, Map resp){

  if( resp['message'] is String){
    String message = resp["message"];
    showAlert(context, translate("ERRORS.SERVER.$message"));
  }else {
    showAlert(context, resp['message'][0]);
  }
}