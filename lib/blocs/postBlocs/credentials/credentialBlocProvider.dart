import 'package:flutter/material.dart';

import 'credentialBloc.dart';

export 'credentialBloc.dart';

class CredentialsBlocProvider extends InheritedWidget {
  final CredentialsBloc credentialBloc = CredentialsBloc();

  CredentialsBlocProvider({Key key, Widget child})
      : super(key: key, child: child);

  bool updateShouldNotify(_) => true;

  static CredentialsBloc of(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<CredentialsBlocProvider>()
        .credentialBloc;
  }
}
