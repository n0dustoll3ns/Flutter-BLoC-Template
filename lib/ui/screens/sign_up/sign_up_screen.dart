import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc_template/utils/date_without_time.dart';
import 'package:flutter_bloc_template/utils/urls.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _repeatController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _bDayController = TextEditingController();
  DateTime? _bDay;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign up'),
      ),
      body: SingleChildScrollView(
        child: Form(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Padding(
                padding: EdgeInsets.all(MediaQuery.of(context).size.height / 44),
                child: TextFormField(
                  decoration: const InputDecoration(
                    label: Text('Name'),
                  ),
                  controller: _nameController,
                ),
              ),
              Padding(
                padding: EdgeInsets.all(MediaQuery.of(context).size.height / 44),
                child: TextFormField(
                  decoration: const InputDecoration(
                    label: Text('Email'),
                  ),
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  validator: (input) => input != null && input.isValidEmail() ? null : "Check your email",
                ),
              ),
              Padding(
                padding: EdgeInsets.all(MediaQuery.of(context).size.height / 44),
                child: TextFormField(
                  decoration: const InputDecoration(label: Text('Password')),
                  controller: _passwordController,
                  obscureText: true,
                ),
              ),
              Padding(
                padding: EdgeInsets.all(MediaQuery.of(context).size.height / 44),
                child: TextFormField(
                  decoration: const InputDecoration(label: Text('Repeat password')),
                  controller: _repeatController,
                  obscureText: true,
                  validator: (val) {
                    if (val == null || val.isEmpty) return 'Empty';
                    if (val != _passwordController.text) return 'Not Match';
                    return null;
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.all(MediaQuery.of(context).size.height / 44),
                child: TextFormField(
                    decoration: const InputDecoration(label: Text('Phone')),
                    controller: _phoneController,
                    obscureText: true,
                    keyboardType: TextInputType.number),
              ),
              Padding(
                padding: EdgeInsets.all(MediaQuery.of(context).size.height / 44),
                child: TextField(
                    onTap: () => _pickDate(context),
                    inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly],
                    decoration: InputDecoration(
                        label: const Text('Date of birth'),
                        suffix: InkWell(
                          onTap: () => _pickDate(context),
                          child: const Icon(Icons.calendar_month),
                        )),
                    controller: _bDayController,
                    readOnly: true,
                    keyboardType: TextInputType.datetime),
              ),
              ElevatedButton(
                onPressed: _onSignupButtonPressed,
                child: const Text('Sign up'),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _onSignupButtonPressed() async {
    final body = <String, dynamic>{
      "username": _emailController.text.replaceAll('@', "_"),
      "email": _emailController.text,
      "emailVisibility": true,
      "password": _passwordController.text,
      "passwordConfirm": _repeatController.text,
      "name": _nameController.text,
      "phone": int.tryParse(_phoneController.text),
      "bDay": _bDay.toString(),
      "status": "standart"
    };

    await pb.collection('users').create(body: body);

    await pb.collection('users').requestVerification(_emailController.text);
  }

  Future<void> _pickDate(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime(DateTime.now().year - 22),
      firstDate: DateTime(1955),
      lastDate: DateTime.now(),
    );
    if (pickedDate != null) {
      _bDay = pickedDate;
      _bDayController.text = pickedDate.onlyDate;
    }
  }
}
