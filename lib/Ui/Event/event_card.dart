import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:testawwpp/blocs/getBlocs/Event/getEventBlocProvider.dart';
import 'package:testawwpp/widgets/refresh.dart';

import 'event_list.dart';

class EventCard extends StatefulWidget {
  @override
  _EventCardState createState() => _EventCardState();
}

class _EventCardState extends State<EventCard>
    with AutomaticKeepAliveClientMixin<EventCard> {
  @override
  Widget build(BuildContext context) {
    final bloc = GetEventBlocProvider.of(context);
    return StreamBuilder(
      stream: bloc.getEventIds,
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
                bloc.getEvent(snapshot.data[index]);
                return EventList(eventId: snapshot.data[index]);
              }),
        );
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}
