import 'package:rxdart/rxdart.dart';
import 'package:testawwpp/models/order_model.dart';

import 'package:testawwpp/resources/OrderApiProvider.dart';

class GetOrderBloc {
  final _orderProvider = OrderApiProvider();
  final _orderIds = PublishSubject<List<int>>();
  final _ordersOutput = BehaviorSubject<Map<int, Future<OrderModel>>>();
  final _ordersFetcher = PublishSubject<int>();

  Stream<List<int>> get getOrdersIds => _orderIds.stream;
  Stream<Map<int, Future<OrderModel>>> get orders => _ordersOutput.stream;

  //Getter for sink
  Function(int) get getOrder => _ordersFetcher.sink.add;

  GetOrderBloc() {
    _ordersFetcher.stream.transform(_orderTransformer()).pipe(_ordersOutput);
  }

  getIds(int id) async {
    List<int> ids = await _orderProvider.getOrdersId(id);
    if (ids != null) {
      _orderIds.sink.add(ids);
    }
  }

  _orderTransformer() {
    return ScanStreamTransformer(
        (Map<int, Future<OrderModel>> order, int id, index) {
      order[id] = _orderProvider.getOrder(id);
      return order;
    }, <int, Future<OrderModel>>{});
  }

  dispose() {
    _orderIds.close();
    _ordersFetcher.close();
    _ordersOutput.close();
  }
}
