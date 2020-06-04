import 'package:flutter/material.dart';

import '../Order/order_card.dart';

class TicketScreen extends StatefulWidget {
  final userId;

  const TicketScreen({Key key, this.userId}) : super(key: key);

  @override
  _TicketScreenState createState() => _TicketScreenState();
}

class _TicketScreenState extends State<TicketScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        child: AppBar(
          title: Text(
            'My Tickets',
          ),
          elevation: 0,
        ),
        preferredSize: Size.fromHeight(100),
      ),
      body: Container(
          height: MediaQuery.of(context).size.height - 250, child: OrderCard()),
    );
  }
}
