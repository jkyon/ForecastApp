import 'package:logging/logging.dart';

import 'diagnostics.dart';

class TraceSource implements BaseTraceSource {
  bool _isInDebugMode;

  Logger logger;

  TraceSource() {
    assert(_isInDebugMode = true);

    logger = Logger('PaysettLogger');

    logger.onRecord
        .where((record) => record.loggerName == logger.name)
        .where((record) => record.level == _isLevelAllowed(record.level))
        .listen((LogRecord rec) {
      print(
          '${rec.level.name}: ${rec.time}: ${rec.message}: ${rec.stackTrace}');
    });
  }

  @override
  bool get isInDebugMode => _isInDebugMode;

  @override
  void traceError(message, [Object error, StackTrace stackTrace]) {
    logger.severe(message, error, stackTrace);
  }

  @override
  void traceInfo(message, [Object error, StackTrace stackTrace]) {
    logger.info(message, error, stackTrace);
  }

  @override
  void traceWarning(message, [Object error, StackTrace stackTrace]) {
    logger.warning(message, error, stackTrace);
  }

  Level _isLevelAllowed(Level level) {
    var levelRequested = kLevelAllowed.where((x) => x == level);
    if (levelRequested.isNotEmpty) {
      return levelRequested.first;
    }
    return null;
  }
}

const List<Level> kLevelAllowed = [
  Level.SEVERE,
];
