import '../../data/model/request/get_list_ticket_request_params.dart';
import '../../data/model/request/snyc_ticket_request.dart';
import '../../data/model/response/get_detail_ticket_response.dart';
import '../../data/model/response/get_list_ticket_response.dart';
import '../../data/model/response/sync_ticket_response.dart';

abstract class TicketRepository {
  Future<GetListTicketResponse?> getListTicket({GetListTicketRequestParams? params});
  Future<GetDetailTicketResponse?> getDetailTicket({required int ticketId});
  Future<SnycTicketResponse?> syncTicketData({required SyncTicketRequest syncData});
}
