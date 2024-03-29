/// MIT License
/// Copyright (c) [2020] Extreme Viet Nam
///
/// Permission is hereby granted, free of charge, to any person obtaining a copy
/// of this software and associated documentation files (the "Software"), to deal
/// in the Software without restriction, including without limitation the rights
/// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
/// copies of the Software, and to permit persons to whom the Software is
/// furnished to do so, subject to the following conditions:
///
/// The above copyright notice and this permission notice shall be included in all
/// copies or substantial portions of the Software.
///
/// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
/// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
/// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
/// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
/// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
/// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
/// SOFTWARE.
import 'dart:async';

import 'package:eventstateprocessor/src/vn/com/extremevn/event_state_processor/type.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Takes a `Stream` of `UiEvent` as input
/// and transforms them into a `Stream` of `DataState` as output.
abstract class EventToStateProcessor<E extends UiEvent, S extends DataState>
    extends Bloc<E, S> {
  EventToStateProcessor(S initialState) : super(initialState);

  late RequestHandler requestHandler;

  /// Register event handler for an event of type `E`.
  /// There should only ever be one event handler per event type `E`.
  @override
  void on<Event extends E>(EventHandler<Event, S> handler,
      {EventTransformer<Event>? transformer}) {
    super.on<Event>((event, emitter) async {
      try {
        await handler.call(event, emitter);
      } catch (ex) {
        onCatchException(ex, emitter);
      }
    });
  }

  /// Catch Exception or Error when event handler throw exception or error
  void onCatchException(dynamic exceptionOrError, Emitter<S> emitter) {}

  /// Send|Raise `UiEvent` [event] for processing in 'on<XXX>' handler function
  void raiseEvent(E event) {
    add(event);
  }

  /// Send|Update [state] for UI
  void updateState(Emitter<S> emitter, S newState) {
    emitter.call(newState);
  }

  /// Send|Raise `UiEvent` [event] for processing in 'processEvent' function
  Future<ResultData> request(RequestData requestData) {
    return requestHandler.call(requestData);
  }
}

/// A [StateEmitter] is similar to [EventToStateProcessor] but has no notion of events
/// and relies on methods to [emit] new states.
///
/// Every [StateEmitter] requires an initial state which will be the
/// state of the [StateEmitter] before [emit] has been called.
///
/// The current state of a [StateEmitter] can be accessed via the [state] getter.
///
/// ```dart
/// class CounterStateEmitter extends StateEmitter<int> {
///   CounterCubit() : super(0);
///
///   void increment() => updateState(state + 1);
/// }
/// ```
class StateEmitter<S> extends Cubit<S> {
  StateEmitter(S initialState) : super(initialState);

  /// Send|Update [state] for UI
  void updateState(S newState) {
    emit(newState);
  }
}

/// Takes a [CreateEventStateProcessorFun] that is responsible for creating the [EventToStateProcessor] and
/// a [child] which will have access to the [EventToStateProcessor] via
/// `BlocProvider.of(context)`.
/// It is used as a dependency injection (DI) widget so that a single instance
/// of a [EventToStateProcessor] can be provided to multiple widgets within a subtree.
///
/// Automatically handles closing the [EventToStateProcessor] when used with [EventToStateProcessor] and lazily
/// creates the provided [EventToStateProcessor] unless [lazy] is set to `false`.
///
/// ```dart
/// ProcessorProvider(
///   create: (BuildContext context) => EventToStateProcessorA(),
///   child: ChildA(),
/// );
/// ```
class ProcessorProvider<EP extends EventToStateProcessor<dynamic, dynamic>>
    extends BlocProvider<EP> {
  const ProcessorProvider({
    Key? key,
    required CreateEventStateProcessorFun<EP> create,
    Widget? child,
    bool lazy = true,
  }) : super(
          key: key,
          create: create,
          child: child,
          lazy: lazy,
        );

  /// Takes a [EventToStateProcessor] and a [child] which will have access to the [EventToStateProcessor] via
  /// `BlocProvider.of(context)`.
  /// When `BlocProvider.value` is used, the [EventToStateProcessor] will not be automatically
  /// closed.
  /// As a result, `BlocProvider.value` should mainly be used for providing
  /// existing [EventToStateProcessor]s to new routes.
  ///
  /// A new [EventToStateProcessor] should not be created in `BlocProvider.value`.
  /// [EventToStateProcessor]s should always be created using the default constructor within
  /// [create].
  ///
  /// ```dart
  /// ProcessorProvider.value(
  ///   value: ProcessorProvider.of<EventToStateProcessorA>(context),
  ///   child: ChildA(),
  /// );
  /// ```
  ProcessorProvider.value({
    Key? key,
    required EP value,
    Widget? child,
  }) : super(
          key: key,
          create: (_) => value,
          child: child,
        );

  /// Method that allows widgets to access a [EventToStateProcessor] instance as long as their
  /// `BuildContext` contains a [ProcessorProvider] instance.
  ///
  /// If we want to access an instance of `EventToStateProcessorA` which was provided higher up
  /// in the widget tree we can do so via:
  ///
  /// ```dart
  /// ProcessorProvider.of<EventToStateProcessorA>(context)
  /// ```
  static T of<T extends EventToStateProcessor<dynamic, dynamic>>(
      BuildContext context) {
    return BlocProvider.of<T>(context);
  }
}

/// Merges multiple [ProcessorProvider] widgets into one widget tree.
///
/// [MultiProcessorProvider] improves the readability and eliminates the need
/// to nest multiple [ProcessorProvider]s.
///
/// By using [MultiProcessorProvider] we can go from:
///
/// ```dart
/// ProcessorProvider<EventToStateProcessorA>(
///   create: (BuildContext context) => EventToStateProcessorA(),
///   child: ProcessorProvider<EventToStateProcessorB>(
///     create: (BuildContext context) => EventToStateProcessorB(),
///     child: ProcessorProvider<EventToStateProcessorC>(
///       create: (BuildContext context) => EventToStateProcessorC(),
///       child: ChildA(),
///     )
///   )
/// )
/// ```
///
/// to:
///
/// ```dart
/// MultiProcessorProvider(
///   providers: [
///     ProcessorProvider<EventToStateProcessorA>(
///       create: (BuildContext context) => EventToStateProcessorA(),
///     ),
///     ProcessorProvider<EventToStateProcessorB>(
///       create: (BuildContext context) => EventToStateProcessorB(),
///     ),
///     ProcessorProvider<EventToStateProcessorC>(
///       create: (BuildContext context) => EventToStateProcessorC(),
///     ),
///   ],
///   child: ChildA(),
/// )
/// ```
///
/// [MultiProcessorProvider] converts the [ProcessorProvider] list into a tree of nested
/// [ProcessorProvider] widgets.
/// As a result, the only advantage of using [MultiProcessorProvider] is improved
/// readability due to the reduction in nesting and boilerplate.
class MultiProcessorProvider extends MultiBlocProvider {
  MultiProcessorProvider({
    Key? key,
    required List<ProcessorProvider> processorProviders,
    required Widget child,
  }) : super(
          key: key,
          providers: processorProviders,
          child: child,
        );
}
