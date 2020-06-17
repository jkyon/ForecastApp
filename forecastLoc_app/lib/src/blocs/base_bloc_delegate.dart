import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forecast_app/src/diagnostics/diagnostics.dart';

class BaseBlocDelegate extends BlocDelegate {
  final BaseTraceSource traceSource;

  BaseBlocDelegate({@required this.traceSource});

  @override
  void onEvent(Bloc bloc, Object event) {
    super.onEvent(bloc, event);
    traceSource.traceInfo('Event', event);
  }

  @override
  void onError(Bloc bloc, Object error, StackTrace stacktrace) {
    super.onError(bloc, error, stacktrace);
    traceSource.traceError('Error', error, stacktrace);
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    traceSource.traceInfo('Transition', transition);
  }
}
