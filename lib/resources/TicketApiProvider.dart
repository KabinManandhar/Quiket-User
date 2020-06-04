import 'dart:convert';

import '../models/ticket_model.dart';
import 'requests.dart';
import 'secureStorage.dart';

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
      return null;
    }
  }

  Future<TicketModel> getTicket(int id) async {
    try {
      final response = await req.getRequest(_tickUrl + '/$id');
      final ticket = json.decode(response.body);
      return TicketModel.fromJson(ticket);
    } catch (e) {
      return null;
    }
  }

  deleteTicket() {}

  createTicket(Map<String, dynamic> data) async {
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
