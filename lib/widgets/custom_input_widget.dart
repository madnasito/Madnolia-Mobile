import 'package:flutter/material.dart';

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
  final TextInputType keyboardType;
  final bool isPassword;
  final Function(String) onChanged;
  final TextEditingController? controller;
  const CustomInput(
      {super.key,
      required this.icon,
      required this.placeholder,
      required this.stream,
      required this.onChanged,
      this.keyboardType = TextInputType.text,
      this.isPassword = false,
      this.controller});

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
            controller: controller,
            obscureText: isPassword,
            keyboardType: keyboardType,
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

class DropDownWidget extends StatefulWidget {
  final String value;
  final void Function(String?)? onChanged;
  const DropDownWidget(
      {super.key, required this.onChanged, required this.value});

  @override
  State<DropDownWidget> createState() => _DropDownWidgetState();
}

class _DropDownWidgetState extends State<DropDownWidget> {
  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField(
      dropdownColor: Colors.black54,
      alignment: Alignment.center,
      borderRadius: BorderRadius.circular(20),
      focusColor: Colors.yellow,
      elevation: 20,
      isDense: true,
      value: widget.value,
      isExpanded: true,
      style: const TextStyle(
        decoration: TextDecoration.underline,
        fontSize: 15,
      ),
      decoration: InputDecoration(
          enabledBorder: validBorder,
          border: focusedBorder,
          prefixIconColor: Colors.pink,
          prefixIcon: const Icon(Icons.notifications_active_outlined)),
      items: const [
        DropdownMenuItem(
            value: "ALL",
            child: Text(
              "Whatever i want to play",
            )),
        DropdownMenuItem(
          value: "PARTNERS",
          child: Text("Only hommies"),
        ),
        DropdownMenuItem(
          value: "NOBODY",
          child: Text("Please, let me alone"),
        )
      ],
      onChanged: (value) => widget.onChanged!(value),
    );
  }
}
