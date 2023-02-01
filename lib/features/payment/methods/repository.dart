import 'package:flutter_bloc_template/features/payment/methods/model.dart';
import 'package:flutter_bloc_template/utils/urls.dart';

class PaymentMethodsRepository {
  Future<List<PaymentMethod>> loadPaymentMethods() async {
    var response = await pb.collection('payment_methods').getFullList();
    List<PaymentMethod> list = response.map((e) => PaymentMethod.fromJson(id: e.id, json: e.data)).toList();
    return list;
  }
}
