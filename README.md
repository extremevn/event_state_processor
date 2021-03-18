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
  
Example:   
```
void main() {  
	 runApp( 
		 ProcessorProvider<AuthenticationEventProcessor>( 
			 create: (BuildContext context) => AuthenticationEventProcessor(), 
			 child: const App(), 
		 ), 
	 );
 }
 ```
#### Implement screen widget
1. Create State extends DataState class. For ex: LoginState
2. Create Event extends UiEvent class. For ex: LoginEvent
3. Create Login screen and implement 3 function
	``
class LoginScreen  
    extends CoreScreen<LoginEvent, LoginState, LoginEventProcessor>
``
	3.1 `handleDataStateChange`: handle state change after processor handle event and change widget state. For ex: press login button --> process by processor --> processor change state to LoginFailure because of invalid of login data so we want to show Alert dialog for example, do it in this function.
	```
	if (newState.error != null) {  
	  showAlertDialog(context, Text(state.error.message));  
	}
	```
	3.2 `createEventProcessor`: return `EventToStateProcessor` for use in this widget or its child. For ex just:
		```return LoginEventProcessor();```
	3.3 `buildScreenUi`: for build screen ui base on data state. For ex: if state is `state.isLoading` is true then show ProgressBar

	```
	if (state.isLoading) LoadingIndicatorWidget() else Container()
	```
  
## Dart Versions

- Dart 2: >= 2.6.0

## Contributor

- [Justin Lewis](https://github.com/justin-lewis) (Maintainer)
  
## License
[MIT](https://choosealicense.com/licenses/mit/)


