class ValidationInfo {
  final bool isValid;
  final String? error;

    const ValidationInfo({
    required this.isValid,
    this.error
  });
}
