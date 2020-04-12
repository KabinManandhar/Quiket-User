import 'package:flutter/material.dart';
import 'getTicketBloc.dart';
export 'getTicketBloc.dart';

class GetTicketBlocProvider extends InheritedWidget {
  final getTicketBloc = GetTicketBloc();

  GetTicketBlocProvider({Key key, Widget child})
      : super(key: key, child: child);

  bool updateShouldNotify(_) => true;

  static GetTicketBloc of(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<GetTicketBlocProvider>()
        .getTicketBloc;
  }
}
