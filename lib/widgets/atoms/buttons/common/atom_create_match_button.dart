import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:go_router/go_router.dart';

class AtomCreateMatchButton extends StatelessWidget {
  const AtomCreateMatchButton({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: () {
        GoRouter.of(context).push('/new');
      },
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 30),
      shape: StadiumBorder(side: BorderSide(color: Colors.lightBlueAccent, width: 1)),
      child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Icon(Icons.bolt_outlined, color: const Color.fromARGB(255, 255, 242, 126),),
            SizedBox(width: 8),
            Text(translate("HEADER.MATCH"), style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600),),
          ]),
    );
  }
}