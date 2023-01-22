import 'package:flutter_bloc_template/features/reciever/model.dart';
import 'package:flutter_bloc_template/utils/urls.dart';

class RecieversRepository {
  Future<List<Reciever>> loadRecievers({required String token}) async {
    var records = await pb.collection('recievers').getFullList(
      //  filter: 'owner = $userId',
      headers: {"Authorization": token},
    );

    List<Reciever> recievers = records.map((e) => Reciever.fromJson(id: e.id, json: e.data)).toList();
    return recievers;
  }

  Future<Reciever> createReciever(
      {required String token, required String userId, required Reciever reciever}) async {
    var data = {"name": reciever.name, "phone_number": reciever.phoneNumber, "owner": userId};

    var record = await pb.collection('recievers').create(body: data, headers: {"Authorization": token});
    return Reciever.fromJson(id: record.id, json: record.data);
  }

  Future<void> removeReciever(
      {required String token, required String userId, required String recieverId}) async {
    await pb.collection('recievers').delete(recieverId, headers: {"Authorization": token});
    return;
  }

  Future<Reciever> updateReciever(
      {required String token, required String userId, required Reciever reciever}) async {
    var data = {"name": reciever.name, "phone_number": reciever.phoneNumber, "owner": userId};

    var record =
        await pb.collection('recievers').update(reciever.id, body: data, headers: {"Authorization": token});
    return Reciever.fromJson(id: record.id, json: record.data);
  }
}
