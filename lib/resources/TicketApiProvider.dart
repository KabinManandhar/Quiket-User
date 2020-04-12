import 'dart:convert';
import 'package:testawwpp/models/event_model.dart';
import 'package:testawwpp/models/ticket_model.dart';
import 'package:testawwpp/resources/secureStorage.dart';

import 'requests.dart';

class TicketApiProvider {
  final _evtUrl = '/events';
  final _tickUrl = '/tickets';
  final _orgUrl = '/organizers';
  String _token;

  Future<List<int>> getTicketsIds(int id) async {
    try {
      final response = await req.getRequest(_evtUrl + "/$id" + _tickUrl);
      final ids = json.decode(response.body);
      return ids.cast<int>();
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<TicketModel> getTicket(int id) async {
    try {
      final response = await req.getRequest(_tickUrl + '/$id');
      final ticket = json.decode(response.body);
      return TicketModel.fromJson(ticket);
    } catch (e) {
      print(e);
      return null;
    }
  }

  deleteTicket() {}

  createTicket(Map<String, dynamic> data) async {
    print(data);
    print('testAT2');
    _token = await secureStorage.read(key: 'token');
    var response =
        await req.authPostRequest(data, _orgUrl + _evtUrl + _tickUrl, _token);
    return response;
  }

  editTicket(Map<String, dynamic> data, int ticketId) async {
    String _valueOfId = await secureStorage.read(key: 'id');
    int _id = int.parse(_valueOfId);
    _token = await secureStorage.read(key: 'token');
    var response = await req.putRequest(
        data, _orgUrl + '/$_id' + _tickUrl + '/$ticketId', _token);
    return response;
  }
}
