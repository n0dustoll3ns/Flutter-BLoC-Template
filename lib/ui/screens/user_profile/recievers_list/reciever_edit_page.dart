import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_template/features/reciever/recievers_bloc.dart';

import '../../../../features/authentication/auth_bloc.dart';
import '../../../../features/authentication/states.dart';
import '../../../../features/reciever/model.dart';

class RecieverEditPage extends StatelessWidget {
  final Reciever? reciever;
  const RecieverEditPage({super.key, this.reciever});

  @override
  Widget build(BuildContext context) {
    var nameController = TextEditingController(text: reciever?.name ?? '');
    var phoneController = TextEditingController(text: reciever?.phoneNumber.toString() ?? '');
    return Scaffold(
      appBar: AppBar(title: Text(reciever?.name ?? 'New receiver')),
      body: ListView(
        padding: EdgeInsets.all(MediaQuery.of(context).size.width / 22),
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              decoration: const InputDecoration(label: Text('Full name')),
              controller: nameController,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              decoration: const InputDecoration(label: Text('Phone number')),
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly],
              controller: phoneController,
              onFieldSubmitted: (value) => completeEditing(context, nameController, phoneController),
            ),
          ),
          ElevatedButton(
              onPressed: () => completeEditing(context, nameController, phoneController),
              child: const Text('Save'))
        ],
      ),
    );
  }

  void completeEditing(
      BuildContext context, TextEditingController nameController, TextEditingController phoneController) {
    var userData = (context.read<AuthenticationBloc>().state as AuthenticationAuthenticated).userData;
    var token = (context.read<AuthenticationBloc>().state as AuthenticationAuthenticated).token;

    if (reciever != null) {
      context.read<RecieversBloc>().add(
            UpdateReciever(
              item: Reciever(
                name: nameController.text,
                phoneNumber: int.parse(phoneController.text),
                id: reciever!.id,
              ),
              token: token,
              userData: userData,
            ),
          );
    } else {
      context.read<RecieversBloc>().add(AddReciever(
            item: Reciever(
                name: nameController.text,
                phoneNumber: int.parse(phoneController.text),
                id: '',
                ),
            token: token,
            userData: userData,
          ));
    }
    Navigator.of(context).pop();
  }
}
