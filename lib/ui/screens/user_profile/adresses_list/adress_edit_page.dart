import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../features/adresses/model.dart';
import '../../../../features/adresses/adresses_bloc.dart';
import '../../../../features/authentication/auth_bloc.dart';
import '../../../../features/authentication/states.dart';

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
            child: TextFormField(
              controller: buildingNumberController,
              decoration: const InputDecoration(label: Text('Building number')),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              controller: streetNameController,
              decoration: const InputDecoration(label: Text('Street name')),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              controller: townController,
              decoration: const InputDecoration(label: Text('City name')),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly],
              controller: zipCodeController,
              decoration: const InputDecoration(label: Text('Zip code')),
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

  Future<void> completeEditing(
    BuildContext context,
    TextEditingController buildingNumberController,
    TextEditingController streetNameController,
    TextEditingController townController,
    TextEditingController zipCodeController,
  ) async {
    var userData = (context.read<AuthenticationBloc>().state as AuthenticationAuthenticated).userData;
    var token = (context.read<AuthenticationBloc>().state as AuthenticationAuthenticated).token;

    if (adress != null) {
      context.read<AdressesBloc>().add(UpdateAdress(
          userData: userData,
          token: token,
          item: Adress(
            buildingNumber: buildingNumberController.text,
            streetName: streetNameController.text,
            town: townController.text,
            zipCode: zipCodeController.text,
            id: adress!.id,
          )));
    } else {
      context.read<AdressesBloc>().add(CreateAdress(
          userData: userData,
          token: token,
          item: Adress(
            buildingNumber: buildingNumberController.text,
            streetName: streetNameController.text,
            town: townController.text,
            zipCode: zipCodeController.text,
            id: '',
          )));
    }
    Navigator.of(context).pop();
  }
}
