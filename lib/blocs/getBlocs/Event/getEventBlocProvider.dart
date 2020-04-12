import 'package:flutter/material.dart';
import 'getEventBloc.dart';
export 'getEventBloc.dart';

class GetEventBlocProvider extends InheritedWidget {
  final getEventBloc = GetEventBloc();

  GetEventBlocProvider({Key key, Widget child}) : super(key: key, child: child);

  bool updateShouldNotify(_) => true;

  static GetEventBloc of(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<GetEventBlocProvider>()
        .getEventBloc;
  }
}
