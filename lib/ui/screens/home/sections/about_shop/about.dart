import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_template/ui/components/error_container.dart';

import '../../../../../app/routes/routes.dart';
import '../../../../../features/home_page_data/about_shop/bloc.dart';
import '../../../../components/loading_indicator.dart';

class SectionAbout extends StatelessWidget {
  const SectionAbout({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AboutShopBloc, AboutShopState>(builder: (context, state) {
      if (state is AboutShopLoading) return const LoadingIndicator();
      if (state is AboutShopUpdated) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            InkWell(
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height / 4,
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    Image.network(
                      state.details.imageUrl,
                      fit: BoxFit.cover,
                    ),
                    Icon(
                      Icons.play_circle_filled_rounded,
                      size: MediaQuery.of(context).size.width / 8,
                      color: Theme.of(context).primaryColor,
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(32.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'About Company',
                    style: Theme.of(context).textTheme.labelMedium,
                  ),
                  Text(
                    state.details.title,
                    style: Theme.of(context).textTheme.headline4,
                  ),
                  Text(
                    state.details.description,
                    style: Theme.of(context).textTheme.bodyLarge,
                    overflow: TextOverflow.fade,
                  ),
                  Center(
                    child: ElevatedButton(
                        onPressed: () => Navigator.of(context).pushNamed(Routes.aboutShopScreen),
                        child: const Text('Learn more')),
                  ),
                ],
              ),
            ),
          ],
        );
      }
      return const ErrorBox();
    });
  }
}
