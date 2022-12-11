import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_template/features/reciever/revievers_bloc.dart';
import 'package:flutter_bloc_template/ui/components/loading_indicator.dart';
import 'package:flutter_bloc_template/ui/components/menu_button.dart';
import 'package:flutter_bloc_template/ui/screens/user_profile/recievers_list/reciever_edit_page.dart';

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
                leading: const Icon(CupertinoIcons.person_alt),
                trailing: IconButton(
                    onPressed: () {
                      context.read<RecieversBloc>().add(RemoveReciever(item: state.items[index]));
                    },
                    icon: const Icon(CupertinoIcons.trash)),
                title: Text(state.items[index].name),
                subtitle: Text('+${state.items[index].phoneNumber}'),
                onTap: () {
                  Navigator.of(context).push(CupertinoPageRoute(
                      builder: ((context) => RecieverEditPage(reciever: state.items[index]))));
                },
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context)
                    .push(CupertinoPageRoute(builder: ((context) => const RecieverEditPage())));
              },
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
