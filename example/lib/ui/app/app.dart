import 'package:eventstateprocessor/eventstateprocessor.dart';
import 'package:example_event_state_processor/configs/colors.dart';
import 'package:example_event_state_processor/ui/app/app_data_state.dart';
import 'package:example_event_state_processor/ui/app/app_event.dart';
import 'package:example_event_state_processor/ui/app/app_event_processor.dart';
import 'package:example_event_state_processor/ui/app/translation.dart';
import 'package:example_event_state_processor/ui/home_screen/home_screen.dart';
import 'package:example_event_state_processor/ui/splash/splash_screen.dart';
import 'package:example_event_state_processor/ui/view_common/loading_indicator_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';


AppEventProcessor appEventProcessor;


class App extends CoreScreen<AppEvent, AppDataState, AppEventProcessor> {

  @override
  Widget buildScreenUi(BuildContext context, AppEventProcessor processor, AppDataState state) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        textTheme: Theme.of(context).textTheme.apply(
          displayColor: AppColors.black,
        ),
        scaffoldBackgroundColor: AppColors.lightGrey,
        primarySwatch: Colors.blue,
      ),
      localizationsDelegates: const [
        TranslationsDelegate(),
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        DefaultCupertinoLocalizations.delegate
      ],
      supportedLocales: const [
        Locale('en'),
      ],
      home: _getScreen(state),
    );
  }

  @override
  AppEventProcessor createEventProcessor(BuildContext context) {
    appEventProcessor = AppEventProcessor();
    appEventProcessor.raiseEvent(AppStarted());
    return appEventProcessor;
  }

  @override
  void handleDataStateChange(BuildContext context, AppEventProcessor processor, AppDataState state) {}

  Widget _getScreen(AppDataState appDataState) {
    switch (appDataState.state) {
      case AppState.uninitialized:
        return SplashScreen();
      case AppState.home:
        return HomeScreen();
      default:
        return LoadingIndicatorWidget();
    }
  }
}
