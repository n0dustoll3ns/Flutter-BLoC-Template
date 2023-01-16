import 'package:flutter_bloc/flutter_bloc.dart';

import '../authentication/user_repository.dart';
import 'adresses_repository.dart';
import 'model.dart';

class AdressesBloc extends Bloc<AdressEvent, AdressesState> {
  final UserRepository userRepository;
  final AdressesRepository _adressesRepository = AdressesRepository();

  AdressesBloc({required this.userRepository}) : super(AdressesInitial()) {
    on<AuthComplete>(onAuthorizationComplete);
    on<AddAdress>(onAdresseAdded);
    on<UpdateAdress>(onAdresseUpdated);
    on<RemoveAdress>(onAdresseRemoved);
    on<ClearAdresses>(onClearAdresses);
  }

  Future<void> onAuthorizationComplete(
    AuthComplete event,
    Emitter<AdressesState> emit,
  ) async {
    emit(AdressesLoading(items: state.items));
    var res = await _adressesRepository.loadAdresses(
      token: event.token,
    );
    state.items.addAll(res);
    emit(AdressesUpdated(items: state.items));
  }

  void onAdresseAdded(
    AddAdress event,
    Emitter<AdressesState> emit,
  ) {
    state.items.add(event.item);
    emit(AdressesUpdated(items: state.items));
  }

  void onAdresseUpdated(
    UpdateAdress event,
    Emitter<AdressesState> emit,
  ) {
    emit(AdressesLoading(items: state.items));
    var adress = state.items.firstWhere((element) => element.id == event.item.id);
    try {
      // _adressesRepository.updateAdress(token: userRepository.token, adress: event.item);
      adress.buildingNumber = event.item.buildingNumber;
      adress.streetName = event.item.streetName;
      adress.town = event.item.town;
      adress.zipCode = event.item.zipCode;
      emit(AdressesUpdated(items: state.items));
    } on Exception catch (_) {}
  }

  void onAdresseRemoved(
    RemoveAdress event,
    Emitter<AdressesState> emit,
  ) {
    emit(AdressesLoading(items: state.items));
    try {
      // _adressesRepository.updateAdress(token: userRepository.token, adress: event.item);
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

class AddAdress extends AdressEvent {
  Adress item;
  AddAdress({required this.item});
}

class UpdateAdress extends AdressEvent {
  Adress item;
  UpdateAdress({required this.item});
}

class AuthComplete extends AdressEvent {
  final String token;
  AuthComplete({required this.token});
}

class RemoveAdress extends AdressEvent {
  Adress item;
  RemoveAdress({required this.item});
}

class ClearAdresses extends AdressEvent {
  ClearAdresses();
}
