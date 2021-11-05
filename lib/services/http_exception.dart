class HttpException implements Exception {
  final String message;

  HttpException(this.message); // Pass your message in constructor.

  @override
  String toString() {
    return message;
  }
}
