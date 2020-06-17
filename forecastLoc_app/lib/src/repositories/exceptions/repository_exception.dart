import 'exception_type.dart';

class RepositoryException {
  final String message;
  final String code;
  final String innerException;
  final StackTrace stackTrace;
  final ExceptionType errorType;

  RepositoryException({this.errorType, this.message, this.code, this.innerException, this.stackTrace});
}
