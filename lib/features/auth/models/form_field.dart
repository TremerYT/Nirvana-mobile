class FormFields {
  final String label;
  final String name;
  final bool isPassword;
  final List<String? Function(String?)>? validators;

  FormFields({
    required this.label,
    required this.name,
    this.isPassword = false,
    this.validators,
  });
}
