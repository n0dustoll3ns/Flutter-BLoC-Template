import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_template/features/reciever/model.dart';

class RecieversBloc extends Bloc<RecieverEvent, RecieversState> {
  RecieversBloc() : super(RecieversInitial()) {
    on<AddReciever>(onRecieverAdded);
    on<RemoveReciever>(onRecieverRemoved);
    on<ClearRecievers>(onClearRecievers);
  }

  void onRecieverAdded(
    AddReciever event,
    Emitter<RecieversState> emit,
  ) {
    state.items.add(event.item);
    emit(RecieversUpdated(items: state.items));
  }

  void onRecieverRemoved(
    RemoveReciever event,
    Emitter<RecieversState> emit,
  ) {
    state.items.removeWhere(((element) => element == event.item));
    emit(RecieversUpdated(items: state.items));
  }

  void onClearRecievers(
    ClearRecievers event,
    Emitter<RecieversState> emit,
  ) {
    emit(RecieversInitial());
  }
}

/* ---  States   --- */
abstract class RecieversState {
  final List<Reciever> items;

  RecieversState({required this.items});
}

class RecieversInitial extends RecieversState {
  RecieversInitial() : super(items: []);
}

class RecieversUpdated extends RecieversState {
  RecieversUpdated({required super.items});
}

/* ---  Events   --- */

abstract class RecieverEvent {
  const RecieverEvent();
}

class AddReciever extends RecieverEvent {
  Reciever item;
  AddReciever({required this.item});
}

class RemoveReciever extends RecieverEvent {
  Reciever item;
  RemoveReciever({required this.item});
}

class ClearRecievers extends RecieverEvent {
  ClearRecievers();
}
