import 'package:pocketbase/pocketbase.dart';

import '../../utils/urls.dart';
import '../user/model.dart';

class UserRepository {
  Future<RecordAuth> authenticate({
    required String username,
    required String password,
  }) async {
    final authData = await pb.collection('users').authWithPassword(username, password);
    return authData;
  }

  Future<RecordAuth> authRefresh(String token) async {
    final authData = await pb.collection('users').authRefresh(headers: {"Authorization": token});
    return authData;
  }

  Future<UserData> personalDataEdit(String token, UserData newUserData) async {
    final authData = await pb
        .collection('users')
        .update(newUserData.id, body: newUserData.toJson, headers: {"Authorization": token});

    var res = UserData.fromJson(authData.id, authData.data);
    return res;
  }

  void logOut() async {
    pb.authStore.clear();
  }
}
