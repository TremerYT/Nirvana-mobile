import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';
import 'package:nirvana_mobile/features/auth/controller/auth_controller.dart';
import 'package:nirvana_mobile/features/auth/models/form_field.dart';
import 'package:nirvana_mobile/features/auth/views/forgot_password.dart';

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
    label: "Full Name",
    name: "fullName",
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
    label: "National ID",
    name: "nationalID",
    validators: [FormBuilderValidators.required()],
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
      (value) {
        final formState =
            Get.find<AuthController>().registerFormKey.currentState;
        final password = formState?.fields['password']?.value;

        if (value == null || value.isEmpty) {
          return "Please confirm your password";
        }

        if (value != password) {
          return "Passwords do not match";
        }
        return null;
      },
    ],
  ),
];

final forgotPasswordFields = [
  FormFields(
    label: "Email",
    name: "email",
    validators: [
      FormBuilderValidators.required(),
      FormBuilderValidators.email(),
    ],
  ),
];
