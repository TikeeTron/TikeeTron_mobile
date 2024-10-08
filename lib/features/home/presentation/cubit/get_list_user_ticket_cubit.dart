import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../common/utils/extensions/object_parsing.dart';
import '../../../../common/utils/helpers/safe_emit_helper.dart';
import '../../data/model/request/get_list_ticket_request_params.dart';
import '../../data/model/response/get_list_ticket_response.dart';
import '../../domain/repository/ticket_repository.dart';

part 'get_list_user_ticket_state.dart';

@LazySingleton()
class GetListUserTicketCubit extends Cubit<GetListUserTicketState> {
  final TicketRepository _ticketRepository;
  GetListUserTicketCubit(this._ticketRepository) : super(const GetListUserTicketState());

  Future<void> getListUserTicket({required String walletAddress}) async {
    try {
      safeEmit(GetListUserTicketLoadingState());
      final result = await _ticketRepository.getListTicket(
        params: GetListTicketRequestParams(
          buyerAddress: walletAddress,
          page: 1,
          take: 50,
        ),
      );
      if (result != null) {
        if (result.data != null) {
          safeEmit(GetListUserTicketLoadedState(listTicket: result));
        }
      } else {
        safeEmit(
          const GetListUserTicketErrorState(
            message: 'Failed get list event',
          ),
        );
      }
    } catch (e) {
      safeEmit(
        GetListUserTicketErrorState(
          message: e.errorMessage,
        ),
      );
    }
  }
}
