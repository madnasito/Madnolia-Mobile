import 'package:flutter/material.dart';

import '../utils/get_slang_translations.dart';

void showAlert(BuildContext context, String message) {
  showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.black87,
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
          backgroundColor: Colors.black87,
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
    String messageResp = resp["message"];
    String message = getServerErrorTranslation(messageResp);
    showAlert(context, message);
  }else if(resp['message'] is List){
    String messageResp = resp["message"][0];
    String message = getServerErrorTranslation(messageResp);
    showAlert(context, message);
  } else {
    showAlert(context, resp['message'][0]);
  }
}

