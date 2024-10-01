import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

part 'fullscreen_loading_state.dart';

@LazySingleton()
class FullScreenLoadingCubit extends Cubit<FullscreenLoadingState> {
  FullScreenLoadingCubit() : super(FullscreenLoadingInitial());

  showFullScreenLoading({String? title, String? subtitle}) {
    emit(ShowFullScreenLoading(
      title: title ?? '',
      subtitle: subtitle ?? '',
    ));
  }

  hideFullScreenLoading() {
    emit(HideFullScreenLoading());
  }
}
