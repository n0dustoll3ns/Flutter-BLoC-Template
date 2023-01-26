import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_template/app/routes/routes.dart';
import 'package:flutter_bloc_template/features/authentication/auth_bloc.dart';
import 'package:flutter_bloc_template/features/authentication/states.dart';
import 'package:flutter_bloc_template/ui/components/menu_button.dart';

import '../../../app/routes/constants.dart';
import '../../styles/constants.dart';
import 'components/authorization_form.dart';
import 'components/avatar.dart';
import 'components/learn_more_button.dart';

class UserProfile extends StatefulWidget {
  const UserProfile({super.key});

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  bool accentAuthorize = false;
  ScrollController controller = ScrollController();
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthenticationBloc, AuthenticationState>(builder: (context, state) {
      return Scaffold(
        appBar: AppBar(
          title: Text(state is! AuthenticationAuthenticated ? mainPageSections[4] : "Login"),
          centerTitle: true,
          actions: const [MenuButton()],
        ),
        body: ListView(
          controller: controller,
          children: [
            SizedBox(height: MediaQuery.of(context).size.height / 32),
            state is! AuthenticationAuthenticated
                ? AuthorizationForm(accentAuthorize: accentAuthorize)
                : Avatar(avatarUrl: state.userData.avatarUrl),
            SizedBox(height: MediaQuery.of(context).size.height / 32),
            const LearnMore(),
            ListTile(
              leading: const Icon(Icons.person),
              title: const Text('Personal data'),
              onTap: () => _actionIfauthorized(() => Navigator.of(context).pushNamed(Routes.personalData)),
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.shopping_bag_outlined),
              title: const Text('Orders'),
              onTap: () => _actionIfauthorized(() => Navigator.of(context).pushNamed(Routes.ordersList)),
            ),
            const Divider(),
            ListTile(
              leading: const Icon(CupertinoIcons.bolt),
              title: const Text('Active promotions'),
              onTap: () => Navigator.of(context).pushNamed(Routes.promotionsListPage),
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.comment_rounded),
              title: const Text('Reviews'),
              onTap: () => _actionIfauthorized(() => Navigator.of(context).pushNamed(Routes.reviewList)),
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.people_rounded),
              title: const Text('My receivers'),
              onTap: () => _actionIfauthorized(() => Navigator.of(context).pushNamed(Routes.recieversList)),
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.gite_outlined),
              title: const Text('My adresses'),
              onTap: () => _actionIfauthorized(() => Navigator.of(context).pushNamed(Routes.adressesList)),
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.card_giftcard_rounded),
              title: const Text('My certificates'),
              onTap: () =>
                  _actionIfauthorized(() => Navigator.of(context).pushNamed(Routes.certificatesScreen)),
            ),
            const Divider(),
          ],
        ),
      );
    });
  }

  void _actionIfauthorized(Function func) {
    if (context.read<AuthenticationBloc>().state is! AuthenticationAuthenticated) {
      _focusOnAuthFrom();
    } else {
      func();
    }
  }

  void _focusOnAuthFrom() {
    setState(() => accentAuthorize = true);
    Future.delayed(shakeDuration * 2, () => setState(() => accentAuthorize = false));
    controller.animateTo(controller.initialScrollOffset, duration: shakeDuration, curve: Curves.bounceInOut);
  }
}
