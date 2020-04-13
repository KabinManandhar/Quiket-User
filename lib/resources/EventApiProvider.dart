import 'dart:convert';
import 'package:testawwpp/models/event_model.dart';
import 'package:testawwpp/resources/secureStorage.dart';

import 'requests.dart';

class EventApiProvider {
  final _evtUrl = '/events';
  final _userUrl = '/users';
  final _bookmarkUrl = '/bookmark';

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

  Future<List<int>> getBookmarkId(int id) async {
    try {
      final response = await req.getRequest(_userUrl + '/$id' + _bookmarkUrl);
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
}
