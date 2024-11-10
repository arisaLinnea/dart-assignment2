class DatabaseException implements Exception {
  final String _message;
  final String? _details;

  DatabaseException({required String message, String? details})
      : _message = message,
        _details = details;

  @override
  String toString() {
    if (_details != null) {
      return 'DatabaseException: $_message - $_details';
    }
    return 'DatabaseException: $_message';
  }
}
