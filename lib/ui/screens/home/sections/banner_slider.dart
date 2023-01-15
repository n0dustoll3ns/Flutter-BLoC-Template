import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_template/features/home_page_data/main_banner/banner_info.dart';
import 'package:flutter_bloc_template/features/home_page_data/main_banner/main_banners_bloc.dart';
import 'package:flutter_bloc_template/features/bottom_nav_bar_bloc/bottom_nav_bar_bloc.dart';
import 'package:flutter_bloc_template/ui/components/loading_indicator.dart';

class BannerSlider extends StatelessWidget {
  const BannerSlider({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MainBannersBloc, MainBannersState>(builder: (context, state) {
      if (state is MainBannersUpdated) {
        var banners = state.items;
        return CarouselSlider(
          items: List.generate(banners.length, (index) {
            return Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height / 1.72 / 2,
                  width: MediaQuery.of(context).size.width,
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      Image.network(
                        banners[index].backgroundUrl,
                        fit: BoxFit.cover,
                        width: MediaQuery.of(context).size.width,
                      ),
                      if (banners[index].foregroundUrl != null)
                        Image.network(
                          banners[index].foregroundUrl!,
                          fit: BoxFit.fitHeight,
                          width: MediaQuery.of(context).size.width,
                        ),
                    ],
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height / 1.72 / 2,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        banners[index].announce,
                        style: Theme.of(context).textTheme.headline4,
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        banners[index].description ?? '',
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      if (banners[index].buttonText != null)
                        ElevatedButton(
                            onPressed: () => onButtonTap(context, banners[index]),
                            child: Text(banners[index].buttonText!))
                    ],
                  ),
                )
              ],
            );
          }),
          options: CarouselOptions(
            height: MediaQuery.of(context).size.height / 1.72,
            viewportFraction: 1,
            autoPlay: false,
          ),
        );
      }
      return const LoadingIndicator();
    });
  }

  void onButtonTap(BuildContext context, BannerInfo details) {
    if (details.routeName != null && details.routeName != '') {
      Navigator.pushNamed(context, details.routeName!, arguments: details.routeSettings);
    }
  }
}
