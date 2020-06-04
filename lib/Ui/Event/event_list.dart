import 'dart:async';

import 'package:flutter/material.dart';

import '../../blocs/getBlocs/Event/getEventBlocProvider.dart';
import '../../models/event_model.dart';
import '../../widgets/loadingContainer.dart';
import '../../widgets/softContainer.dart';

class EventList extends StatelessWidget {
  final int eventId;

  EventList({this.eventId});

  Widget build(context) {
    final bloc = GetEventBlocProvider.of(context);

    return StreamBuilder(
      stream: bloc.events,
      builder: (context, AsyncSnapshot<Map<int, Future<EventModel>>> snapshot) {
        if (!snapshot.hasData) {
          return Container();
        }

        return FutureBuilder(
          future: snapshot.data[eventId],
          builder: (context, AsyncSnapshot<EventModel> eventSnapshot) {
            if (!eventSnapshot.hasData) {
              return Container();
            } else if (DateTime.parse(eventSnapshot.data.endDatetime)
                .isAfter(DateTime.now())) {
              return buildTile(context, eventSnapshot.data);
            } else {
              return Container();
            }
          },
        );
      },
    );
  }

  Widget buildTile(BuildContext context, EventModel event) {
    if (event.status == null &&
        event.name == null &&
        event.startDatetime == null) {
      return Column(
        children: <Widget>[
          LoadingContainer(),
        ],
      );
    }

    if (event.status == 1) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            height: 20,
          ),
          SoftContainer(
            width: MediaQuery.of(context).size.width - 70,
            onClick: () {
              Navigator.pushNamed(context, '/showEvent/${event.id}');
            },
            label: event.name,
            dateTime: event.startDatetime,
            image: event.picture,
            status: event.status == 0 ? false : true,
          ),
          Container(
            height: 20,
          ),
        ],
      );
    } else {
      return Container();
    }
  }
}
