import 'package:flutter/material.dart';

import 'blocs/getBlocs/Event/getEventBlocProvider.dart';
import 'blocs/getBlocs/Order/getOrderBlocProvider.dart';
import 'blocs/getBlocs/Ticket/getTicketBlocProvider.dart';
import 'blocs/postBlocs/Credentials/credentialBlocProvider.dart';
import 'control/routes.dart';
import 'control/themedata.dart';

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return GetOrderBlocProvider(
      child: GetTicketBlocProvider(
        child: CredentialsBlocProvider(
          child: GetEventBlocProvider(
            child: MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'Quiket Organizers',
              theme: themedata(),
              onGenerateRoute: routes,
            ),
          ),
        ),
      ),
    );
  }
}
