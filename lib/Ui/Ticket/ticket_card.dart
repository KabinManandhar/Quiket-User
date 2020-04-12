import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:testawwpp/blocs/getBlocs/Ticket/getTicketBlocProvider.dart';
import 'package:testawwpp/resources/secureStorage.dart';
import 'package:testawwpp/widgets/refresh.dart';

import 'ticket_list.dart';

class TicketCard extends StatefulWidget {
  int _id;
  String _token;
  @override
  _TicketCardState createState() => _TicketCardState();
}

class _TicketCardState extends State<TicketCard>
    with AutomaticKeepAliveClientMixin<TicketCard> {
  @override
  void initState() {
    getCreds();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final bloc = GetTicketBlocProvider.of(context);
    return StreamBuilder(
      stream: bloc.getTicketsIds,
      builder: (context, AsyncSnapshot snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: SpinKitChasingDots(
              color: Colors.grey[700],
              size: 50.0,
            ),
          );
        }
        return Refresh(
          child: ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (context, int index) {
                bloc.getTicket(snapshot.data[index]);
                return TicketList(
                    ticketId: snapshot.data[index],
                    userId: widget._id,
                    token: widget._token);
              }),
        );
      },
    );
  }

  getCreds() async {
    String _valueOfId = await secureStorage.read(key: 'id');
    String _token = await secureStorage.read(key: 'token');
    int _id = _valueOfId == null ? null : int.parse(_valueOfId);
    setState(() {
      widget._id = _id;
      widget._token = _token;
    });
  }

  @override
  bool get wantKeepAlive => true;
}
