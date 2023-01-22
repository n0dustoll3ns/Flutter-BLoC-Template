import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_template/features/reciever/model.dart';
import 'package:flutter_bloc_template/features/reciever/recievers_repository.dart';

import '../user/model.dart';

class RecieversBloc extends Bloc<RecieverEvent, RecieversState> {
  final RecieversRepository _recieversRepository = RecieversRepository();

  RecieversBloc() : super(RecieversInitial()) {
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
    emit(RecieversInitial());
    emit(RecieversLoading(items: state.items));
    var res = await _recieversRepository.loadRecievers(token: event.token,);
    state.items.addAll(res);
    emit(RecieversUpdated(items: state.items));
  }

  Future<void> onRecieverAdded(
    AddReciever event,
    Emitter<RecieversState> emit,
  ) async {
    emit(RecieversLoading(items: state.items));
    var res = await _recieversRepository.createReciever(
        token: event.token, userId: event.userData.id, reciever: event.item);
    state.items.add(res);
    emit(RecieversUpdated(items: state.items));
  }

  Future<void> onRecieverUpdated(
    UpdateReciever event,
    Emitter<RecieversState> emit,
  ) async {
    emit(RecieversLoading(items: state.items));
    try {
      emit(RecieversLoading(items: state.items));
      var res = await _recieversRepository.updateReciever(
          token: event.token, userId: event.userData.id, reciever: event.item);
      var index = state.items.indexWhere((element) => element.id == res.id);
      state.items.replaceRange(index, index + 1, [res]);
      emit(RecieversUpdated(items: state.items));
    } on Exception catch (_) {
    }
  }

  Future<void> onRecieverRemoved(
    RemoveReciever event,
    Emitter<RecieversState> emit,
  ) async{
    emit(RecieversLoading(items: state.items));
    try {
      emit(RecieversLoading(items: state.items));
      var recieverId = event.item.id;
      await _recieversRepository.removeReciever(
          token: event.token, userId: event.userData.id, recieverId: recieverId);
      state.items.removeWhere((element) => element.id == recieverId);
      emit(RecieversUpdated(items: state.items));
    } on Exception catch (_) {}
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
  UserData userData;
  String token;
  AddReciever({required this.item, required this.userData, required this.token});
}

class UpdateReciever extends RecieverEvent {
  Reciever item;
  UserData userData;
  String token;
  UpdateReciever({required this.item, required this.userData, required this.token});
}

class Authorized extends RecieverEvent {
  UserData userData;
  String token;
  Authorized({required this.userData, required this.token});
}

class RemoveReciever extends RecieverEvent {
  Reciever item;
  UserData userData;
  String token;
  RemoveReciever({required this.item, required this.userData, required this.token});
}

class ClearRecievers extends RecieverEvent {
  ClearRecievers();
}
