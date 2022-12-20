import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_template/app/routes/routes.dart';
import 'package:flutter_bloc_template/features/user/states.dart';
import 'package:flutter_bloc_template/features/user/user_bloc.dart';
import 'package:flutter_bloc_template/ui/components/error_container.dart';
import 'package:flutter_bloc_template/ui/components/menu_button.dart';
import 'package:flutter_bloc_template/ui/screens/user_profile/adresses_list/adresses.dart';
import 'package:flutter_bloc_template/ui/screens/user_profile/components/personal_data.dart';
import 'package:flutter_bloc_template/ui/components/loading_indicator.dart';
import 'package:flutter_bloc_template/ui/screens/user_profile/recievers_list/recievers.dart';
import 'package:flutter_bloc_template/ui/screens/user_profile/reviews/reviews_list.dart';

import '../../../app/routes/constants.dart';
import 'personal_data_screen/personal_data_page.dart';
import 'components/avatar.dart';
import 'components/bonuses_info.dart';
import 'components/learn_more_button.dart';

class UserProfile extends StatelessWidget {
  const UserProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserBloc, UserState>(builder: (context, state) {
      if (state is UserInitial) {
        return const ErrorBox(message: 'Somethig went wrong');
      } else if (state is UserFailure) {
        return ErrorBox(message: state.error);
      } else if (state is UserLoading) {
        return const LoadingIndicator();
      }
      state as UserDataLoaded;
      return Scaffold(
        appBar: AppBar(
          title: Text(mainPageSections[4]),
          actions: const [MenuButton()],
        ),
        body: ListView(
          children: [
            SizedBox(height: MediaQuery.of(context).size.height / 32),
            const Avatar(),
            SizedBox(height: MediaQuery.of(context).size.height / 32),
            PersonalData(userData: state.userData),
            SizedBox(height: MediaQuery.of(context).size.height / 32),
            BonusesInfo(userData: state.userData),
            const LearnMore(),
            ListTile(
              leading: const Icon(Icons.person),
              title: const Text('Personal data'),
              onTap: () => Navigator.of(context).push(
                  CupertinoPageRoute(builder: ((context) => PersonalDataPage(userData: state.userData)))),
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.shopping_bag_outlined),
              title: const Text('Orders'),
              onTap: () => Navigator.of(context).push(Routes.ordersList),
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.comment_rounded),
              title: const Text('Reviews'),
              onTap: () =>
                  Navigator.of(context).push(CupertinoPageRoute(builder: ((context) => const ReviewsList()))),
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.people_rounded),
              title: const Text('My receivers'),
              onTap: () => Navigator.of(context)
                  .push(CupertinoPageRoute(builder: ((context) => const RecieversListScreen()))),
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.gite_outlined),
              title: const Text('My adresses'),
              onTap: () => Navigator.of(context)
                  .push(CupertinoPageRoute(builder: ((context) => const AdressesListScreen()))),
            ),
            const Divider(),
            const ListTile(leading: Icon(Icons.wallet_rounded), title: Text('My cards')),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.card_giftcard_rounded),
              title: const Text('My certificates'),
              onTap: () => Navigator.of(context).push(Routes.certificatesScreen),
            ),
            const Divider(),
          ],
        ),
      );
    });
  }
}
