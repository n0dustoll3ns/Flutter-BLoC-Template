import 'package:flutter_bloc/flutter_bloc.dart';

import 'repository.dart';
import 'tizer.dart';

class TizersBloc extends Bloc<TizerEvent, TizersState> {
  TizerRepository repository = TizerRepository();
  TizersBloc() : super(TizersInitial()) {
    on<AppStarted>(onAppStarted);
  }

  Future<void> onAppStarted(
    AppStarted event,
    Emitter<TizersState> emit,
  ) async {
    emit(TizersLoading(items: state.items));
    var banners = await repository.loadTizersData();
    emit(TizersUpdated(items: state.items + banners));
  }
}

/* ---  States   --- */
abstract class TizersState {
  final List<TizerInfo> items;

  TizersState({required this.items});
}

class TizersInitial extends TizersState {
  TizersInitial() : super(items: []);
}

class TizersLoading extends TizersState {
  TizersLoading({required super.items});
}

class TizersUpdated extends TizersState {
  TizersUpdated({required super.items});
}

/* ---  Events   --- */

abstract class TizerEvent {
  const TizerEvent();
}

class AppStarted extends TizerEvent {
  AppStarted();
}
