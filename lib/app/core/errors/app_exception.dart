class AppException implements Exception {
  const AppException({
    required this.message,
    this.code,
    this.data,
  });

  final String message;
  final String? code;
  final Object? data;

  @override
  String toString() => 'AppException(code: $code, message: $message)';
}
