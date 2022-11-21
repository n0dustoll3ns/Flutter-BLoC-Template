class UserRepository {
  String token = '';

  Future<String> authenticate({
    required String username,
    required String password,
  }) async {
    await Future.delayed(const Duration(seconds: 1));
    token = 'token';
    return 'token';
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
}
