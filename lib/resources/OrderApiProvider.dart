import 'dart:convert';

import '../models/order_model.dart';
import 'requests.dart';
import 'secureStorage.dart';

class OrderApiProvider {
  final _rootUrl = '/events';
  final _ordUrl = '/orders';
  String _token;

  Future<List<int>> getOrdersId(int id) async {
    try {
      _token = await secureStorage.read(key: 'token');
      final response =
          await req.authGetRequest(_rootUrl + "/$id" + _ordUrl, _token);
      final ids = json.decode(response.body);

      return ids.cast<int>();
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<OrderModel> getOrder(int id) async {
    try {
      _token = await secureStorage.read(key: 'token');
      final response = await req.authGetRequest(_ordUrl + '/$id', _token);
      final order = json.decode(response.body);
      return OrderModel.fromJson(order[0]);
    } catch (e) {
      print(e);
      return null;
    }
  }

  deleteOrder() {}

  createOrder(
      String name,
      String description,
      String category,
      String venue,
      String type,
      String picture,
      String startDateTime,
      String endDateTime) async {
    Map<String, String> data = {
      'name': 'name',
      'description': 'description',
      'category': 'category',
      'venue': 'venue',
      'type': 'type',
      'status': '0',
      'picture': 'picture',
      'start_datetime': startDateTime,
      'end_datetime': endDateTime,
      'organizer_id': '6',
    };

    // print("Ordermodel data");
    // print(data);
    // var response = await req.authPostRequest(data, _ordUrl + _rootUrl, token);
    // return response;
  }
}
