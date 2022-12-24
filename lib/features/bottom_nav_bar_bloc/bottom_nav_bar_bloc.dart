import 'package:flutter_bloc/flutter_bloc.dart';

class BottomNavBarBloc extends Bloc<BottomNavBarEvent, int> {
  BottomNavBarBloc() : super(0) {
    on<SetBottomNavBarIndex>(onBottomNavBarIconPressed);
  }

  void onBottomNavBarIconPressed(
    SetBottomNavBarIndex event,
    Emitter<int> emit,
  ) {
    emit(event.index);
  }
}

/* ---  Events   --- */

abstract class BottomNavBarEvent {
  const BottomNavBarEvent();
}

class SetBottomNavBarIndex extends BottomNavBarEvent {
  int index;
  SetBottomNavBarIndex({required this.index});
}
