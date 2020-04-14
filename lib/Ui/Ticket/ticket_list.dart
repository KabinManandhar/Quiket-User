import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_fluid_slider/flutter_fluid_slider.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:random_string/random_string.dart';
import 'package:testawwpp/control/routes.dart';

import '../../blocs/getBlocs/Ticket/getTicketBlocProvider.dart';
import '../../control/style.dart';
import '../../models/ticket_model.dart';
import '../../resources/requests.dart';
import '../../widgets/loadingTicketContainer.dart';
import '../../widgets/softText.dart';

class TicketList extends StatefulWidget {
  final int ticketId;
  final int userId;
  final String token;
  var _value = 1.0;
  int totalPrice = 0;
  bool value = false;
  bool result = false;
  bool buyCheck = false;

  TicketList({this.ticketId, this.userId, this.token});

  @override
  _TicketListState createState() => _TicketListState();
}

class _TicketListState extends State<TicketList> {
  Widget build(context) {
    final bloc = GetTicketBlocProvider.of(context);

    return StreamBuilder(
      stream: bloc.tickets,
      builder:
          (context, AsyncSnapshot<Map<int, Future<TicketModel>>> snapshot) {
        if (!snapshot.hasData) {
          return LoadingTicketContainer();
        }

        return FutureBuilder(
          future: snapshot.data[widget.ticketId],
          builder: (context, AsyncSnapshot<TicketModel> ticketSnapshot) {
            if (!ticketSnapshot.hasData) {
              return LoadingTicketContainer();
            }
            return buildTile(context, ticketSnapshot.data);
          },
        );
      },
    );
  }

  Widget buildTile(BuildContext context, TicketModel ticket) {
    if (ticket.status == null &&
        ticket.name == null &&
        (ticket.boughtTicket == null || ticket.boughtTicket == 0)) {
      return Column(
        children: <Widget>[
          LoadingTicketContainer(),
        ],
      );
    }

    return Column(
      children: <Widget>[
        ExpansionTile(
          onExpansionChanged: (value) {
            setState(() {
              widget.value = value;
            });
          },
          leading: widget.value
              ? Icon(SimpleLineIcons.arrow_up)
              : Icon(SimpleLineIcons.arrow_down),
          children: <Widget>[
            (ticket.totalTicket - ticket.boughtTicket == 0)
                ? Text("Tickets Are Sold out.")
                : Column(
                    children: [
                      SizedBox(height: 80),
                      Row(
                        children: <Widget>[
                          Align(
                              alignment: Alignment.topLeft,
                              child: Text('Quantity:', style: labelTextStyle)),
                          SizedBox(height: 40),
                          Container(
                            width: MediaQuery.of(context).size.width - 100,
                            child: FluidSlider(
                              value: widget._value,
                              onChanged: (double newValue) {
                                if (ticket.totalTicket - ticket.boughtTicket >
                                    newValue) {
                                  setState(() {
                                    widget._value = newValue;
                                    widget.totalPrice =
                                        newValue.toInt() * ticket.price;
                                  });
                                }
                              },
                              labelsTextStyle: body1Text,
                              thumbColor: Colors.grey[300],
                              sliderColor: Colors.grey[400],
                              min: ticket.minTicket.toDouble(),
                              max: ticket.maxTicket.toDouble(),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            'Total Price:',
                            style: labelTextStyle,
                          ),
                          Container(
                            margin: EdgeInsets.all(20),
                            child: Text(
                              '${widget.totalPrice}',
                              style: labelTextStyle,
                            ),
                          ),
                        ],
                      ),
                      (widget.token == null && widget.userId == null)
                          ? SoftText(
                              label: "Login",
                              onClick: () => Navigator.pushReplacementNamed(
                                  context, loginRoute),
                            )
                          : SoftText(
                              label: 'Buy',
                              onClick: () async {
                                for (int i = 1;
                                    i <= widget._value.toInt();
                                    i++) {
                                  Map<String, dynamic> data = {
                                    'ticket_id': ticket.id,
                                    'user_id': widget.userId,
                                    'qr_code': randomAlphaNumeric(10),
                                    'status': 0
                                  };
                                  var response = await req.authPostRequest(
                                      data,
                                      '/user/${widget.token}/order',
                                      widget.token);
                                  var result = json.decode(response);
                                  setState(() {
                                    widget.result = result['success'];
                                  });
                                }

                                if (widget.result) {
                                } else {
                                  showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          backgroundColor: Colors.grey[300],
                                          title: Text(
                                            "Ticket Purchase Unsuccessful!",
                                            style: labelTextSmallStyle,
                                          ),
                                          actions: <Widget>[
                                            FlatButton(
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              },
                                              child: Text(
                                                'Sorry!',
                                                style: labelTextSmallStyle,
                                              ),
                                            )
                                          ],
                                        );
                                      });
                                }
                              },
                            ),
                      SizedBox(
                        height: 20,
                      )
                    ],
                  )
          ],
          title: Text(
            ticket.name,
            style: titleText,
          ),
          subtitle: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                "Total Tickets Remaining:" +
                    (ticket.totalTicket - ticket.boughtTicket).toString(),
                style: labelTextSmallStyle,
              )
            ],
          ),
          trailing: Text(
            ticket.price == 0 ? 'Free' : 'Rs.${ticket.price}',
            style: titleText,
          ),
        ),
      ],
    );
  }
}
