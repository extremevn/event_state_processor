import 'package:eventstateprocessor/eventstateprocessor.dart';
import 'package:flutter/widgets.dart';

class StateBuilderWidget<ESP extends StateStreamable<S>, S>
    extends BlocBuilder<ESP, S> {
  const StateBuilderWidget(
      {Key? key,
      required BlocWidgetBuilder<S> builder,
      ESP? eventStateProcessor,
      RebuildWidgetOnStateChangeCondition<S>? rebuildOnCondition})
      : super(
            key: key,
            builder: builder,
            bloc: eventStateProcessor,
            buildWhen: rebuildOnCondition);
}

class StateSelectorWidget<ESP extends StateStreamable<S>, S, T>
    extends BlocSelector<ESP, S, T> {
  const StateSelectorWidget({
    Key? key,
    required BlocWidgetSelector<S, T> selector,
    required BlocWidgetBuilder builder,
    ESP? eventStateProcessor,
  }) : super(
            key: key,
            selector: selector,
            builder: builder,
            bloc: eventStateProcessor);
}

class StateConsumerWidget<ESP extends StateStreamable<S>, S>
    extends BlocConsumer<ESP, S> {
  const StateConsumerWidget(
      {Key? key,
      required BlocWidgetBuilder<S> builder,
      required BlocWidgetListener<S> listener,
      ESP? eventStateProcessor,
      RebuildWidgetOnStateChangeCondition<S>? rebuildOnCondition,
      RaiseListenerOnCondition<S>? listenOnCondition})
      : super(
            key: key,
            bloc: eventStateProcessor,
            builder: builder,
            listener: listener,
            buildWhen: rebuildOnCondition,
            listenWhen: listenOnCondition);
}

class StateListenerWidget<ESP extends StateStreamable<S>, S>
    extends BlocListener<ESP, S> {
  const StateListenerWidget(
      {Key? key,
      required BlocWidgetListener<S> listener,
      Widget? child,
      ESP? eventStateProcessor,
      RaiseListenerOnCondition<S>? listenOnCondition})
      : super(
            key: key,
            child: child,
            bloc: eventStateProcessor,
            listener: listener,
            listenWhen: listenOnCondition);
}
