import 'package:eventstateprocessor/eventstateprocessor.dart';


class AppDataState extends DataState {
  final AppState state;
  const AppDataState({this.state});

  AppDataState copy({AppState newState}) =>
      AppDataState(state: newState ?? state);
}

enum AppState { uninitialized, home}
