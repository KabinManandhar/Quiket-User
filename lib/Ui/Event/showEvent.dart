import 'package:add_2_calendar/add_2_calendar.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:maps_launcher/maps_launcher.dart';
import 'package:shimmer/shimmer.dart';

import '../../control/style.dart';
import '../../models/event_model.dart';
import '../../models/organizer_model.dart';
import '../../resources/EventApiProvider.dart';
import '../../resources/authProvider.dart';
import '../../widgets/loadingContainer.dart';
import '../../widgets/loadingTicketContainer.dart';
import '../../widgets/softButton.dart';
import '../../widgets/softContainer.dart';
import '../../widgets/softText.dart';

class ShowEvent extends StatefulWidget {
  final eventId;
  final _auth = AuthProvider();

  ShowEvent({Key key, this.eventId}) : super(key: key);
  @override
  _ShowEventState createState() => _ShowEventState();
}

class _ShowEventState extends State<ShowEvent> {
  bool pressed = true;
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      resizeToAvoidBottomPadding: true,
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              actions: <Widget>[bookmark()],
              elevation: 0,
              expandedHeight: 300.0,
              floating: true,
              pinned: true,
              flexibleSpace: FutureBuilder(
                future: EventApiProvider().getEvent(widget.eventId),
                builder: (context, AsyncSnapshot<EventModel> snapshot) {
                  var eventData = snapshot.data;
                  if (!snapshot.hasData) {
                    return LoadingContainer();
                  }
                  return FlexibleSpaceBar(
                    background: eventPicture(eventData.picture),
                  );
                },
              ),
            ),
            SliverFillRemaining(
              child: Container(
                margin: EdgeInsets.all(20.0),
                child: SingleChildScrollView(
                  child: FutureBuilder(
                    future: EventApiProvider().getEvent(widget.eventId),
                    builder: (context, AsyncSnapshot<EventModel> snapshot) {
                      if (!snapshot.hasData) {
                        return LoadingTicketContainer();
                      }
                      var eventData = snapshot.data;
                      return Column(
                        children: <Widget>[
                          Center(
                            child: name(eventData.name),
                          ),
                          Divider(
                            color: Colors.black,
                            height: 20,
                          ),
                          Text(
                            'Organized By',
                            style: labelTextStyle,
                          ),
                          organizer(eventData.organizerId),
                          Divider(
                            color: Colors.black,
                            height: 20,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          startDateTime(eventData.startDatetime, eventData.name,
                              eventData.venue, eventData.endDatetime),
                          SizedBox(
                            height: 10,
                          ),
                          endDateTime(eventData.endDatetime),
                          SizedBox(
                            height: 10,
                          ),
                          Divider(
                            color: Colors.black,
                            height: 20,
                          ),
                          Text(
                            'Location',
                            style: labelTextStyle,
                          ),
                          location(eventData.venue),
                          Divider(
                            color: Colors.black,
                            height: 20,
                          ),
                          Text(
                            'Event Details',
                            style: labelTextStyle,
                          ),
                          description(eventData.description)
                        ],
                      );
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: SoftButton(
        onClick: () {
          Navigator.pushNamed(context, "/showTicket/${widget.eventId}");
        },
        height: 80,
        width: 80,
        iconSize: buttonSize,
        icon: MaterialCommunityIcons.ticket_outline,
      ),
    );
  }

  Widget eventPicture(picture) {
    return Image.network(
              "http://192.168.100.70:8000" + picture,
              fit: BoxFit.cover,
            ) ==
            null
        ? SoftContainer()
        : Image.network(
            "http://192.168.100.70:8000" + picture,
            fit: BoxFit.cover,
          );
  }

  Widget name(name) {
    return AutoSizeText(
      name,
      minFontSize: 15,
      maxLines: 3,
      style: titleText,
    );
  }

  Widget description(description) {
    return AutoSizeText(
      description,
      minFontSize: 15,
      maxLines: 10,
      style: titleText,
    );
  }

  Widget bookmark() {
    return FlatButton(
      child: pressed
          ? Icon(
              MaterialIcons.bookmark_border,
              size: buttonSize,
            )
          : Icon(
              MaterialIcons.bookmark,
              size: buttonSize,
            ),
      onPressed: () {
        setState(() {
          pressed = !pressed;
        });
      },
    );
  }

  Widget startDateTime(String dateTime, String name, String venue, String end) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(
          'Start Date:',
          style: labelTextStyle,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Row(
              children: [
                Icon(
                  SimpleLineIcons.clock,
                  size: buttonSize,
                  color: buttonColor,
                ),
                SizedBox(
                  width: 20,
                ),
                Text(_buildTime(dateTime))
              ],
            ),
            Row(
              children: [
                Icon(
                  SimpleLineIcons.calendar,
                  size: buttonSize,
                  color: buttonColor,
                ),
                SizedBox(
                  width: 20,
                ),
                Text(_buildDate(dateTime)),
              ],
            )
          ],
        ),
        SizedBox(
          height: 20,
        ),
        Align(
          alignment: Alignment.bottomLeft,
          child: SoftText(
            label: 'Add to Calander',
            fontSize: 20,
            onClick: () {
              final Event event = Event(
                title: 'Event title',
                description: 'Event description',
                location: 'Event location',
                startDate: DateTime.parse(dateTime),
                endDate: DateTime.parse(end),
              );

              Add2Calendar.addEvent2Cal(event);
            },
          ),
        )
      ],
    );
  }

  Widget endDateTime(String dateTime) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(
          'End Date:',
          style: labelTextStyle,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Row(
              children: [
                Icon(
                  SimpleLineIcons.clock,
                  size: buttonSize,
                  color: buttonColor,
                ),
                SizedBox(
                  width: 20,
                ),
                Text(_buildTime(dateTime))
              ],
            ),
            Row(
              children: [
                Icon(
                  SimpleLineIcons.calendar,
                  size: buttonSize,
                  color: buttonColor,
                ),
                SizedBox(
                  width: 20,
                ),
                Text(_buildDate(dateTime)),
              ],
            )
          ],
        ),
        SizedBox(
          height: 20,
        ),
      ],
    );
  }

  Widget location(String location) {
    return ListTile(
      onTap: () => MapsLauncher.launchQuery(location),
      title: Text(
        location,
        style: body1Text,
      ),
      trailing: Icon(
        SimpleLineIcons.location_pin,
        color: buttonColor,
        size: buttonSize,
      ),
    );
  }

  Widget organizer(int organizerId) {
    return FutureBuilder(
        future: widget._auth.getOrganizerProfile(organizerId),
        builder: (context, AsyncSnapshot<OrganizerModel> snapshot) {
          if (snapshot.hasData) {
            OrganizerModel organizer = snapshot.data;
            return Text(
              organizer.name,
              style: titleText,
            );
          } else {
            return Shimmer.fromColors(
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: 30,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              baseColor: Colors.grey[300],
              highlightColor: Colors.white,
            );
          }
        });
  }

  String _buildTime(String dateTime) {
    if (dateTime == null) {
      return 'Finding...';
    } else {
      List<String> splitTime = dateTime.split(' ');
      String time = splitTime[1];
      List<String> timeSplit = time.split(':');
      return timeSplit[0] + ':' + timeSplit[1];
    }
  }
}

String _buildDate(String dateTime) {
  if (dateTime == null) {
    return 'Finding...';
  } else {
    List<String> splitDateTime = dateTime.split(' ');
    String date = splitDateTime[0];
    List<String> splitDate = date.split('-');
    int month = int.parse(splitDate[1]);
    String monthName;
    switch (month) {
      case 1:
        monthName = 'Jan';
        break;
      case 2:
        monthName = 'Feb';
        break;
      case 3:
        monthName = 'Mar';
        break;
      case 4:
        monthName = 'Apr';
        break;
      case 5:
        monthName = 'May';
        break;
      case 6:
        monthName = 'Jun';
        break;
      case 7:
        monthName = 'Jul';
        break;
      case 8:
        monthName = 'Aug';
        break;
      case 9:
        monthName = 'Sep';
        break;
      case 10:
        monthName = 'Oct';
        break;
      case 11:
        monthName = 'Nov';
        break;
      case 12:
        monthName = 'Dec';
        break;
    }
    return (monthName + ' ' + splitDate[2] + ', ' + splitDate[0]);
  }
}
