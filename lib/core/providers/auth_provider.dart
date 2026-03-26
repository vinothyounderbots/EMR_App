import 'package:flutter/material.dart';
import '../custom_widgets/shared_preference.dart';

class AuthProvider extends ChangeNotifier {
  bool _isLoggedIn = false;
  String? _userId;

  bool get isLoggedIn => _isLoggedIn;
  String? get userId => _userId;

  Future<void> checkLoginStatus() async {
    _isLoggedIn = await SharedPreferencesHelper.isLoggedIn();
    if (_isLoggedIn) {
      _userId = await SharedPreferencesHelper.getUserId();
    }
    notifyListeners();
  }

  Future<void> login(String userId) async {
    await SharedPreferencesHelper.saveLoginState(userId);
    _isLoggedIn = true;
    _userId = userId;
    notifyListeners();
  }

  Future<void> logout() async {
    await SharedPreferencesHelper.clearLoginState();
    _isLoggedIn = false;
    _userId = null;
    notifyListeners();
  }
}
