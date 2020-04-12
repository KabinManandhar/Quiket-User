import 'package:rxdart/rxdart.dart';
import 'package:testawwpp/models/ticket_model.dart';
import 'package:testawwpp/resources/TicketApiProvider.dart';

class GetTicketBloc {
  final _ticketProvider = TicketApiProvider();
  final _ticketIds = PublishSubject<List<int>>();
  final _ticketsOutput = BehaviorSubject<Map<int, Future<TicketModel>>>();
  final _ticketsFetcher = PublishSubject<int>();

  Stream<List<int>> get getTicketsIds => _ticketIds.stream;
  Stream<Map<int, Future<TicketModel>>> get tickets => _ticketsOutput.stream;

  //Getter for sink
  Function(int) get getTicket => _ticketsFetcher.sink.add;

  GetTicketBloc() {
    _ticketsFetcher.stream.transform(_ticketTransformer()).pipe(_ticketsOutput);
  }

  getIds(int id) async {
    List<int> ids = await _ticketProvider.getTicketsIds(id);
    if (ids != null) {
      _ticketIds.sink.add(ids);
    }
  }

  _ticketTransformer() {
    return ScanStreamTransformer(
        (Map<int, Future<TicketModel>> ticket, int id, index) {
      ticket[id] = _ticketProvider.getTicket(id);
      return ticket;
    }, <int, Future<TicketModel>>{});
  }

  dispose() {
    _ticketIds.close();
    _ticketsFetcher.close();
    _ticketsOutput.close();
  }
}
