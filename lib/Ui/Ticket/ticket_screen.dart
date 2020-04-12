import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';

import '../../blocs/getBlocs/Ticket/getTicketBlocProvider.dart';
import '../../widgets/softButton.dart';
import 'ticket_card.dart';

class TicketBuyScreen extends StatefulWidget {
  final int eventId;

  TicketBuyScreen({this.eventId});

  @override
  _TicketBuyScreenState createState() => _TicketBuyScreenState();
}

class _TicketBuyScreenState extends State<TicketBuyScreen> {
  Widget build(BuildContext context) {
    final bloc = GetTicketBlocProvider.of(context);
    bloc.getIds(widget.eventId);
    return Scaffold(
      appBar: PreferredSize(
        child: AppBar(
          automaticallyImplyLeading: false,
          title: Text(
            'Buy',
          ),
          elevation: 0,
        ),
        preferredSize: Size.fromHeight(100),
      ),
      body: Container(child: TicketCard()),
    );
  }

  getIdToken() {}
}

// floatingActionButton: Container(
//           margin: EdgeInsets.only(bottom: 20, left: 25),
//           padding: EdgeInsets.only(bottom: 30),
//           alignment: Alignment.bottomCenter,
//           child: GestureDetector(
//             onTapCancel: () {
//               Navigator.pushNamed(context, createEventRoute);
//             },
//             child: SoftButton(
//               height: 70,
//               width: 70,
//               iconSize: 30,
//               icon: MaterialIcons.add,
//               mainAxisAlignment: MainAxisAlignment.end,
//             ),
//           )),
//       bottomNavigationBar: CurvedNavigationBar(
//         index: 0,
//         height: 70,
//         color: Colors.grey[300],
//         animationDuration: Duration(milliseconds: 400),
//         backgroundColor: Colors.grey[300],
//         buttonBackgroundColor: Theme.of(context).accentColor,
//         items: <Widget>[
//           Icon(Feather.file_text, color: buttonColor, size: buttonSize),
//           Icon(MaterialCommunityIcons.face_profile,
//               color: buttonColor, size: buttonSize),
//           Icon(MaterialIcons.add, color: buttonColor, size: buttonSize),
//           Icon(Feather.search, color: buttonColor, size: buttonSize),
//           Icon(SimpleLineIcons.menu, color: buttonColor, size: buttonSize),
//         ],
//       ),
