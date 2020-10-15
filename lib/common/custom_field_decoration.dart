import 'package:flutter/material.dart';

InputDecoration CustomFieldInputDecoration(
        {String label, String counterText}) =>
    InputDecoration(
        isDense: true,
        labelText: label,
        border: const OutlineInputBorder(),
        counterText: counterText ?? '',
        counterStyle: const TextStyle(color: Colors.black));
