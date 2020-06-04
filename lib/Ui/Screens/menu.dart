import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:flutter_icons/flutter_icons.dart';

import '../../blocs/postBlocs/credentials/credentialBloc.dart';
import '../../control/routes.dart';
import '../../control/style.dart';

class MenuScreen extends StatelessWidget {
  final int userId;

  MenuScreen({this.userId});

  Widget build(BuildContext context) {
    TextEditingController _textFieldFeedBackController =
        TextEditingController();
    TextEditingController _textFieldReportController = TextEditingController();
    final bloc = blocCredential;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(100),
        child: AppBar(
          automaticallyImplyLeading: false,
          actions: <Widget>[
            IconButton(
              onPressed: () async {
                bool check = await bloc.logout();
                if (check) {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          backgroundColor: Colors.grey[300],
                          title: Text(
                            "Logout Successfully.",
                            style: labelTextSmallStyle,
                          ),
                          actions: <Widget>[
                            FlatButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                                bloc.removeValues();
                                Navigator.pushReplacementNamed(
                                    context, loginRoute);
                              },
                              child: Text(
                                'OK',
                                style: labelTextSmallStyle,
                              ),
                            )
                          ],
                        );
                      });
                } else {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          backgroundColor: Colors.grey[300],
                          title: Text(
                            "Logout Unsuccessful.",
                            style: labelTextSmallStyle,
                          ),
                          actions: <Widget>[
                            FlatButton(
                              onPressed: () {
                                bloc.logout();
                              },
                              child: Text(
                                'OK',
                                style: labelTextSmallStyle,
                              ),
                            )
                          ],
                        );
                      });
                }
              },
              icon:
                  Icon(AntDesign.logout, color: buttonColor, size: buttonSize),
            )
          ],
          title: Text(
            'Menu',
          ),
          elevation: 0,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            ListTile(
              leading: Icon(SimpleLineIcons.user),
              onTap: () {
                Navigator.pushNamed(context, '/showProfile/$userId');
              },
              title: Text(
                'Profile',
                style: labelTextStyle,
              ),
              subtitle: Text(
                'View/Make changes to your Profile.',
                style: labelTextSmallStyle,
              ),
            ),
            Divider(
              height: 30,
            ),
            ListTile(
              leading: Icon(SimpleLineIcons.pencil),
              onTap: () {
                return showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: Text('Feedback'),
                        content: TextField(
                          controller: _textFieldFeedBackController,
                          decoration: InputDecoration(
                              border: UnderlineInputBorder(),
                              labelStyle: TextStyle(
                                  color: Colors.grey, fontFamily: fontName),
                              labelText: "Feedback"),
                        ),
                        actions: <Widget>[
                          FlatButton(
                            child: Text('Submit'),
                            onPressed: () async {
                              final Email email = Email(
                                body: _textFieldReportController.text,
                                subject: 'Feedbacks',
                                recipients: ['quiketmanagement@gmail.com'],
                                isHTML: false,
                              );

                              await FlutterEmailSender.send(email);
                            },
                          ),
                          FlatButton(
                            child: new Text('Cancel'),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          )
                        ],
                      );
                    });
              },
              title: Text(
                'Feedback',
                style: labelTextStyle,
              ),
              subtitle: Text(
                'Give us feedbacks.',
                style: labelTextSmallStyle,
              ),
            ),
            Divider(
              height: 30,
            ),
            ListTile(
              leading: Icon(SimpleLineIcons.pencil),
              onTap: () {
                return showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: Text('Report'),
                        content: TextField(
                          controller: _textFieldFeedBackController,
                          decoration: InputDecoration(
                              border: UnderlineInputBorder(),
                              labelStyle: TextStyle(
                                  color: Colors.grey, fontFamily: fontName),
                              labelText: "Report"),
                        ),
                        actions: <Widget>[
                          FlatButton(
                            child: new Text('Submit'),
                            onPressed: () async {
                              final Email email = Email(
                                body: _textFieldReportController.text,
                                subject: 'Reports',
                                recipients: ['quiketmanagement@gmail.com'],
                                isHTML: false,
                              );

                              await FlutterEmailSender.send(email);
                            },
                          ),
                          FlatButton(
                            child: new Text('Cancel'),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          )
                        ],
                      );
                    });
              },
              title: Text(
                'Report',
                style: labelTextStyle,
              ),
              subtitle: Text(
                'Report your issues.',
                style: labelTextSmallStyle,
              ),
            ),
            Divider(
              height: 30,
            ),
          ],
        ),
      ),
    );
  }
}
