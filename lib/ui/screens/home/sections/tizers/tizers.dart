import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_template/features/home_page_data/tizers/bloc.dart';
import 'package:flutter_bloc_template/ui/components/loading_indicator.dart';

import 'tizer.dart';

class Tizers extends StatelessWidget {
  const Tizers({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => TizersBloc()..add(AppStarted()),
      child: BlocBuilder<TizersBloc, TizersState>(builder: (context, state) {
        if (state is TizersLoading) {
          return const LoadingIndicator();
        }
        return Wrap(
          runSpacing: MediaQuery.of(context).size.height / 55,
          alignment: WrapAlignment.center,
          children: state.items.map((e) => Tizer(details: e)).toList(),
        );
      }),
    );
  }
}
