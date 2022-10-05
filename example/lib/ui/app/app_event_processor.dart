import 'package:eventstateprocessor/eventstateprocessor.dart';
import 'package:example_event_state_processor/ui/app/app_data_state.dart';
import 'package:example_event_state_processor/ui/app/app_event.dart';

class AppEventProcessor extends EventToStateProcessor<AppEvent, AppDataState> {
  AppEventProcessor()
      : super(const AppDataState(appState: AppState.uninitialized)) {
    on<AppStarted>(onAppStared);
  }

  Future<void> onAppStared(
      AppStarted event, Emitter<AppDataState> emitter) async {
    await Future.delayed(const Duration(milliseconds: 4000));
    updateState(emitter, state.copy(newState: AppState.home));
  }
}
