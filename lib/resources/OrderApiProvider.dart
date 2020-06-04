import 'dart:convert';

import '../models/order_model.dart';
import 'requests.dart';
import 'secureStorage.dart';

class OrderApiProvider {
  final _rootUrl = '/users';
  final _ordUrl = '/orders';
  String _token;

  Future<List<int>> getOrdersId(int id, String token) async {
    try {
      final response =
          await req.authGetRequest(_rootUrl + "/$id" + _ordUrl, token);
      final ids = json.decode(response.body);

      return ids.cast<int>();
    } catch (e) {
      return null;
    }
  }

  Future<OrderModel> getOrder(int id) async {
    try {
      _token = await secureStorage.read(key: 'token');

      final response =
          await req.authGetRequest(_rootUrl + _ordUrl + '/$id', _token);
      final order = json.decode(response.body);
      return OrderModel.fromJson(order[0]);
    } catch (e) {
      return null;
    }
  }
}
