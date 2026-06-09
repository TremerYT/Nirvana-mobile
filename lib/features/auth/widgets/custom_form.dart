import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:nirvana_mobile/features/auth/models/form_field.dart';

class CustomForm extends StatefulWidget {
  final GlobalKey<FormBuilderState> formKey;
  final List<FormFields> fields;

  const CustomForm({super.key, required this.formKey, required this.fields});

  @override
  State<CustomForm> createState() => _CustomFormState();
}

class _CustomFormState extends State<CustomForm> {
  final Map<String, bool> obscureMap = {};

  @override
  void initState() {
    super.initState();
    for (var field in widget.fields) {
      if (field.isPassword) {
        obscureMap[field.name] = true;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return FormBuilder(
      key: widget.formKey,
      child: Column(
        children: [
          ...widget.fields.map((field) {
            final isObscured = obscureMap[field.name] ?? false;
            return Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: FormBuilderTextField(
                name: field.name,
                keyboardType: field.keyboardType,
                onChanged: (value) {
                  if (field.name == "password") {
                    widget.formKey.currentState?.fields["confirmPassword"]
                        ?.validate();
                  }
                },
                obscureText: field.isPassword ? isObscured : false,
                decoration: InputDecoration(
                  labelText: field.label,
                  suffixIcon: field.isPassword
                      ? IconButton(
                          onPressed: () {
                            setState(() {
                              obscureMap[field.name] = !isObscured;
                            });
                          },
                          icon: Icon(
                            isObscured
                                ? Icons.visibility_off
                                : Icons.visibility,
                          ),
                        )
                      : null,
                ),
                validator: field.validators != null
                    ? (value) {
                        for (var v in field.validators!) {
                          final result = v(value);
                          if (result != null) return result;
                        }
                        return null;
                      }
                    : null,
              ),
            );
          }),
        ],
      ),
    );
  }
}
