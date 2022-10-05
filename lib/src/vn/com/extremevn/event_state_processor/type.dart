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
import 'package:flutter/widgets.dart';

/// Function alias which take [context] for creating EventStateProcessor
typedef CreateEventStateProcessorFun<EP> = EP Function(BuildContext context);

/// Function alias which take [requestData] for processor request screen do
/// some action for result. For example: navigate to new screen
typedef RequestHandler = Future<ResultData> Function(RequestData requestData);

/// Function which takes the previous `state` and
/// the current `state`, it is responsible for returning a [bool] which
/// determines whether to rebuild with the current `state`.
typedef RebuildWidgetOnStateChangeCondition<S> = bool Function(
    S previous, S current);

/// Function which takes the previous `state`
/// and the current `state` and is responsible for returning a [bool] which
/// determines whether or not to call listener function with the current `state`.
typedef RaiseListenerOnCondition<S> = bool Function(S previous, S current);

/// Function which take current state of [CoreScreen] - in other words which is
/// current state of processor and is responsible for returning a selected
/// value, [T], based on [state].
typedef SelectorFunction<T> = T Function();

/// Function is responsible for returning a widget
typedef ReturnWidgetFunction = Widget Function();

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
