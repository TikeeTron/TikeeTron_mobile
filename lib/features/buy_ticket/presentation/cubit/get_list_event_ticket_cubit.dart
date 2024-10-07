import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../common/utils/extensions/object_parsing.dart';
import '../../../../common/utils/helpers/safe_emit_helper.dart';
import '../../../home/data/model/response/get_detail_event_response.dart';
import '../../../home/domain/repository/event_repository.dart';

part 'get_list_event_ticket_state.dart';

@LazySingleton()
class GetListEventTicketCubit extends Cubit<GetListEventTicketState> {
  final EventRepository _eventRepository;
  GetListEventTicketCubit(this._eventRepository) : super(const GetListEventTicketState());

  Future<void> getEventDetail({required int eventId}) async {
    try {
      safeEmit(GetListEventTicketLoadingState());
      final result = await _eventRepository.getDetailEvent(eventId: eventId);
      if (result != null) {
        if (result.data != null) {
          safeEmit(GetListEventTicketLoadedState(listEvent: result));
        }
      } else {
        safeEmit(
          const GetListEventTicketErrorState(
            message: 'Failed get detail event',
          ),
        );
      }
    } catch (e) {
      safeEmit(
        GetListEventTicketErrorState(
          message: e.errorMessage,
        ),
      );
    }
  }
}
