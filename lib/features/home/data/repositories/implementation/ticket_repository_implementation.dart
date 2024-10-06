import 'package:injectable/injectable.dart';

import '../../../../wallet/data/repositories/source/local/account_local_repository.dart';
import '../../../domain/repository/ticket_repository.dart';
import '../../model/request/get_list_ticket_request_params.dart';
import '../../model/request/snyc_ticket_request.dart';
import '../../model/response/get_detail_ticket_response.dart';
import '../../model/response/get_list_ticket_response.dart';
import '../../model/response/sync_ticket_response.dart';
import '../source/remote/ticket_remote.dart';

@LazySingleton(as: TicketRepository)
class TicketRepositoryImplementation implements TicketRepository {
  final TicketRemote _ticketRemote;
  final AccountLocalRepository _accountLocalRepository;
  TicketRepositoryImplementation(
    this._ticketRemote,
    this._accountLocalRepository,
  );

  @override
  Future<GetDetailTicketResponse?> getDetailTicket({required int ticketId}) async {
    try {
      final accessToken = _accountLocalRepository.getToken() ?? '';
      if (accessToken.isNotEmpty) {
        final result = await _ticketRemote.getDetailTicket(accessToken: accessToken, ticketId: ticketId);
        return result;
      } else {
        return null;
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<GetListTIcketResponse?> getListTicket({GetListTicketRequestParams? params}) async {
    try {
      final accessToken = _accountLocalRepository.getToken() ?? '';
      if (accessToken.isNotEmpty) {
        final result = await _ticketRemote.getListTickets(
          accessToken: accessToken,
          params: params,
        );
        return result;
      } else {
        return null;
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<SnycTicketResponse?> syncTicketData({required SyncTicketRequest syncData}) async {
    try {
      final accessToken = _accountLocalRepository.getToken() ?? '';
      if (accessToken.isNotEmpty) {
        final result = await _ticketRemote.syncTicketData(
          accessToken: accessToken,
          data: syncData,
        );
        return result;
      } else {
        return null;
      }
    } catch (e) {
      rethrow;
    }
  }
}
