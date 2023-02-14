import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_template/features/home_page_data/about_shop/bloc.dart';
import 'package:flutter_bloc_template/features/home_page_data/about_shop/model.dart';

class AboutShopScreen extends StatelessWidget {
  const AboutShopScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var state = context.read<AboutShopBloc>().state;
    AboutShopData details = const AboutShopData(id: '', imageUrl: '', description: '', title: '');
    if (state is AboutShopUpdated) {
      details = state.details;
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text('About Shop'),
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width / 22),
        children: [
          Text(details.title, style: Theme.of(context).textTheme.headline4),
          Image.network(
            details.imageUrl,
            fit: BoxFit.fitWidth,
          ),
          Text(details.description, style: Theme.of(context).textTheme.bodyLarge),
        ],
      ),
    );
  }
}
