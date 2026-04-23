class Validators {
  // NAME VALIDATION
  static String? name(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "Name is required";
    }

    final trimmed = value.trim();

    if (trimmed.length < 3) {
      return "Name must be at least 3 characters";
    }

    if (RegExp(r'^[0-9]').hasMatch(trimmed)) {
      return "Name cannot start with a number";
    }

    final regex = RegExp(r"^[A-Za-z][A-Za-z0-9\s]*$");

    if (!regex.hasMatch(trimmed)) {
      return "Name can only contain letters, numbers, and spaces";
    }

    return null;
  }

  // EMAIL VALIDATION
  static String? email(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "Email is required";
    }

    final email = value.trim();

    final regex = RegExp(r"^[\w-.]+@([\w-]+\.)+[\w-]{2,4}$");

    if (!regex.hasMatch(email)) {
      return "Enter a valid email (example: name@email.com)";
    }

    return null;
  }

  // PASSWORD VALIDATION
  static String? password(String? value) {
    if (value == null || value.isEmpty) {
      return "Password is required";
    }

    if (value.length < 8) {
      return "Password must be at least 8 characters";
    }

    if (value.length > 20) {
      return "Password must not exceed 20 characters";
    }

    if (!RegExp(r'.*[A-Z].*').hasMatch(value)) {
      return "Must contain at least one uppercase letter";
    }

    if (!RegExp(r'.*[a-z].*').hasMatch(value)) {
      return "Must contain at least one lowercase letter";
    }

    if (!RegExp(r'.*\d.*').hasMatch(value)) {
      return "Must contain at least one number";
    }

    return null;
  }

  // CONFIRM PASSWORD
  static String? confirmPassword(String? value, String password) {
    if (value == null || value.isEmpty) {
      return "Please confirm your password";
    }

    if (value != password) {
      return "Passwords do not match";
    }

    return null;
  }
}