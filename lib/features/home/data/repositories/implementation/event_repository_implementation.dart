import 'package:injectable/injectable.dart';

import '../../../../../common/utils/helpers/logger_helper.dart';
import '../../../../wallet/data/repositories/source/local/account_local_repository.dart';
import '../../../domain/repository/event_repository.dart';
import '../../model/response/get_detail_event_response.dart';
import '../../model/response/get_list_event_response.dart';
import '../source/remote/event_remote.dart';

@LazySingleton(as: EventRepository)
class EventRepositoryImplementation implements EventRepository {
  final EventRemote _eventRemote;
  final AccountLocalRepository _accountLocalRepository;
  EventRepositoryImplementation(
    this._eventRemote,
    this._accountLocalRepository,
  );

  @override
  Future<GetListEventResponse?> getListEvent() async {
    try {
      final accessToken = _accountLocalRepository.getToken() ?? '';
      Logger.info('Access Token ${accessToken}');
      if (accessToken.isNotEmpty) {
        final result = await _eventRemote.getListEvent(accessToken: accessToken);
        Logger.info('result get list event ${result!.toJson()}');

        return result;
      } else {
        return null;
      }
    } catch (e) {
      Logger.info('result get list event error ${e.toString()}');
      rethrow;
    }
  }

  @override
  Future<GetDetailEventResponse?> getDetailEvent({required int eventId}) async {
    try {
      final accessToken = _accountLocalRepository.getToken() ?? '';
      if (accessToken.isNotEmpty) {
        final result = await _eventRemote.getDetailEvent(accessToken: accessToken, eventId: eventId);
        return result;
      } else {
        return null;
      }
    } catch (e) {
      rethrow;
    }
  }
}
