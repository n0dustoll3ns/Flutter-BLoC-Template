import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_template/features/home_page_data/about_shop/model.dart';
import 'package:flutter_bloc_template/features/home_page_data/about_shop/repository.dart';

class AboutShopBloc extends Bloc<AboutShopEvent, AboutShopState> {
  AboutShopDataRepository repository = AboutShopDataRepository();
  AboutShopBloc() : super(AboutShopLoading()) {
    on<InitializeAboutShop>(onInitAboutShopData);
    add(InitializeAboutShop());
  }

  Future<void> onInitAboutShopData(
    InitializeAboutShop event,
    Emitter<AboutShopState> emit,
  ) async {
    emit(AboutShopLoading());
    var details = await repository.load();
    emit(AboutShopUpdated(details: details));
  }
}

/* ---  States   --- */
abstract class AboutShopState {
  AboutShopState();
}

class AboutShopLoading extends AboutShopState {
  AboutShopLoading();
}

class AboutShopUpdated extends AboutShopState {
  AboutShopData details;
  AboutShopUpdated({required this.details});
}

/* ---  Events   --- */

abstract class AboutShopEvent {
  const AboutShopEvent();
}

class InitializeAboutShop extends AboutShopEvent {
  InitializeAboutShop();
}
