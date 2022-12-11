import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../features/adresses/model.dart';
import '../../../../features/adresses/adresses_bloc.dart';

class AdressEditPage extends StatelessWidget {
  final Adress? adress;
  const AdressEditPage({super.key, this.adress});

  @override
  Widget build(BuildContext context) {
    var buildingNumberController = TextEditingController(text: adress?.buildingNumber ?? '');
    var streetNameController = TextEditingController(text: adress?.streetName ?? '');
    var townController = TextEditingController(text: adress?.town ?? '');
    var zipCodeController = TextEditingController(text: adress?.zipCode.toString() ?? '');
    return Scaffold(
      appBar: AppBar(title: Text(adress != null ? 'Edit adress' : 'New adress')),
      body: ListView(
        padding: EdgeInsets.all(MediaQuery.of(context).size.width / 22),
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(controller: buildingNumberController),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(controller: streetNameController),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(controller: townController),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly],
              controller: zipCodeController,
              onFieldSubmitted: (value) => completeEditing(
                context,
                buildingNumberController,
                streetNameController,
                townController,
                zipCodeController,
              ),
            ),
          ),
          ElevatedButton(
              onPressed: () => completeEditing(
                    context,
                    buildingNumberController,
                    streetNameController,
                    townController,
                    zipCodeController,
                  ),
              child: const Text('Save'))
        ],
      ),
    );
  }

  void completeEditing(
    BuildContext context,
    TextEditingController buildingNumberController,
    TextEditingController streetNameController,
    TextEditingController townController,
    TextEditingController zipCodeController,
  ) {
    if (adress != null) {
      context.read<AdressesBloc>().add(UpdateAdress(
              item: Adress(
            buildingNumber: buildingNumberController.text,
            streetName: streetNameController.text,
            town: townController.text,
            zipCode: int.parse(zipCodeController.text),
            id: adress!.id,
          )));
    } else {
      context.read<AdressesBloc>().add(AddAdress(
              item: Adress(
            buildingNumber: buildingNumberController.text,
            streetName: streetNameController.text,
            town: townController.text,
            zipCode: int.parse(zipCodeController.text),
            id: context.read<AdressesBloc>().state.items.map((e) => e.id).toList().reduce(max) + 1,
          )));
    }
    Navigator.of(context).pop();
  }
}
