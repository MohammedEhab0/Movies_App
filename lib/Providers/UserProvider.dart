import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Data/models/MyUser.dart';
@injectable
class UserProvider extends ChangeNotifier {
  MyUser? _currentUser;
  static const _tokenKey = 'user_token';

  MyUser? get currentUser => _currentUser;

  bool get isLoggedIn => _currentUser != null;

  Future<void> updateUser(MyUser newUser) async {
    _currentUser = newUser;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_tokenKey, newUser.token);
    print('[UserProvider] Token saved: ${newUser.token}');
    notifyListeners();
  }

  Future<void> loadUserFromPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString(_tokenKey);
    print('[UserProvider] Loaded token: $token');
    if (token != null && token.isNotEmpty) {
      _currentUser = MyUser(token: token);
      notifyListeners();
    }
  }

  void logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_tokenKey);
    _currentUser = null;
    notifyListeners();
  }
}
