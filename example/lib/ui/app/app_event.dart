import 'package:eventstateprocessor/eventstateprocessor.dart';

abstract class AppEvent extends UiEvent {
  const AppEvent();
}

/// An AppStarted event to notify the bloc that it needs to check if the user is currently authenticated or not.
class AppStarted extends AppEvent {}
