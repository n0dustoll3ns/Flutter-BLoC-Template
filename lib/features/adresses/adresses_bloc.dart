import 'package:flutter_bloc/flutter_bloc.dart';

import '../authentication/user_repository.dart';
import '../user/model.dart';
import 'adresses_repository.dart';
import 'model.dart';

class AdressesBloc extends Bloc<AdressEvent, AdressesState> {
  final UserRepository userRepository;
  final AdressesRepository _adressesRepository = AdressesRepository();

  AdressesBloc({required this.userRepository}) : super(AdressesInitial()) {
    on<AuthComplete>(onAuthorizationComplete);
    on<CreateAdress>(onAdresseAdded);
    on<UpdateAdress>(onAdresseUpdated);
    on<RemoveAdress>(onAdresseRemoved);
    on<ClearAdresses>(onClearAdresses);
  }

  Future<void> onAuthorizationComplete(
    AuthComplete event,
    Emitter<AdressesState> emit,
  ) async {
    emit(AdressesInitial());
    emit(AdressesLoading(items: state.items));
    var res = await _adressesRepository.loadAdresses(token: event.token);
    state.items.addAll(res);
    emit(AdressesUpdated(items: state.items));
  }

  Future<void> onAdresseAdded(
    CreateAdress event,
    Emitter<AdressesState> emit,
  ) async {
    emit(AdressesLoading(items: state.items));
    var res = await _adressesRepository.createAdress(
        token: event.token, userId: event.userData.id, adress: event.item);
    state.items.add(res);
    emit(AdressesUpdated(items: state.items));
  }

  Future<void> onAdresseUpdated(
    UpdateAdress event,
    Emitter<AdressesState> emit,
  ) async {
    emit(AdressesLoading(items: state.items));
    try {
      emit(AdressesLoading(items: state.items));
      var res = await _adressesRepository.updateAdress(
          token: event.token, userId: event.userData.id, adress: event.item);
      var index = state.items.indexWhere((element) => element.id == res.id);
      state.items.replaceRange(index, index + 1, [res]);
      emit(AdressesUpdated(items: state.items));
    } on Exception catch (_) {}
  }

  Future<void> onAdresseRemoved(
    RemoveAdress event,
    Emitter<AdressesState> emit,
  ) async {
    emit(AdressesLoading(items: state.items));
    try {
      emit(AdressesLoading(items: state.items));
      await _adressesRepository.removeAdress(
          token: event.token, userId: event.userData.id, adressId: event.item.id);
      state.items.removeWhere((element) => element.id == event.item.id);
      emit(AdressesUpdated(items: state.items));
    } on Exception catch (_) {}
  }

  void onClearAdresses(
    ClearAdresses event,
    Emitter<AdressesState> emit,
  ) {
    emit(AdressesInitial());
  }
}

/* ---  States   --- */
abstract class AdressesState {
  final List<Adress> items;

  AdressesState({required this.items});
}

class AdressesInitial extends AdressesState {
  AdressesInitial() : super(items: []);
}

class AdressesLoading extends AdressesState {
  AdressesLoading({required super.items});
}

class AdressesUpdated extends AdressesState {
  AdressesUpdated({required super.items});
}

/* ---  Events   --- */

abstract class AdressEvent {
  const AdressEvent();
}

class CreateAdress extends AdressEvent {
  final Adress item;
  final UserData userData;
  final String token;
  const CreateAdress({required this.item, required this.token, required this.userData});
}

class UpdateAdress extends AdressEvent {
  Adress item;
  UserData userData;
  String token;
  UpdateAdress({required this.item, required this.token, required this.userData});
}

class AuthComplete extends AdressEvent {
  final String token;
  final UserData userData;
  const AuthComplete({required this.token, required this.userData});
}

class RemoveAdress extends AdressEvent {
  final Adress item;
  final UserData userData;
  final String token;
  const RemoveAdress({required this.item, required this.token, required this.userData});
}

class ClearAdresses extends AdressEvent {
  ClearAdresses();
}
