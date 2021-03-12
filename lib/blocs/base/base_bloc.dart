import '../../common/app_log_helper.dart';
import 'base_bloc_event.dart';
import 'base_bloc_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class BaseBloc<E extends BaseBlocEvent, S extends BaseBlocState>
    extends Bloc<E, S> with AppLogHelper {
  BaseBloc(S initialState) : super(initialState);

  @override
  Stream<S> mapEventToState(
    E event,
  ) async* {
    try {
      yield* mapEventToStateTC(event);
    } catch (e, s) {
      printLog(e);
      printLog(s);
    }
  }

  /// removeMe: added for testing
  Stream<S> mapEventToStateTC(E event) {
    printLog("mapEventToStateTC-->$event");
  }
}
