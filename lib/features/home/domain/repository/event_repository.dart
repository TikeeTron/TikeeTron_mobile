import '../../data/model/response/get_detail_event_response.dart';
import '../../data/model/response/get_list_event_response.dart';

abstract class EventRepository {
  Future<GetListEventResponse?> getListEvent();

  Future<GetDetailEventResponse?> getDetailEvent({required int eventId});
}
