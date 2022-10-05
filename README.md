# Event State Processor

A Flutter package that wrap flutter bloc package for clearer implementation. It's more similar to MVI pattern which:
- Reflect data state to view  (ui)
- Process ui event to update state then make change in ui

## Getting Started

This package is use to develop app which use Bloc pattern clearer, quicker, easier by wrapping complicated bloc usage.

### Usage
#### Using ProcessorProvider instead of BlockProvider for providing
	+ event processor instance or  
	+ create processor instance for use in child widget.  

[Example apps](https://github.com/extremevn/event_state_processor/tree/main/example)

#### Implement screen widget
1. Create State extends DataState class. For ex: LoginState
2. Create Event extends UiEvent class. For ex: LoginEvent
	1. Create Login screen and implement 3 function
	   ``
	   class LoginScreen  
	   extends CoreScreen<LoginEvent, LoginState, LoginEventProcessor>
	   ``
	   3.1 `createEventProcessor`: return `EventToStateProcessor` for use in this widget or its child. For ex just:
	   ```return LoginEventProcessor();```
	   3.2 `buildScreenUi`: for build screen ui base on data state by using
	   - `buildStateBuilderWidget`
	   - `buildStateConsumerWidget`
	   - `buildStateListenerWidget`
	   - `buildStateSelectorWidget`
	   - and other widgets for UI elements which is not depended to state

	   For ex: if state is `state.isLoading` is true then show ProgressBar

	    ```
        buildStateBuilderWidget(
                    rebuildOnCondition: (p, c) => p.isLoading != c.isLoading,
                    builder: () => Visibility(
                        visible: state.isLoading, child: LoadingIndicatorWidget())),
        ```

## Dart Versions

- Dart 2: >= 2.6.0

## Contributor

- [Justin Lewis](https://github.com/justin-lewis) (Maintainer)

## License
[MIT](https://choosealicense.com/licenses/mit/)


