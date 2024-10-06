part of 'get_list_event_cubit.dart';

class GetListEventState extends Equatable {
  const GetListEventState();

  @override
  List<Object?> get props => [];
}

class GetListEventInitialState extends GetListEventState {}

class GetListEventLoadingState extends GetListEventState {}

class GetListEventLoadedState extends GetListEventState {
  final GetListEventResponse? listEvent;

  const GetListEventLoadedState({
    this.listEvent,
  });

  GetListEventLoadedState copyWith({
    GetListEventResponse? listEvent,
  }) {
    return GetListEventLoadedState(
      listEvent: listEvent ?? this.listEvent,
    );
  }

  @override
  List<Object?> get props => [
        listEvent,
      ];
}

class GetListEventErrorState extends GetListEventState {
  final String? message;

  const GetListEventErrorState({
    this.message,
  });

  @override
  List<Object?> get props => [message];
}
