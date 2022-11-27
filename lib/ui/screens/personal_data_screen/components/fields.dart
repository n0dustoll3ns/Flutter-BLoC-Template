import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_template/features/user/states.dart';
import 'package:flutter_bloc_template/features/user/user_bloc.dart';
import 'package:flutter_bloc_template/utils/date_without_time.dart';

class UserDataFields extends StatelessWidget {
  const UserDataFields({super.key});

  @override
  Widget build(BuildContext context) {
    var userData = (context.read<UserBloc>().state as UserDataLoaded).userData;
    var dateController = TextEditingController(text: userData.bDay.toStringDate());

    Future<void> pickDate(BuildContext context) async {
      DateTime? pickedDate = await showDatePicker(
        context: context, //context of current state
        initialDate: DateTime.now(),
        firstDate: DateTime(2000), //DateTime.now() - not to allow to choose before today.
        lastDate: DateTime(2101),
      );
      if (pickedDate != null) {
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
        ),
        SizedBox(height: MediaQuery.of(context).size.height / 32),
        TextField(
          decoration: const InputDecoration(label: Text('Last Name')),
          controller: TextEditingController(text: userData.lastName),
        ),
        SizedBox(height: MediaQuery.of(context).size.height / 32),
        TextField(
          decoration: const InputDecoration(label: Text('Email')),
          controller: TextEditingController(text: userData.email),
        ),
        SizedBox(height: MediaQuery.of(context).size.height / 32),
        TextField(
            inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly],
            decoration: const InputDecoration(label: Text('Phone')),
            controller: TextEditingController(text: userData.mobile.toString()),
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
      ],
    );
  }
}
