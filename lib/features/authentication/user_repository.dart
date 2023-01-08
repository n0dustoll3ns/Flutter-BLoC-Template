import 'package:pocketbase/pocketbase.dart';

import 'package:flutter_bloc_template/features/user/states.dart';

class UserRepository {
  String token = '';

  Future<AdminAuth?> authenticate({
    required String username,
    required String password,
  }) async {
    final pb = PocketBase('https://pocketbase.dancheg97.ru/');
    AdminAuth authData = await pb.admins.authWithPassword(username, password);
    return authData;
  }

  Future<void> deleteToken() async {
    /// delete from keystore/keychain
    await Future.delayed(const Duration(seconds: 1));
    return;
  }

  void persistToken(String token) async {
    /// write to keystore/keychain
    await Future.delayed(const Duration(seconds: 1));
  }

  Future<bool> hasToken() async {
    /// read from keystore/keychain
    await Future.delayed(const Duration(seconds: 1));
    return false;
  }

  Future<UserData> personalDataRequest(String token) async {
    /// read user data
    await Future.delayed(const Duration(seconds: 3));
    return UserData(
        userLogin: 'Max12345',
        firstName: 'Maxim',
        lastName: 'Krivosheun',
        email: 'Krivoshein_max12@gmail.com',
        mobile: 89252554321,
        bDay: DateTime(1987, 12, 1),
        customerStatus: Status.silver);
  }

  Future<UserData> personalDataEdit(String token, UserData newUserData) async {
    var res = UserData(
        userLogin: newUserData.userLogin,
        firstName: newUserData.firstName,
        lastName: newUserData.lastName,
        email: newUserData.email,
        mobile: newUserData.mobile,
        bDay: newUserData.bDay,
        customerStatus: newUserData.customerStatus);
    await Future.delayed(const Duration(milliseconds: 1200));
    return res;
  }
}
