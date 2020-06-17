abstract class BaseTraceSource {
  bool get isInDebugMode;

  void traceError(message, [Object error, StackTrace stackTrace]);

  void traceInfo(dynamic message, [Object error, StackTrace stackTrace]);

  void traceWarning(message, [Object error, StackTrace stackTrace]);
}
