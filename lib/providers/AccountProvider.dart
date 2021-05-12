import 'package:flutter/cupertino.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AccountProvider extends ChangeNotifier {
  FlutterSecureStorage _storage = FlutterSecureStorage();

  Future<String> isLoggedIn() async {
    String token = await _storage.read(key: "token");
    await Future.delayed(Duration(seconds: 2));
    if (token != null) {
      return token;
    } else {
      return "";
    }
  }

  Future<void> login() async {
    await _storage.write(key: 'token', value: 'ok');
    notifyListeners();
  }

  Future<void> logOut() async {
    await _storage.delete(key: 'token');
    notifyListeners();
  }
}
