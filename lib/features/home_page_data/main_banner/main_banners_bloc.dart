import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_template/features/home_page_data/main_banner/banner_info.dart';

import 'repositoty.dart';

class MainBannersBloc extends Bloc<MainBannerEvent, MainBannersState> {
  MainBannerRepository repository = MainBannerRepository();
  MainBannersBloc() : super(MainBannersInitial()) {
    on<AppStarted>(onAppStarted);
  }

  Future<void> onAppStarted(
    AppStarted event,
    Emitter<MainBannersState> emit,
  ) async {
    emit(MainBannersLoading(items: state.items));
    var banners = await repository.loadMainBannersData();
    emit(MainBannersUpdated(items: state.items + banners));
  }
}

/* ---  States   --- */
abstract class MainBannersState {
  final List<BannerInfo> items;

  MainBannersState({required this.items});
}

class MainBannersInitial extends MainBannersState {
  MainBannersInitial() : super(items: []);
}

class MainBannersLoading extends MainBannersState {
  MainBannersLoading({required super.items});
}

class MainBannersUpdated extends MainBannersState {
  MainBannersUpdated({required super.items});
}

/* ---  Events   --- */

abstract class MainBannerEvent {
  const MainBannerEvent();
}

class AppStarted extends MainBannerEvent {
  AppStarted();
}
