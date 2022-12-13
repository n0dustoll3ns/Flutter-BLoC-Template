import 'package:flutter/material.dart';

class PaymentSafetyShield extends StatelessWidget {
  const PaymentSafetyShield({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text('Pay safely with '),
          Container(
            decoration: BoxDecoration(
              border: Border.all(width: 1, color: Colors.black87),
              borderRadius: BorderRadius.circular(44),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: const [
                Icon(Icons.paid_rounded),
                Padding(
                  padding: EdgeInsets.only(right: 5.5),
                  child: Text('Pay'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
