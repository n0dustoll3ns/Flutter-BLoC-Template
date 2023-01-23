import '../../utils/urls.dart';
import 'model.dart';

class AdressesRepository {
  Future<List<Adress>> loadAdresses({required String token}) async {
    var records = await pb.collection('adresses').getFullList(
      headers: {"Authorization": token},
    );

    List<Adress> adresss = records.map((e) => Adress.fromJson(id: e.id, json: e.data)).toList();
    return adresss;
  }

  Future<Adress> createAdress({required String token, required String userId, required Adress adress}) async {
    var data = {
      "zipcode": adress.zipCode,
      "town": adress.town,
      "street_name": adress.streetName,
      "building_number": adress.buildingNumber,
      "owner": userId
    };

    var record = await pb.collection('adresses').create(body: data, headers: {"Authorization": token});
    return Adress.fromJson(id: record.id, json: record.data);
  }

  Future<void> removeAdress({required String token, required String userId, required String adressId}) async {
    await pb.collection('adresses').delete(adressId, headers: {"Authorization": token});
    return;
  }

  Future<Adress> updateAdress({required String token, required String userId, required Adress adress}) async {
    var data = {
      "zipcode": adress.zipCode,
      "town": adress.town,
      "street_name": adress.streetName,
      "building_number": adress.buildingNumber,
      "owner": userId
    };

    var record =
        await pb.collection('adresss').update(adress.id, body: data, headers: {"Authorization": token});
    return Adress.fromJson(id: record.id, json: record.data);
  }
}
