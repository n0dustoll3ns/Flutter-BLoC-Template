import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_template/features/home_page_data/secondary_banner/secondary_banner.dart';

import 'repository.dart';

class SecondaryBannersBloc extends Bloc<SecondaryBannerEvent, SecondaryBannersState> {
  SecondaryBannerRepository repository = SecondaryBannerRepository();
  SecondaryBannersBloc() : super(SecondaryBannersInitial()) {
    on<AppStarted>(onAppStarted);
  }

  Future<void> onAppStarted(
    AppStarted event,
    Emitter<SecondaryBannersState> emit,
  ) async {
    emit(SecondaryBannersLoading(items: state.items));
    var banners = await repository.loadSecondaryBannersData();
    emit(SecondaryBannersUpdated(items: state.items + banners));
  }
}

/* ---  States   --- */
abstract class SecondaryBannersState {
  final List<SecondaryBannerInfo> items;

  SecondaryBannersState({required this.items});
}

class SecondaryBannersInitial extends SecondaryBannersState {
  SecondaryBannersInitial() : super(items: []);
}

class SecondaryBannersLoading extends SecondaryBannersState {
  SecondaryBannersLoading({required super.items});
}

class SecondaryBannersUpdated extends SecondaryBannersState {
  SecondaryBannersUpdated({required super.items});
}

/* ---  Events   --- */

abstract class SecondaryBannerEvent {
  const SecondaryBannerEvent();
}

class AppStarted extends SecondaryBannerEvent {
  AppStarted();
}
