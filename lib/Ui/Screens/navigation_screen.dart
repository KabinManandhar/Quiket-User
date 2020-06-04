import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';

import '../../blocs/getBlocs/Event/getEventBlocProvider.dart';
import '../../blocs/getBlocs/Order/getOrderBlocProvider.dart';
import '../../control/style.dart';
import '../../resources/secureStorage.dart';
import '../credentials/login_screen.dart';
import 'bookmark.dart';
import 'explore.dart';
import 'menu.dart';
import 'search.dart';
import 'tickets.dart';

class NavigationScreen extends StatefulWidget {
  int _id;
  String _token;
  @override
  _NavigationScreenState createState() => _NavigationScreenState();
}

class _NavigationScreenState extends State<NavigationScreen> {
  @override
  void initState() {
    getIdToken();
    super.initState();
  }

  int _screen = 2;
  Widget build(BuildContext context) {
    final bloc = GetEventBlocProvider.of(context);
    final orderBloc = GetOrderBlocProvider.of(context);
    return Scaffold(
      body: changeScreen(bloc, orderBloc, _screen),
      bottomNavigationBar: CurvedNavigationBar(
        index: 2,
        height: 70,
        onTap: (index) {
          setState(() {
            _screen = index;
          });
        },
        color: Colors.grey[300],
        animationDuration: Duration(milliseconds: 400),
        backgroundColor: Colors.grey[300],
        buttonBackgroundColor: Theme.of(context).accentColor,
        items: <Widget>[
          Icon(Feather.search, color: buttonColor, size: buttonSize),
          Icon(MaterialCommunityIcons.ticket_outline,
              color: buttonColor, size: buttonSize),
          Icon(MaterialCommunityIcons.home_outline,
              color: buttonColor, size: 30),
          Icon(MaterialCommunityIcons.bookmark_outline,
              color: buttonColor, size: buttonSize),
          Icon(SimpleLineIcons.menu, color: buttonColor, size: buttonSize),
        ],
      ),
      //Text("${}"),
    );
  }

  Widget changeScreen(GetEventBloc bloc, GetOrderBloc orderBloc, int screen) {
    if (screen == 0) {
      return SearchScreen();
    } else if (screen == 1) {
      if (widget._token == null && widget._id == null) {
        return LoginScreen();
      } else {
        orderBloc.getOdrIds(widget._id, widget._token);
        return TicketScreen();
      }
    } else if (screen == 2) {
      bloc.getIds();
      return HomeScreen();
    } else if (screen == 3) {
      if (widget._token == null && widget._id == null) {
        return LoginScreen();
      } else {
        bloc.getBookmarkIds(widget._id);
        return BookmarkScreen();
      }
    } else if (screen == 4) {
      if (widget._token == null && widget._id == null) {
        return LoginScreen();
      } else {
        return MenuScreen(userId: widget._id);
      }
    } else {
      return Center(child: Text("How???"));
    }
  }

  getIdToken() async {
    String _valueOfId = await secureStorage.read(key: 'id');
    String _token = await secureStorage.read(key: 'token');
    int _id;
    if (_valueOfId != "" && _valueOfId != null) {
      _id = int.parse(_valueOfId);
    }
    setState(() {
      widget._id = _id;
      widget._token = _token;
    });
  }
}
