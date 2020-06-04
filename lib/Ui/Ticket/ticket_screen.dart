import 'package:flutter/material.dart';

import '../../blocs/getBlocs/Ticket/getTicketBlocProvider.dart';
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
}
