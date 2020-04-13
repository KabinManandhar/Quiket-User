import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';

import '../../blocs/postBlocs/credentials/credentialBloc.dart';
import '../../control/routes.dart';
import '../../control/style.dart';

class MenuScreen extends StatelessWidget {
  final int eventId;

  MenuScreen({this.eventId});

  Widget build(BuildContext context) {
    final bloc = blocCredential;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(100),
        child: AppBar(
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
                                Navigator.of(context).pop();
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
                Navigator.pushNamed(context, profileRoute);
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
                Navigator.pushNamed(context, '/editEvent/$eventId');
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
                Navigator.pushNamed(context, '/editEvent/$eventId');
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
