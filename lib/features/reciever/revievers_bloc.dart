import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_template/features/reciever/model.dart';
import 'package:flutter_bloc_template/features/reciever/recievers_repository.dart';

import '../authentication/user_repository.dart';

class RecieversBloc extends Bloc<RecieverEvent, RecieversState> {
  final UserRepository userRepository;
  final RecieversRepository _recieversRepository = RecieversRepository();

  RecieversBloc({required this.userRepository}) : super(RecieversInitial()) {
    on<Authorized>(onAuthorizationComplete);
    on<AddReciever>(onRecieverAdded);
    on<UpdateReciever>(onRecieverUpdated);
    on<RemoveReciever>(onRecieverRemoved);
    on<ClearRecievers>(onClearRecievers);
  }

  Future<void> onAuthorizationComplete(
    Authorized event,
    Emitter<RecieversState> emit,
  ) async {
    emit(RecieversLoading(items: state.items));
    var res = await _recieversRepository.loadRecievers(
      token: event.token,
    );
    state.items.addAll(res);
    emit(RecieversUpdated(items: state.items));
  }

  void onRecieverAdded(
    AddReciever event,
    Emitter<RecieversState> emit,
  ) {
    state.items.add(event.item);
    emit(RecieversUpdated(items: state.items));
  }

  void onRecieverUpdated(
    UpdateReciever event,
    Emitter<RecieversState> emit,
  ) {
    emit(RecieversLoading(items: state.items));
    try {
      _recieversRepository.updateReciever(token: userRepository.token, reciever: event.item);
      state.items.add(event.item);
      emit(RecieversUpdated(items: state.items));
    } on Exception catch (e) {
      // TODO
    }
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

class RecieversLoading extends RecieversState {
  RecieversLoading({required super.items});
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

class UpdateReciever extends RecieverEvent {
  Reciever item;
  UpdateReciever({required this.item});
}

class Authorized extends RecieverEvent {
  final String token;
  Authorized({required this.token});
}

class RemoveReciever extends RecieverEvent {
  Reciever item;
  RemoveReciever({required this.item});
}

class ClearRecievers extends RecieverEvent {
  ClearRecievers();
}
