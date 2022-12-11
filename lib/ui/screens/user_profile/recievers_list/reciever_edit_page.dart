import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_template/features/reciever/revievers_bloc.dart';

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
            child: TextFormField(controller: nameController),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly],
              controller: phoneController,
              onFieldSubmitted: (value) => completeEditing(context, nameController, phoneController),
            ),
          ),
          ElevatedButton(
              onPressed: () {
                completeEditing(context, nameController, phoneController);
              },
              child: const Text('Save'))
        ],
      ),
    );
  }

  void completeEditing(
      BuildContext context, TextEditingController nameController, TextEditingController phoneController) {
    if (reciever != null) {
      context.read<RecieversBloc>().add(UpdateReciever(
          item: Reciever(
              name: nameController.text, phoneNumber: int.parse(phoneController.text), id: reciever!.id)));
    } else {
      context.read<RecieversBloc>().add(AddReciever(
          item: Reciever(
              name: nameController.text,
              phoneNumber: int.parse(phoneController.text),
              id: context.read<RecieversBloc>().state.items.map((e) => e.id).toList().reduce(max) + 1)));
    }
    Navigator.of(context).pop();
  }
}
