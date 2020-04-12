import 'package:flutter/material.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import '../blocs/getBlocs/Event/getEventBlocProvider.dart';

class Refresh extends StatelessWidget {
  final Widget child;

  Refresh({this.child});

  Widget build(context) {
    final bloc = GetEventBlocProvider.of(context);

    return LiquidPullToRefresh(
      color: Colors.grey[300],
      backgroundColor: Colors.grey,
      child: child,
      onRefresh: () async {
        await bloc.getIds();
      },
    );
  }
}
