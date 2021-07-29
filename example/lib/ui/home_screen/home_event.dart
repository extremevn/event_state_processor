import 'package:eventstateprocessor/eventstateprocessor.dart';

abstract class HomeEvent extends UiEvent {
  const HomeEvent();
}

class LoadDataEvent extends HomeEvent {
  final int page;
  const LoadDataEvent({required this.page});
}

class LoadMoreButtonPressed extends HomeEvent {}
