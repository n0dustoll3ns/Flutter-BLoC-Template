import 'model.dart';

class AdressesRepository {
  Future<List<Adress>> loadAdresses({required String token}) async {
    await Future.delayed(const Duration(milliseconds: 600));
    List<Adress> adresses = [
      Adress(
        id: 0,
        buildingNumber: '45A',
        streetName: 'HW White',
        town: 'Lauterbrunnen',
        zipCode: 12345,
      ),
      Adress(
        id: 1,
        buildingNumber: '413A',
        streetName: 'Street White',
        town: 'Grindelwald',
        zipCode: 345678,
      ),
    ];
    return adresses;
  }

  Future<void> updateAdress({required String token, required Adress adress}) async {
    await Future.delayed(const Duration(milliseconds: 700));
    //TODO
    return;
  }
}
