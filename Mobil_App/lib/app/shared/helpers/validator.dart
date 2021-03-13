class Validator {
  static String isNotEmptyText(String value) {
    if (value.isEmpty) return 'Lütfen alan boş bırakılamaz.';

    return null;
  }

  static String isValidEmail(String value) {
    Pattern pattern = r'^[_a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value))
      return 'Geçersiz e-mail.';
    else
      return null;
  }

  static String isValidatePassword(String value) {
    Pattern pattern = r'^.{6,}$';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value))
      return 'Parola en az 6 karakter uzunluğunda olmalıdır.';
    else
      return null;
  }

  static String isValidateName(String value) {
    if (value.isEmpty) return 'Lütfen bir isim girin.';

    return null;
  }

  static String isValidateNumber(String value) {
    Pattern pattern = r'^\D?(\d{3})\D?\D?(\d{3})\D?(\d{4})$';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value))
      return 'Lütfen geçerli bir numara girin.';
    else
      return null;
  }
}
