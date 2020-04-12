import 'dart:convert';
import 'package:testawwpp/models/event_model.dart';
import 'package:testawwpp/resources/secureStorage.dart';

import 'requests.dart';

class EventApiProvider {
  final _evtUrl = '/events';
  final _orgUrl = '/organizers';
  String _valueOfId;
  String _token;
  int _id;

  Future<List<int>> getEventsId() async {
    try {
      final response = await req.getRequest(_evtUrl);
      final ids = json.decode(response.body);
      return ids.cast<int>();
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<EventModel> getEvent(int id) async {
    try {
      final response = await req.getRequest(_evtUrl + '/$id');
      final event = json.decode(response.body);
      return EventModel.fromJson(event);
    } catch (e) {
      print(e);
      return null;
    }
  }

  deleteEvent() {}

  createEvent(
      String name,
      String description,
      String category,
      String venue,
      String type,
      String picture,
      String startDateTime,
      String endDateTime) async {
    _valueOfId = await secureStorage.read(key: 'id');
    _token = await secureStorage.read(key: 'token');
    _id = int.parse(_valueOfId);
    Map<String, dynamic> data = EventModel(
            picture: picture,
            category: category,
            name: name,
            status: 0,
            description: description,
            venue: venue,
            type: type,
            organizerId: _id,
            startDatetime: startDateTime,
            endDatetime: endDateTime)
        .toMap();
    var response = await req.authPostRequest(data, _orgUrl + _evtUrl, _token);
    return response;
  }

  editEvent(
      int id,
      String name,
      String description,
      String category,
      String venue,
      String type,
      String picture,
      String startDateTime,
      String endDateTime,
      int eventId) async {
    Map<String, dynamic> data;
    _valueOfId = await secureStorage.read(key: 'id');
    _token = await secureStorage.read(key: 'token');
    _id = int.parse(_valueOfId);
    if (picture == null || picture == '') {
      data = EventModel(
              category: category,
              name: name,
              status: 0,
              description: description,
              venue: venue,
              type: type,
              organizerId: _id,
              startDatetime: startDateTime,
              endDatetime: endDateTime)
          .toMap();
    } else {
      data = EventModel(
              picture: picture,
              category: category,
              name: name,
              status: 0,
              description: description,
              venue: venue,
              type: type,
              organizerId: _id,
              startDatetime: startDateTime,
              endDatetime: endDateTime)
          .toMap();
    }

    print("Eventmodel data");
    print(data);
    var response = await req.putRequest(
        data, _orgUrl + '/$_id' + _evtUrl + '/$eventId', _token);
    print(response.body);
    return response;
  }
}

// Map<String, String> data = {
//   'name': 'name',
//   'description': 'description',
//   'category': 'category',
//   'venue': 'venue',
//   'type': 'type',
//   'status': '0',
//   'picture': 'picture',
//   'start_datetime': startDateTime,
//   'end_datetime': endDateTime,
//   'organizer_id': '6',
// };
