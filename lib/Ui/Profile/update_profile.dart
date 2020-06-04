import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:image_picker/image_picker.dart';

import '../../blocs/postBlocs/credentials/credentialBloc.dart';
import '../../control/style.dart';
import '../../models/user_model.dart';
import '../../resources/authProvider.dart';
import '../../widgets/softButton.dart';

String base64Image;

class UpdateProfileScreen extends StatefulWidget {
  final int userId;

  UpdateProfileScreen({this.userId});

  @override
  _UpdateProfileScreenState createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen> {
  final _auth = AuthProvider();
  var eventPicture;

  Widget build(BuildContext context) {
    final bloc = blocCredential;
    return FutureBuilder(
      future: _auth.getUserProfile(widget.userId),
      builder: (context, AsyncSnapshot<UserModel> snapshot) {
        if (snapshot.hasData == false) {
          return Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              color: Colors.grey[300]);
        }
        if (snapshot.hasData) {
          UserModel user = snapshot.data;
          return Scaffold(
            resizeToAvoidBottomInset: true,
            resizeToAvoidBottomPadding: true,
            body: GestureDetector(
              onTap: () {
                FocusScope.of(context).requestFocus(FocusNode());
              },
              child: CustomScrollView(
                slivers: <Widget>[
                  SliverAppBar(
                    elevation: 0,
                    expandedHeight: 200.0,
                    floating: true,
                    pinned: true,
                    flexibleSpace: FlexibleSpaceBar(
                      background: profilePicturePicker(bloc, user.picture),
                    ),
                  ),
                  SliverFillRemaining(
                    child: Container(
                      margin: EdgeInsets.all(20.0),
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            nameField(bloc, user.name),
                            Container(height: 30),
                            passwordField(bloc),
                            Container(height: 20),
                            emailField(bloc, user.email),
                            Container(height: 30),
                            phoneNoField(bloc, user.phoneNo),
                            Container(height: 30),
                            descriptionField(bloc, user.description),
                            Container(height: 30),
                            Center(
                              child: updateButton(bloc, user),
                            ),
                            Container(height: 40)
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        } else {
          return Container();
        }
      },
    );
  }

  Future<File> _chooseImage() {
    setState(
      () {
        eventPicture = ImagePicker.pickImage(source: ImageSource.gallery);
      },
    );
  }

  Widget profilePicturePicker(CredentialsBloc bloc, picture) {
    return StreamBuilder<Object>(
      stream: bloc.picture,
      builder: (context, snapshot) {
        return GestureDetector(
          onTapDown: (TapDownDetails details) {
            _chooseImage();
          },
          child: Container(
            child: FutureBuilder<File>(
              future: eventPicture,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  base64Image = 'data:image/png;base64,' +
                      base64Encode(snapshot.data.readAsBytesSync());
                  return Image.file(snapshot.data, fit: BoxFit.cover);
                } else {
                  return picture == null
                      ? Icon(
                          MaterialIcons.add_a_photo,
                          size: 160,
                          color: Colors.grey,
                        )
                      : Image.network(
                          "http://192.168.100.70:8000" + picture,
                          fit: BoxFit.cover,
                        );
                }
              },
            ),
          ),
        );
      },
    );
  }

  Widget phoneNoField(CredentialsBloc bloc, phoneNo) {
    return StreamBuilder<Object>(
      stream: bloc.phoneNo,
      builder: (context, snapshot) {
        return Container(
          child: TextField(
              textInputAction: TextInputAction.done,
              onChanged: bloc.changePhoneNo,
              keyboardType: TextInputType.number,
              inputFormatters: [
                BlacklistingTextInputFormatter(new RegExp('[\\-|\\ ]'))
              ],
              decoration: InputDecoration(
                  errorText: snapshot.error,
                  border: UnderlineInputBorder(),
                  labelStyle: labelTextStyle,
                  labelText: "Phone No.",
                  hintText: phoneNo,
                  hintStyle: labelTextSmallStyle)),
        );
      },
    );
  }

  Widget descriptionField(CredentialsBloc bloc, description) {
    return StreamBuilder<Object>(
      stream: bloc.description,
      builder: (context, snapshot) {
        return Container(
          child: TextField(
              textInputAction: TextInputAction.done,
              onChanged: bloc.changeDescription,
              decoration: InputDecoration(
                  errorText: snapshot.error,
                  border: UnderlineInputBorder(),
                  labelStyle: labelTextStyle,
                  labelText: "Description",
                  hintText: description,
                  hintStyle: labelTextSmallStyle)),
        );
      },
    );
  }

  Widget nameField(CredentialsBloc bloc, name) {
    return StreamBuilder<Object>(
      stream: bloc.name,
      builder: (context, snapshot) {
        return Container(
          child: TextField(
              textInputAction: TextInputAction.done,
              onChanged: bloc.changeName,
              decoration: InputDecoration(
                  errorText: snapshot.error,
                  border: UnderlineInputBorder(),
                  labelStyle: labelTextStyle,
                  labelText: "Name",
                  hintText: name,
                  hintStyle: labelTextSmallStyle)),
        );
      },
    );
  }

  Widget emailField(CredentialsBloc bloc, email) {
    return StreamBuilder<Object>(
      stream: bloc.email,
      builder: (context, snapshot) {
        return Container(
          child: TextField(
              textInputAction: TextInputAction.done,
              onChanged: bloc.changeEmail(email),
              decoration: InputDecoration(
                  errorText: snapshot.error,
                  border: UnderlineInputBorder(),
                  labelStyle: labelTextStyle,
                  labelText: "Email(For Verification)",
                  hintText: email,
                  hintStyle: labelTextSmallStyle,
                  counterText: 'Cannot Change Email',
                  counterStyle: labelTextSmallStyle)),
        );
      },
    );
  }

  Widget passwordField(CredentialsBloc bloc) {
    return StreamBuilder<Object>(
      stream: bloc.password,
      builder: (context, snapshot) {
        return Container(
          child: TextField(
            textInputAction: TextInputAction.done,
            onChanged: bloc.changePassword,
            obscureText: true,
            decoration: InputDecoration(
                errorText: snapshot.error,
                border: UnderlineInputBorder(),
                labelStyle: labelTextStyle,
                labelText: "Password",
                counterText: 'Changes Password',
                counterStyle: labelTextSmallStyle),
          ),
        );
      },
    );
  }

  Widget updateButton(CredentialsBloc bloc, user) {
    return StreamBuilder<Object>(
      stream: bloc.updateValid,
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
                      ),
                    ),
                  );
                },
              );
              bloc.changePicture(base64Image);
              bool check = await bloc.update(widget.userId, user);
              if (check) {
                Navigator.pop(context);
                bloc.removeValues();
                Navigator.pop(context);
                // Navigator.pushReplacementNamed(context, loginRoute);
              } else if (check) {
                Scaffold.of(context).showSnackBar(
                  SnackBar(
                    duration: Duration(seconds: 3),
                    content: Text(
                      "Cannot Update. Please Try Again.",
                      style: labelTextSmallStyle,
                    ),
                  ),
                );
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
      },
    );
  }
}
