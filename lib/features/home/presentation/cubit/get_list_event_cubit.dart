import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../common/utils/extensions/object_parsing.dart';
import '../../../../common/utils/helpers/safe_emit_helper.dart';
import '../../data/model/response/get_list_event_response.dart';
import '../../domain/repository/event_repository.dart';

part 'get_list_event_state.dart';

@LazySingleton()
class GetListEventCubit extends Cubit<GetListEventState> {
  final EventRepository _eventRepository;
  GetListEventCubit(this._eventRepository) : super(const GetListEventState());

  int tabLenght = 0;
  List<String> listCategory = [];
  Future<void> getListEvent() async {
    try {
      safeEmit(GetListEventLoadingState());
      final result = await _eventRepository.getListEvent();
      if (result != null) {
        if (result.data != null) {
          for (var i in result.data!) {
            if (i.category != null && !listCategory.contains(i.category)) {
              listCategory.add(i.category!);
              tabLenght++;
            }
          }

          safeEmit(GetListEventLoadedState(listEvent: result));
        }
      } else {
        safeEmit(
          const GetListEventErrorState(
            message: 'Failed get list event',
          ),
        );
      }
    } catch (e) {
      safeEmit(
        GetListEventErrorState(
          message: e.errorMessage,
        ),
      );
    }
  }
}
