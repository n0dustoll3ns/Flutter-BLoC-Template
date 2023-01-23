import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_template/features/authentication/auth_bloc.dart';
import 'package:flutter_bloc_template/features/authentication/states.dart';
import 'package:flutter_bloc_template/ui/components/loading_indicator.dart';
import 'package:flutter_bloc_template/ui/components/menu_button.dart';

import '../../../../features/adresses/adresses_bloc.dart';
import 'adress_edit_page.dart';

class AdressesListScreen extends StatelessWidget {
  const AdressesListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Adresss'),
        actions: const [MenuButton()],
      ),
      body: BlocBuilder<AdressesBloc, AdressesState>(builder: (context, state) {
        return ListView(
          padding: EdgeInsets.all(MediaQuery.of(context).size.width / 22),
          children: [
            if (state is AdressesLoading) const LoadingIndicator(),
            ...List.generate(
              state.items.length,
              (index) => ListTile(
                leading: const Icon(CupertinoIcons.person_alt),
                trailing: IconButton(
                    onPressed: () {
                      var token =
                          (context.read<AuthenticationBloc>().state as AuthenticationAuthenticated).token;
                      var userData =
                          (context.read<AuthenticationBloc>().state as AuthenticationAuthenticated).userData;
                      context
                          .read<AdressesBloc>()
                          .add(RemoveAdress(item: state.items[index], token: token, userData: userData));
                    },
                    icon: const Icon(CupertinoIcons.trash)),
                title: Text('${state.items[index].town}, ${state.items[index].zipCode}'),
                subtitle: Text('${state.items[index].streetName}, ${state.items[index].buildingNumber}'),
                onTap: () {
                  Navigator.of(context).push(
                      CupertinoPageRoute(builder: ((context) => AdressEditPage(adress: state.items[index]))));
                },
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context)
                    .push(CupertinoPageRoute(builder: ((context) => const AdressEditPage())));
              },
              child: const Text(
                'Add Adress',
              ),
            ),
          ],
        );
      }),
    );
  }
}
