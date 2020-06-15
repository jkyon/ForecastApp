import 'package:flutter_bloc/flutter_bloc.dart';

class BaseBlocDelegate extends BlocDelegate {
  
  //final BaseTraceSource traceSource;

  BaseBlocDelegate(/*{@required this.traceSource}*/);

  @override
  void onEvent(Bloc bloc, Object event) {
    super.onEvent(bloc, event);
    //this.traceSource.traceInfo("Event", event);
  }

  @override
  void onError(Bloc bloc, Object error, StackTrace stacktrace) {
    super.onError(bloc, error, stacktrace);
    //this.traceSource.traceError("Error", error, stacktrace);
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    //this.traceSource.traceInfo("Transition", transition);
  }
}