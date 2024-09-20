import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';

@singleton
class DashboardCubit extends Cubit<bool> {
  DashboardCubit() : super(false);

  void showDrawer() => emit(true);

  void hideDrawer() => emit(false);
}
