import 'package:flutter_bloc_template/features/reciever/model.dart';

class RecieversRepository {
  Future<List<Reciever>> loadRecievers({required String token}) async {
    await Future.delayed(const Duration(milliseconds: 600));
    List<Reciever> recievers = [
      Reciever(name: 'John Walker', phoneNumber: 15553332233, id: 0),
      Reciever(name: 'Alice Wayne', phoneNumber: 15553332233, id: 1),
    ];
    return recievers;
  }

  Future<void> updateReciever({required String token, required Reciever reciever}) async {
    await Future.delayed(const Duration(milliseconds: 700));
    List<Reciever> recievers = [
      Reciever(name: 'John Walker', phoneNumber: 15553332233, id: 0),
      Reciever(name: 'Alice Wayne', phoneNumber: 15553332233, id: 1),
    ];
    return;
  }
}
