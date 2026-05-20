class SignatureHelper {
  const SignatureHelper._();

  static String generateSignatureFileName() {
    return 'signature_${DateTime.now().millisecondsSinceEpoch}.png';
  }
}
