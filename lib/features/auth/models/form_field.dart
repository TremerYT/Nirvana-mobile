import 'package:flutter/material.dart';

class FormFields {
  final String label;
  final String name;
  final bool isPassword;
  final List<String? Function(String?)>? validators;
  final TextInputType? keyboardType;

  FormFields({
    required this.label,
    required this.name,
    this.isPassword = false,
    this.validators,
    this.keyboardType,
  });
}
