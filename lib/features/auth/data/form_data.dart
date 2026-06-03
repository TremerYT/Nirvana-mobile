import 'package:form_builder_validators/form_builder_validators.dart';
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
