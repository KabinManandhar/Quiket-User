import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/svg.dart';

import '../../blocs/postBlocs/credentials/credentialBloc.dart';
import '../../control/routes.dart';
import '../../control/style.dart';
import '../../widgets/softButton.dart';

final FocusNode focusName = FocusNode();
final FocusNode focusPhoneNo = FocusNode();
final FocusNode focusEmail = FocusNode();
final FocusNode focusPassword = FocusNode();

class RegisterScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = blocCredential;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      resizeToAvoidBottomPadding: true,
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: Container(
          margin: EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Hero(
                  child: SvgPicture.asset(
                    'assets/images/Logo.svg',
                    height: 100,
                    width: 100,
                    color: Colors.grey[700],
                  ),
                  tag: 'svg',
                ),
                Container(height: 40),
                Text('Sign Up', style: Theme.of(context).textTheme.title),
                Container(height: 20),
                nameField(bloc),
                Container(height: 20),
                phoneNoField(bloc),
                Container(height: 20),
                emailField(bloc),
                Container(height: 20),
                passwordField(bloc),
                Container(height: 20),
                registerButton(bloc),
                Container(height: 40)
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Widget nameField(CredentialsBloc bloc) {
  return StreamBuilder<Object>(
      stream: bloc.name,
      builder: (context, snapshot) {
        return Container(
          child: TextField(
              focusNode: focusName,
              textInputAction: TextInputAction.next,
              onSubmitted: (String value) {
                _fieldFocusChange(context, focusName, focusPhoneNo);
              },
              onChanged: bloc.changeName,
              decoration: InputDecoration(
                  errorText: snapshot.error,
                  border: UnderlineInputBorder(),
                  labelStyle:
                      TextStyle(color: Colors.grey, fontFamily: fontName),
                  labelText: "Name")),
        );
      });
}

Widget phoneNoField(CredentialsBloc bloc) {
  return StreamBuilder<Object>(
      stream: bloc.phoneNo,
      builder: (context, snapshot) {
        return Container(
          child: TextField(
              focusNode: focusPhoneNo,
              textInputAction: TextInputAction.next,
              onSubmitted: (String value) {
                _fieldFocusChange(context, focusPhoneNo, focusEmail);
              },
              onChanged: bloc.changePhoneNo,
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(
                  errorText: snapshot.error,
                  border: UnderlineInputBorder(),
                  labelStyle:
                      TextStyle(color: Colors.grey, fontFamily: fontName),
                  labelText: "Phone Number(+977)")),
        );
      });
}

Widget emailField(CredentialsBloc bloc) {
  return StreamBuilder<Object>(
      stream: bloc.email,
      builder: (context, snapshot) {
        return Container(
          child: TextField(
              focusNode: focusEmail,
              textInputAction: TextInputAction.next,
              onSubmitted: (String value) {
                _fieldFocusChange(context, focusEmail, focusPassword);
              },
              onChanged: bloc.changeEmail,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                  errorText: snapshot.error,
                  border: UnderlineInputBorder(),
                  labelStyle:
                      TextStyle(color: Colors.grey, fontFamily: fontName),
                  labelText: "Email Address")),
        );
      });
}

Widget passwordField(CredentialsBloc bloc) {
  return StreamBuilder<Object>(
      stream: bloc.password,
      builder: (context, snapshot) {
        return TextField(
            focusNode: focusPassword,
            onChanged: bloc.changePassword,
            obscureText: true,
            decoration: InputDecoration(
                errorText: snapshot.error,
                border: UnderlineInputBorder(),
                labelStyle: TextStyle(color: Colors.grey, fontFamily: fontName),
                labelText: "Password"));
      });
}

Widget registerButton(CredentialsBloc bloc) {
  return StreamBuilder<Object>(
      stream: bloc.registerValid,
      builder: (context, snapshot) {
        var data = snapshot.data;
        if (data == null) {
          data = false;
        }
        return AbsorbPointer(
          absorbing: data ? false : true,
          child: SoftButton(
            onClick: () async {
              showDialog(
                barrierDismissible: false,
                context: context,
                builder: (BuildContext context) {
                  return Center(
                      child: Container(
                          height: 60,
                          width: 60,
                          child: SpinKitChasingDots(
                            color: Colors.grey[700],
                            size: 50.0,
                          )));
                },
              );
              bool check = await bloc.register();
              if (check) {
                Navigator.pop(context);
                bloc.removeValues();
                Navigator.pushReplacementNamed(context, loginRoute);
              } else if (check) {
                Scaffold.of(context).showSnackBar(SnackBar(
                  duration: Duration(seconds: 3),
                  content: Text(
                    "Cannot Register.",
                    style: labelTextSmallStyle,
                  ),
                ));
                Navigator.pop(context);
              } else {
                Scaffold.of(context).showSnackBar(
                  SnackBar(
                    duration: Duration(seconds: 3),
                    content: Text(
                      "Sorry,but system failed. Please Try Again.",
                      style: labelTextSmallStyle,
                    ),
                  ),
                );
                Navigator.pop(context);
              }
            },
            opacity: data ? true : false,
            icon: Ionicons.md_checkmark,
            mainAxisAlignment: MainAxisAlignment.end,
          ),
        );
      });
}

_fieldFocusChange(
    BuildContext context, FocusNode currentFocus, FocusNode nextFocus) {
  currentFocus.unfocus();
  FocusScope.of(context).requestFocus(nextFocus);
}
