import 'dart:convert';

import 'package:add_2_calendar/add_2_calendar.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:maps_launcher/maps_launcher.dart';

import '../../control/style.dart';
import '../../models/event_model.dart';
import '../../resources/EventApiProvider.dart';
import '../../resources/requests.dart';
import '../../resources/secureStorage.dart';
import '../../widgets/loadingContainer.dart';
import '../../widgets/loadingTicketContainer.dart';
import '../../widgets/softButton.dart';
import '../../widgets/softText.dart';

class ShowEvent extends StatefulWidget {
  final eventId;

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
              actions: <Widget>[bookmark(context)],
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
                        return Column(
                          children: <Widget>[
                            LoadingTicketContainer(),
                            LoadingTicketContainer(),
                            LoadingContainer(),
                            LoadingContainer(),
                            LoadingContainer(),
                          ],
                        );
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
                          organizer(eventData.organizerName),
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
                          description(eventData.description),
                          SizedBox(
                            height: 50,
                          )
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
        ? Icon(
            MaterialIcons.event,
            size: 70,
          )
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
    if (description == null || description == "") {
      return Container();
    }
    return AutoSizeText(
      description,
      minFontSize: 15,
      maxLines: 10,
      style: titleText,
    );
  }

  checkBookmark() async {
    String _valueOfId = await secureStorage.read(key: 'id');
    String _token = await secureStorage.read(key: 'token');
    int _id = int.parse(_valueOfId);
    Map<String, dynamic> data = {'user_id': _id, 'event_id': widget.eventId};
    var response =
        await req.authPostRequest(data, '/users/$_id/bookmarkCheck', _token);
    var result = json.decode(response);
    print(result['success']);
    if (result['success']) {
      setState(() {
        pressed = true;
      });
    } else {
      setState(() {
        pressed = false;
      });
    }
  }

  Widget bookmark(context) {
    checkBookmark();
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
      onPressed: () async {
        String _valueOfId = await secureStorage.read(key: 'id');
        String _token = await secureStorage.read(key: 'token');
        int _id = int.parse(_valueOfId);
        Map<String, dynamic> data = {
          'user_id': _id,
          'event_id': widget.eventId
        };
        if (pressed) {
          setState(() {
            pressed = !pressed;
          });
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  backgroundColor: Colors.grey[300],
                  title: Text(
                    "Bookmarked.",
                    style: labelTextSmallStyle,
                  ),
                  actions: <Widget>[
                    FlatButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text(
                        'OK.',
                        style: labelTextSmallStyle,
                      ),
                    )
                  ],
                );
              });
          req.authPostRequest(data, '/users/$_id/bookmark', _token);
        } else {
          setState(() {
            pressed = !pressed;
          });
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  backgroundColor: Colors.grey[300],
                  title: Text(
                    "Removed From Bookmark.",
                    style: labelTextSmallStyle,
                  ),
                  actions: <Widget>[
                    FlatButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text(
                        'OK.',
                        style: labelTextSmallStyle,
                      ),
                    )
                  ],
                );
              });
          req.authPostRequest(data, '/bookmark/delete', _token);
        }
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
            label: 'Add to Calandar',
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

  Widget organizer(String organizerName) {
    if (organizerName == null || organizerName == "") {
      return Container();
    }
    return AutoSizeText(
      organizerName,
      minFontSize: 15,
      maxLines: 10,
      style: titleText,
    );
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
