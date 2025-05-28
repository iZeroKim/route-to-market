class AppException implements Exception {
  final String message;
  final StackTrace? stackTrace;
  AppException(this.message, [this.stackTrace]);

  @override
  String toString() {
    return 'AppException {message: $message, stackTrace: $stackTrace}';
  }
}


class NetworkException extends AppException {
  NetworkException([super.message = 'No internet connection']);
}

class ApiException extends AppException {
  final int? statusCode;

  ApiException(String message, {this.statusCode})
      : super('API Error [$statusCode]: $message');
}

class NotFoundException extends AppException {
  NotFoundException([super.message = 'Resource not found']);
}
