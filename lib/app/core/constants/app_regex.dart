class AppRegex {
  const AppRegex._();

  /// Simple Indonesian plate number format.
  /// Example: B 1234 ABC, D 123 AA, AB 1234 CD.
  static final RegExp indonesiaPlateNumber = RegExp(
    r'^[A-Z]{1,2}\s\d{1,4}\s[A-Z]{1,3}$',
  );

  static final RegExp numberOnly = RegExp(r'^[0-9]+$');
}
