import 'package:flutter/material.dart';

OutlineInputBorder defaultBorder = OutlineInputBorder(
  borderRadius: BorderRadius.circular(30),
  borderSide: const BorderSide(color: Colors.blue, width: 3),
);

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