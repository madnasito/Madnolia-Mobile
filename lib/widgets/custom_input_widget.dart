import 'package:flutter/material.dart';
import 'package:madnolia/i18n/strings.g.dart';

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
  final IconData? icon;
  final String placeholder;
  final TextInputType keyboardType;
  final bool isPassword;
  final Function(String) onChanged;
  final TextEditingController? controller;
  const CustomInput(
      {super.key,
      this.icon,
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
              prefixIcon: icon != null ? Icon(icon) : null,
              hintText: placeholder,
              errorText: snapshot.error as String?,
              errorBorder: errorBorder,
              enabledBorder: snapshot.hasData ? validBorder : null,
              focusedErrorBorder: warningBorder,
              focusedBorder: focusedBorder,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: const BorderSide(color: Colors.blue, width: 3),
              ),
            ),
            onChanged: onChanged,
          ),
        );
      },
    );
  }
}

class DropDownWidget extends StatefulWidget {
  final int value;
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
      dropdownColor: Colors.black87,
      alignment: Alignment.center,
      borderRadius: BorderRadius.circular(20),
      focusColor: Colors.yellow,
      elevation: 20,
      isDense: true,
      initialValue: widget.value,
      style: const TextStyle(
        decoration: TextDecoration.underline,
        fontSize: 15,
      ),
      decoration: InputDecoration(
          enabledBorder: validBorder,
          border: focusedBorder,
          prefixIconColor: Colors.pink,
          prefixIcon: const Icon(Icons.notifications_active_outlined)),
      items: [
        DropdownMenuItem(
            value: "ALL",
            child: Text(
              t.PROFILE.USER_PAGE.INVITATIONS.ALL,
            )),
        DropdownMenuItem(
          value: "PARTNERS",
          child: Text(t.PROFILE.USER_PAGE.INVITATIONS.PARTNERS),
        ),
        DropdownMenuItem(
          value: "NOBODY",
          child: Text(t.PROFILE.USER_PAGE.INVITATIONS.NO),
        )
      ],
      onChanged: (value) => widget.onChanged!(value as String?),
    );
  }
}

class SimpleCustomInput extends StatelessWidget {
  final String placeholder;
  final TextEditingController controller;
  final TextInputType keyboardType;
  final void Function()? onTap;
  final void Function(String)? onChanged;
  final IconData iconData;
  final bool autofocus;
  const SimpleCustomInput(
      {super.key,
      required this.placeholder,
      required this.controller,
      required this.iconData,
      this.onTap,
      this.onChanged,
      this.keyboardType = TextInputType.text,
      this.autofocus = false});

  @override
  Widget build(BuildContext context) {
    return TextField(
      autofocus: autofocus,
      onTap: onTap,
      controller: controller,
      onChanged: onChanged,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        prefixIcon: Icon(iconData),
        hintText: placeholder, border: focusedBorder),
    );
  }
}
