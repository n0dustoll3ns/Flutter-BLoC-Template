import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_template/features/reciever/revievers_bloc.dart';
import 'package:flutter_bloc_template/ui/components/loading_indicator.dart';
import 'package:flutter_bloc_template/ui/components/menu_button.dart';

class RecieversListScreen extends StatelessWidget {
  const RecieversListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Recievers'),
        actions: const [MenuButton()],
      ),
      body: BlocBuilder<RecieversBloc, RecieversState>(builder: (context, state) {
        return ListView(
          padding: EdgeInsets.all(MediaQuery.of(context).size.width / 22),
          children: [
            if (state is RecieversLoading) const LoadingIndicator(),
            ...List.generate(
              state.items.length,
              (index) => ListTile(
                leading: const Icon(Icons.person),
                trailing: const Icon(Icons.edit),
                title: Text(state.items[index].name),
                subtitle: Text('+${state.items[index].phoneNumber}'),
              ),
            ),
            TextButton(
              onPressed: () {},
              child: const Text(
                'Add reciever',
              ),
            ),
          ],
        );
      }),
    );
  }
}
