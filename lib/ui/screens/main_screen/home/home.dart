import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../app/routes/constants.dart';
import '../../../../features/authentication/auth_bloc.dart';
import '../../../../features/authentication/states.dart';
import '../../../components/menu_button.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late final AuthenticationBloc authBloc;
  @override
  void initState() {
    authBloc = context.read<AuthenticationBloc>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(mainPageSections[0]),
        actions: const [MenuButton()],
      ),
      body: const Center(child: Text("home")),
    );
  }

  void logout() {
    authBloc.add(LoggedOut());
  }
}
