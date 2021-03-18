import 'package:eventstateprocessor/eventstateprocessor.dart';
import 'package:example_event_state_processor/ui/app/app_data_state.dart';
import 'package:example_event_state_processor/ui/app/app_event.dart';

class AppEventProcessor extends EventToStateProcessor<AppEvent, AppDataState> {
  @override
  AppDataState get initialState => const AppDataState(state: AppState.uninitialized);

  @override
  Stream<AppDataState> processEvent(
    AppEvent event,
  ) async* {
    if (event is AppStarted) {
      await Future.delayed(const Duration(milliseconds: 4000));
      yield state.copy(newState: AppState.home);
    }
  }
}
