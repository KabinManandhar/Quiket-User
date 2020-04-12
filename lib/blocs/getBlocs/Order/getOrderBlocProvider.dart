import 'package:flutter/material.dart';
import 'getOrderBloc.dart';
export 'getOrderBloc.dart';

class GetOrderBlocProvider extends InheritedWidget {
  final getOrderBloc = GetOrderBloc();

  GetOrderBlocProvider({Key key, Widget child}) : super(key: key, child: child);

  bool updateShouldNotify(_) => true;

  static GetOrderBloc of(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<GetOrderBlocProvider>()
        .getOrderBloc;
  }
}
