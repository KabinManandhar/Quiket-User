import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:testawwpp/Ui/Order/order_card.dart';
import 'package:testawwpp/widgets/softButton.dart';

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
      floatingActionButton: Container(
        margin: EdgeInsets.only(bottom: 20, left: 25),
        alignment: Alignment.bottomRight,
        child: SoftButton(
          onClick: () {
            Navigator.pushNamed(context, "/createTicket/${widget.userId}");
          },
          height: 70,
          width: 70,
          iconSize: 30,
          icon: MaterialIcons.add,
          mainAxisAlignment: MainAxisAlignment.end,
        ),
      ),
      body: Container(
          height: MediaQuery.of(context).size.height - 250, child: OrderCard()),
    );
  }
}
