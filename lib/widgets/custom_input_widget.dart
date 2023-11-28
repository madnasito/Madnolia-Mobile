import 'package:flutter/material.dart';
import 'package:madnolia/blocs/login_bloc.dart';

OutlineInputBorder focusedBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(40),
    borderSide: const BorderSide(color: Colors.blue));

OutlineInputBorder validBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(40),
    borderSide: const BorderSide(color: Colors.green));

OutlineInputBorder warningBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(40),
    borderSide: const BorderSide(color: Colors.yellow));

OutlineInputBorder errorBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(40),
    borderSide: const BorderSide(color: Colors.red));

class CustomInput extends StatelessWidget {
  final Stream<String> stream;
  final IconData icon;
  final String placeholder;
  final Function(String) onChanged;
  const CustomInput(
      {super.key,
      required this.icon,
      required this.placeholder,
      required this.stream,
      required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: stream,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return Container(
          padding: const EdgeInsets.only(right: 0),
          margin: const EdgeInsets.only(bottom: 20),
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
          child: TextField(
            decoration: InputDecoration(
                prefixIconColor: const Color.fromARGB(211, 233, 30, 98),
                focusedErrorBorder: warningBorder,
                enabledBorder: snapshot.data != null ? validBorder : null,
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: const BorderSide(color: Colors.blue, width: 3)),
                errorBorder: errorBorder,
                prefixIcon: Icon(
                  icon,
                ),
                hintText: placeholder,
                errorText: snapshot.error as String?),
            onChanged: onChanged,
          ),
        );
      },
    );
  }
}
