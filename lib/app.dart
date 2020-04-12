import 'package:flutter/material.dart';
import 'package:testawwpp/blocs/getBlocs/Event/getEventBlocProvider.dart';
import 'package:testawwpp/blocs/getBlocs/Ticket/getTicketBlocProvider.dart';
import 'package:testawwpp/blocs/postBlocs/Credentials/credentialBlocProvider.dart';

import 'package:testawwpp/control/routes.dart';

import 'package:testawwpp/control/themedata.dart';

import 'blocs/getBlocs/Order/getOrderBlocProvider.dart';

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
