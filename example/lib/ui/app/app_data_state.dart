import 'package:eventstateprocessor/eventstateprocessor.dart';

class AppDataState extends DataState {
  final AppState appState;
  const AppDataState({required this.appState});

  AppDataState copy({AppState? newState}) =>
      AppDataState(appState: newState ?? appState);
}

enum AppState { uninitialized, home }
