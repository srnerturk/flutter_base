/// Form field validators returning error message or null if valid.

String? required(String? value) {
  if (value == null || value.trim().isEmpty) return 'Required';
  return null;
}

String? email(String? value) {
  if (value == null || value.trim().isEmpty) return null;
  final emailRegex = RegExp(
    r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
  );
  if (!emailRegex.hasMatch(value.trim())) return 'Enter a valid email';
  return null;
}

String? minLength(String? value, int min) {
  if (value == null) return null;
  if (value.length < min) return 'Must be at least $min characters';
  return null;
}

String? maxLength(String? value, int max) {
  if (value == null) return null;
  if (value.length > max) return 'Must be at most $max characters';
  return null;
}

String? pattern(String? value, RegExp regex, [String message = 'Invalid format']) {
  if (value == null || value.isEmpty) return null;
  if (!regex.hasMatch(value)) return message;
  return null;
}

String? combine(String? value, List<String? Function(String?)> validators) {
  for (final v in validators) {
    final err = v(value);
    if (err != null) return err;
  }
  return null;
}
