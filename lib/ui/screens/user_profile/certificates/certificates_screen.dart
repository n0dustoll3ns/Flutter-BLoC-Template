import 'package:flutter/material.dart';

class CertificatesScreen extends StatelessWidget {
  const CertificatesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var formKey = GlobalKey<FormState>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Certificates'),
      ),
      body: Padding(
        padding: EdgeInsets.all(MediaQuery.of(context).size.width / 22),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              "You don't have any active certificates",
              style: Theme.of(context).textTheme.headline4,
            ),
            Text(
              "If You have certificate, but it doesn't display here, you can add it manually",
              style: Theme.of(context).textTheme.headline6,
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "If You have certificate, but it doesn't display here, you can add it manually",
                style: Theme.of(context).textTheme.headline5,
              ),
            ),
            Form(
              key: formKey,
              child: TextFormField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return 'Incorrect code';
                },
              ),
            ),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.all(MediaQuery.of(context).size.width / 44),
                  textStyle: Theme.of(context).textTheme.headline5,
                ),
                onPressed: () {
                  formKey.currentState!.validate();
                },
                child: const Text("Add certificate"))
          ],
        ),
      ),
    );
  }
}
