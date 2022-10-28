import 'package:flutter/material.dart';

Future<bool?> errorDialog(BuildContext context) async {
  return await showDialog(
      context: context,
      builder: ((context) => AlertDialog(
            title: const Text('Возникла Ошибка'),
            content: const Text('Что-то пошло не так'),
            actions: [
              ElevatedButton(
                onPressed: (() => Navigator.of(context).pop(true)),
                child: const Text('Ок'),
              )
            ],
          )));
}
