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
import 'package:eventstateprocessor/src/vn/com/extremevn/event_state_processor/processor.dart';
import 'package:eventstateprocessor/src/vn/com/extremevn/event_state_processor/type.dart';
import 'package:eventstateprocessor/src/vn/com/extremevn/event_state_processor/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Base class for building screen ui
//ignore: must_be_immutable
abstract class CoreScreen<E extends UiEvent, S extends DataState,
    EP extends EventToStateProcessor<E, S>> extends StatefulWidget {
  CoreScreen({Key? key}) : super(key: key);

  /// Processor for current screen
  late EP _processor;

  /// Processor getter
  EP get processor => _processor;

  /// Current state getter
  S get currentState => _processor.state;

  /// Shortcut access to current build context
  late BuildContext _context;

  /// Public getter for current build context
  BuildContext get context => _context;

  /// Public getter for current build state
  S get state => _processor.state;

  /// TickerProvider for animation uses
  late TickerProvider _tickerProvider;

  /// TickerProvider public getter for animation uses
  TickerProvider get tickerProvider => _tickerProvider;

  /// Util getter for whether screen is current active
  bool get isCurrentActive => ModalRoute.of(context)?.isCurrent ?? false;

  EP _internalCreateEventProcessor(BuildContext context) {
    _processor = createEventProcessor(context);
    _processor.requestHandler = handleRequest;
    return _processor;
  }

  /// Create & return `EventToStateProcessor` instance for use in this widget or its child. For ex:
  /// ```return LoginEventProcessor();```
  EP createEventProcessor(BuildContext context);

  /// This method for build screen ui base on current data state. For ex: if state is `state.isLoading` is true then show ProgressBar
  ///	```if (state.isLoading) LoadingIndicatorWidget() else Container()```
  Widget buildScreenUi(BuildContext context);

  Widget _internalBuildScreenUi(BuildContext context) {
    _context = context;
    _processor = context.read<EP>();
    return buildScreenUi(context);
  }

  /// This method for handle request from processor or others return data for example: navigate to new screen and wait for result
  Future<ResultData> handleRequest(RequestData requestData) {
    // do nothing here
    return Future.value(ResultData.succeed());
  }

  /// Call when screen which is statefull widget init its state
  void onScreenInit() {
    // do nothing here
  }

  /// Call when screen which is statefull widget dispose
  void onScreenDisposed() {
    // do nothing here
  }

  Widget buildStateBuilderWidget(
      {Key? key,
      required ReturnWidgetFunction builder,
      RebuildWidgetOnStateChangeCondition<S>? rebuildOnCondition}) {
    return StateBuilderWidget<EP, S>(
        key: key,
        builder: (_, __) => builder.call(),
        rebuildOnCondition: rebuildOnCondition);
  }

  Widget buildStateConsumerWidget(
      {Key? key,
      required ReturnWidgetFunction builder,
      required VoidCallback listener,
      required Widget child,
      RebuildWidgetOnStateChangeCondition<S>? rebuildOnCondition,
      RaiseListenerOnCondition<S>? listenOnCondition}) {
    return StateConsumerWidget<EP, S>(
        key: key,
        builder: (_, __) => builder.call(),
        listener: (_, __) => listener.call(),
        rebuildOnCondition: rebuildOnCondition,
        listenOnCondition: listenOnCondition);
  }

  Widget buildStateListenerWidget(
      {Key? key,
      required VoidCallback listener,
      required Widget child,
      RaiseListenerOnCondition<S>? listenOnCondition}) {
    return StateListenerWidget<EP, S>(
        key: key,
        listener: (_, __) => listener.call(),
        listenOnCondition: listenOnCondition,
        child: child);
  }

  Widget buildStateSelectorWidget<T>({
    Key? key,
    required SelectorFunction<T> selector,
    required ReturnWidgetFunction builder,
  }) {
    return StateSelectorWidget<EP, S, T>(
        key: key,
        builder: (_, __) => builder.call(),
        selector: (S) => selector.call());
  }

  @override
  State<CoreScreen<E, S, EP>> createState() => _CoreScreenState<E, S, EP>();
}

class _CoreScreenState<E extends UiEvent, S extends DataState,
        EP extends EventToStateProcessor<E, S>>
    extends State<CoreScreen<E, S, EP>> with TickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    widget._tickerProvider = this;
    widget.onScreenInit();
  }

  @override
  void dispose() {
    widget.onScreenDisposed();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    widget._tickerProvider = this;
    return BlocProvider<EP>(
        create: widget._internalCreateEventProcessor,
        child: _ScreenContent(widget._internalBuildScreenUi));
  }
}

class _ScreenContent<E extends UiEvent, S extends DataState,
    EP extends EventToStateProcessor<E, S>> extends StatelessWidget {
  const _ScreenContent(
    this._screenContentBuilder, {
    Key? key,
  }) : super(key: key);

  final WidgetBuilder _screenContentBuilder;

  @override
  Widget build(BuildContext context) {
    // Get screen args here for init screen's variable value;
    // Listen for state change and build screen ui
    return _screenContentBuilder.call(context);
  }
}
