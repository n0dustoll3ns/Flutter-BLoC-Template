import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_template/features/brands/model.dart';

import '../../brands/repository.dart';

class MainPageBrandsBloc extends Bloc<BrandEvent, BrandsState> {
  BrandsRepository repository = BrandsRepository();
  MainPageBrandsBloc() : super(BrandsInitial()) {
    on<AppStarted>(onAppStarted);
  }

  Future<void> onAppStarted(
    AppStarted event,
    Emitter<BrandsState> emit,
  ) async {
    emit(BrandsLoading(items: state.items));
    var banners = await repository.mainPageBrandsInfo();
    emit(BrandsUpdated(items: state.items + banners));
  }
}

/* ---  States   --- */
abstract class BrandsState {
  final List<Brand> items;

  BrandsState({required this.items});
}

class BrandsInitial extends BrandsState {
  BrandsInitial() : super(items: []);
}

class BrandsLoading extends BrandsState {
  BrandsLoading({required super.items});
}

class BrandsUpdated extends BrandsState {
  BrandsUpdated({required super.items});
}

/* ---  Events   --- */

abstract class BrandEvent {
  const BrandEvent();
}

class AppStarted extends BrandEvent {
  const AppStarted();
}
