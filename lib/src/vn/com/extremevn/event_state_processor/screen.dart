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
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Base class for building screen ui
abstract class CoreScreen<E extends UiEvent, S extends DataState,
    EP extends EventToStateProcessor<E, S>> extends StatelessWidget {
  const CoreScreen({Key? key}) : super(key: key);

  /// This method will be call whenever [processor] produce a new data state after processing received event from ui
  /// For ex: we can show dialog if new state is error data state
  /// ```
  ///	if (newState.error != null) {
  ///	  showAlertDialog(context, Text(state.error.message));
  ///	}
  ///	```
  void handleDataStateChange(BuildContext context, EP processor, S state);

  /// Create & return `EventToStateProcessor` instance for use in this widget or its child. For ex:
  /// ```return LoginEventProcessor();```
  EP createEventProcessor(BuildContext context);

  /// This method for build screen ui base on current data state. For ex: if state is `state.isLoading` is true then show ProgressBar
  ///	```if (state.isLoading) LoadingIndicatorWidget() else Container()```
  Widget buildScreenUi(BuildContext context, EP processor, S state);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<EP>(
      create: createEventProcessor,
      child: _ScreenContentWidget<E, S, EP>(
        handleDataStateChange,
        buildScreenUi,
      ),
    );
  }
}

class _ScreenContentWidget<E extends UiEvent, S extends DataState,
    EP extends EventToStateProcessor<E, S>> extends StatefulWidget {
  const _ScreenContentWidget(
    DataStateChangeHandler<E, S, EP> dataStateChangeHandler,
    ScreenContentBuilder<E, S, EP> screenContentBuilder, {
    Key? key,
  })  : _dataStateChangeHandler = dataStateChangeHandler,
        _screenContentBuilder = screenContentBuilder,
        super(key: key);

  final DataStateChangeHandler<E, S, EP> _dataStateChangeHandler;
  final ScreenContentBuilder<E, S, EP> _screenContentBuilder;

  @override
  _CoreWidgetStateState createState() {
    return _CoreWidgetStateState<E, S, EP>();
  }
}

class _CoreWidgetStateState<E extends UiEvent, S extends DataState,
        EP extends EventToStateProcessor<E, S>>
    extends State<_ScreenContentWidget> {
  late EP _eventProcessor;

  @override
  void initState() {
    _eventProcessor = BlocProvider.of<EP>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // Get screen args here for init screen's variable value;
    // Listen for state change and build screen ui
    return BlocListener<EP, S>(
        bloc: _eventProcessor,
        listener: (context, state) {
          widget._dataStateChangeHandler.call(context, _eventProcessor, state);
        },
        child: BlocBuilder(
            bloc: _eventProcessor,
            builder: (context, state) {
              return widget._screenContentBuilder
                  .call(context, _eventProcessor, state as S);
            }));
  }
}
