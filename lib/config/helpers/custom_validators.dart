
String? emailOrPhoneValidator(String? value) {
  if (value == null || value.trim().isEmpty) {
    return 'Email or phone number is required.';
  }

  // Regex for email validation
  final emailRegex = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$');
  
  // Regex for phone number validation (10-digit numbers, allowing country code prefix)
  final phoneRegex = RegExp(r'^\+?[0-9]{10,15}$');

  if (!emailRegex.hasMatch(value) && !phoneRegex.hasMatch(value)) {
    return 'Enter a valid email address or phone number.';
  }

  return null;
}
String? passwordValidator(String? value) {
  if (value == null || value.trim().isEmpty) {
    return 'Password is required.';
  }
  if (value.length < 8) {
    return 'Password must be at least 8 characters long.';
  }
  return null;
}
String? firstNameValidator(String? value) {
  if (value == null || value.trim().isEmpty) {
    return 'First name is required.';
  }
  // Regex to allow only alphabets and spaces
  final nameRegex = RegExp(r'^[a-zA-Z\s]+$');
  if (!nameRegex.hasMatch(value)) {
    return 'First name can only contain alphabets.';
  }
  if (value.trim().length < 2) {
    return 'First name must be at least 2 characters long.';
  }
  return null;
}
String? passwordStrengthValidator(String? value) {
  if (value == null || value.trim().isEmpty) {
    return 'Password is required.';
  }
  // Regex to check password strength
  final strengthRegex = RegExp(r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$');
  if (!strengthRegex.hasMatch(value)) {
    return 'Password must include at least:\n'
        '- 1 uppercase letter\n'
        '- 1 lowercase letter\n'
        '- 1 number\n'
        '- 1 special character (@, \$, !, %, *, ?, &)\n'
        '- Minimum 8 characters.';
  }
  return null;
}

