import 'package:flutter/material.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';
import 'package:nirvana_mobile/features/auth/controller/auth_controller.dart';
import 'package:nirvana_mobile/features/auth/models/form_field.dart';

final loginFields = [
  FormFields(
    label: "Email",
    name: "email",
    validators: [
      FormBuilderValidators.required(),
      FormBuilderValidators.email(),
    ],
  ),
  FormFields(
    label: "Password",
    name: "password",
    isPassword: true,
    validators: [
      FormBuilderValidators.required(),
      FormBuilderValidators.password(),
    ],
  ),
];

final registerFields = [
  FormFields(
    label: "First Name",
    name: "firstName",
    validators: [FormBuilderValidators.required()],
  ),

  FormFields(
    label: "Last Name",
    name: "lastName",
    validators: [FormBuilderValidators.required()],
  ),

  FormFields(
    label: "Email",
    name: "email",
    validators: [
      FormBuilderValidators.required(),
      FormBuilderValidators.email(),
    ],
  ),
  FormFields(
    label: "Phone Number",
    name: "phoneNumber",
    validators: [
      FormBuilderValidators.required(),
      (val) {
        final cleaned = (val ?? '').replaceAll(RegExp(r'\s|-'), '');
        if (!RegExp(r'^(?:\+254|254|0)(7|1)\d{8}$').hasMatch(cleaned)) {
          return 'Enter a valid Kenyan phone number';
        }
        return null;
      },
    ],
  ),
  FormFields(
    label: "Password",
    name: "password",
    isPassword: true,
    validators: [
      FormBuilderValidators.required(),
      FormBuilderValidators.password(),
    ],
  ),
  FormFields(
    label: "Confirm password",
    name: "confirmPassword",
    isPassword: true,
    validators: [
      FormBuilderValidators.required(),
      (value) {
        try {
          final formState =
              Get.find<AuthController>().registerFormKey.currentState;
          if (formState == null) return null;

          final passwordValue = formState.value['password'];

          if (value != passwordValue) {
            return "Passwords do not match";
          }
        } catch (e) {
          //
        }
        return null;
      },
    ],
  ),
];

final resetPhoneFields = [
  FormFields(
    name: "phoneNumber",
    label: "Phone Number",
    keyboardType: TextInputType.phone,
    validators: [
      FormBuilderValidators.required(),
      FormBuilderValidators.minLength(10),
    ],
  ),
];

final resetEmailFields = [
  FormFields(
    name: "email",
    label: "Email Address",
    keyboardType: TextInputType.emailAddress,
    validators: [
      FormBuilderValidators.required(),
      FormBuilderValidators.email(),
    ],
  ),
];

final resetPasswordFields = [
  FormFields(
    label: "Password",
    name: "password",
    isPassword: true,
    validators: [
      FormBuilderValidators.required(),
      FormBuilderValidators.password(),
    ],
  ),
  FormFields(
    label: "Confirm password",
    name: "confirmPassword",
    isPassword: true,
    validators: [
      FormBuilderValidators.required(),
      (value) {
        final controller = Get.find<AuthController>();
        final formKey = controller.registerFormKey; // or resetPasswordFormKey

        final password = formKey.currentState?.value['password'];
        if (value != password) {
          return "Passwords do not match";
        }
        return null;
      },
    ],
  ),
];
