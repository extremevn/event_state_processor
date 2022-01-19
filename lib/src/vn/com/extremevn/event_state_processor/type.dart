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
import 'package:flutter/widgets.dart';

/// Function alias which take [context] for creating EventStateProcessor
typedef CreateEventStateProcessorFun<EP> = EP Function(BuildContext context);

/// Function alias which take [requestData] for processor request screen do some action for result. For example: navigate to new screen
typedef RequestHandler = Future<ResultData> Function(RequestData requestData);

/// Callback function alias which handles logic when there is changes in data state
typedef DataStateChangeHandler<E extends UiEvent, S extends DataState,
        EP extends EventToStateProcessor<E, S>>
    = void Function(BuildContext context, EP processor, S state);

/// Function alias which take [context] for build main screen ui base on [state]
/// and can raise event by using [processor]
typedef ScreenContentBuilder<E extends UiEvent, S extends DataState,
        EP extends EventToStateProcessor<E, S>>
    = Widget Function(BuildContext context, EP processor, S state);

/// Base class for define data state
abstract class DataState {
  const DataState();
}

/// Base class for define ui event
abstract class UiEvent {
  const UiEvent();
}

/// Base class for define ui event
class RequestData {
  final Object? data;
  final int code;

  const RequestData({this.data, required this.code});
}

class ResultData {
  final Object? data;
  final int code;

  const ResultData({this.data, required this.code});

  ResultData.succeed({this.data}) : code = resultSucceed;

  ResultData.failed({this.data}) : code = resultFailed;

  static const int resultSucceed = 1;
  static const int resultFailed = 0;
}
