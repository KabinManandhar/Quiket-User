import 'package:rxdart/rxdart.dart';
import 'package:testawwpp/models/event_model.dart';
import 'package:testawwpp/resources/EventApiProvider.dart';

class GetEventBloc {
  final _eventProvider = EventApiProvider();
  final _eventIds = PublishSubject<List<int>>();
  final _eventsOutput = BehaviorSubject<Map<int, Future<EventModel>>>();
  final _eventsFetcher = PublishSubject<int>();

  Stream<List<int>> get getEventIds => _eventIds.stream;
  Stream<Map<int, Future<EventModel>>> get events => _eventsOutput.stream;

  //Getter for sink
  Function(int) get getEvent => _eventsFetcher.sink.add;

  GetEventBloc() {
    _eventsFetcher.stream.transform(_eventTransformer()).pipe(_eventsOutput);
  }

  getIds() async {
    List<int> ids = await _eventProvider.getEventsId();
    if (ids != null) {
      _eventIds.sink.add(ids);
    }
  }

  _eventTransformer() {
    return ScanStreamTransformer(
        (Map<int, Future<EventModel>> event, int id, index) {
      event[id] = _eventProvider.getEvent(id);
      return event;
    }, <int, Future<EventModel>>{});
  }

  dispose() {
    _eventIds.close();
    _eventsFetcher.close();
    _eventsOutput.close();
  }
}
