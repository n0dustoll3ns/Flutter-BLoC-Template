import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_template/features/authentication/auth_bloc.dart';
import 'package:flutter_bloc_template/features/authentication/states.dart';
import 'package:flutter_bloc_template/features/user/states.dart';
import 'package:flutter_bloc_template/features/user/user_bloc.dart';
import 'package:flutter_bloc_template/utils/date_without_time.dart';

class UserDataFields extends StatelessWidget {
  final UserData userData;
  const UserDataFields({super.key, required this.userData});

  @override
  Widget build(BuildContext context) {
    var dateController = TextEditingController(text: userData.bDay.toStringDate());
    Future<void> pickDate(BuildContext context) async {
      DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: DateTime(DateTime.now().year - 22),
        firstDate: DateTime(1955),
        lastDate: DateTime.now(),
      );
      if (pickedDate != null) {
        userData.bDay = pickedDate;
        dateController.text = pickedDate.toStringDate();
      }
    }
    return ListView(
      padding: const EdgeInsets.all(8),
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      children: [
        TextField(
          enabled: false,
          decoration: const InputDecoration(label: Text('Login')),
          controller: TextEditingController(text: userData.userLogin),
        ),
        SizedBox(height: MediaQuery.of(context).size.height / 32),
        TextField(
          decoration: const InputDecoration(label: Text('First Name')),
          controller: TextEditingController(text: userData.firstName),
          onChanged: (value) => userData.firstName = value,
        ),
        SizedBox(height: MediaQuery.of(context).size.height / 32),
        TextField(
          decoration: const InputDecoration(label: Text('Last Name')),
          controller: TextEditingController(text: userData.lastName),
          onChanged: (value) => userData.lastName = value,
        ),
        SizedBox(height: MediaQuery.of(context).size.height / 32),
        TextField(
          decoration: const InputDecoration(label: Text('Email')),
          controller: TextEditingController(text: userData.email),
          onChanged: (value) => userData.email = value,
        ),
        SizedBox(height: MediaQuery.of(context).size.height / 32),
        TextField(
            inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly],
            decoration: const InputDecoration(label: Text('Phone')),
            controller: TextEditingController(text: userData.mobile.toString()),
            onChanged: (value) => userData.mobile = int.parse(value),
            keyboardType: TextInputType.number),
        SizedBox(height: MediaQuery.of(context).size.height / 32),
        TextField(
            onTap: () => pickDate(context),
            inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly],
            decoration: InputDecoration(
                label: const Text('Date of birth'),
                suffix: InkWell(
                  onTap: () => pickDate(context),
                  child: const Icon(Icons.calendar_month),
                )),
            controller: dateController,
            readOnly: true,
            keyboardType: TextInputType.datetime),
        ElevatedButton(
            onPressed: () {
              var authBlocState = context.read<AuthenticationBloc>().state;
              if (authBlocState is AuthenticationAuthenticated) {
                context
                    .read<UserBloc>()
                    .add(EditUserDataButtonPressed(newUserData: userData, token: authBlocState.token));
              }
            },
            child: const Text('Save'))
      ],
    );
  }
}
