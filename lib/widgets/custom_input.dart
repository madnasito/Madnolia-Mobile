import 'package:flutter/material.dart';

OutlineInputBorder validBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(40),
    borderSide: const BorderSide(color: Colors.green));

OutlineInputBorder focusedBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(40),
    borderSide: const BorderSide(color: Colors.yellowAccent));

OutlineInputBorder errorBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(40),
    borderSide: const BorderSide(color: Colors.red));

class CustomInput extends StatefulWidget {
  final IconData icon;
  final String placeholder;
  final bool enabled;
  final TextEditingController textController;
  final TextInputType keyboardType;
  final bool isPassword;
  final Function()? onTap;
  final Function(String)? onChanged;

  const CustomInput(
      {super.key,
      required this.icon,
      required this.placeholder,
      required this.textController,
      this.onTap,
      this.enabled = true,
      this.keyboardType = TextInputType.text,
      this.isPassword = false,
      this.onChanged});

  @override
  State<CustomInput> createState() => _CustomInputState();
}

class _CustomInputState extends State<CustomInput> {
  bool _isFocused = false;
  bool _isValid = false;
  bool _hasError = false;
  final bool _focused = false;

  @override
  void initState() {
    super.initState();
    widget.textController.addListener(() {
      setState(() {
        _isFocused = widget.textController.text.isNotEmpty;
        _hasError = widget.textController.text.contains("error");
        _isValid = widget.textController.text.length > 3;
      });
    });
  }

  Color _getBorderColor() {
    if (!_focused) return Colors.grey;
    if (_hasError) {
      return Colors.red;
    } else if (_isValid) {
      return Colors.green;
    } else if (_isFocused) {
      return Colors.yellow;
    } else {
      return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(right: 0),
      margin: const EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
      ),
      child: TextFormField(
        onChanged: widget.onChanged,
        onTap: widget.onTap,
        enabled: widget.enabled,
        controller: widget.textController,
        keyboardType: widget.keyboardType,
        obscureText: widget.isPassword,
        decoration: InputDecoration(
          border: _isValid ? validBorder : focusedBorder,
          focusedBorder: _isValid ? validBorder : focusedBorder,
          errorText: !_isValid ? "Invalid" : null,
          enabledBorder: validBorder,
          focusedErrorBorder: errorBorder,
          errorBorder: errorBorder,
          prefixIcon: Icon(
            widget.icon,
            color: _getBorderColor(),
          ),
          hintText: widget.placeholder,
        ),
      ),
    );
  }
}
