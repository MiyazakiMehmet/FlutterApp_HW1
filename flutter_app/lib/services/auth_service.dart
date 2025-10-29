import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  static const _usersKey = 'users_map';
  static const _loggedInKey = 'is_logged_in';
  static const _currentUserKey = 'current_user';

  Future<Map<String, String>> _loadUsers() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString(_usersKey);
    if (raw == null) return {};
    final decoded = json.decode(raw) as Map<String, dynamic>;
    return decoded.map((k, v) => MapEntry(k, v as String));
  }

  Future<void> _saveUsers(Map<String, String> users) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_usersKey, json.encode(users));
  }

  Future<bool> signUp(String username, String password) async {
    final users = await _loadUsers();
    if (users.containsKey(username)) return false;
    users[username] = password;
    await _saveUsers(users);
    return true;
  }

  Future<bool> login(String username, String password) async {
    final users = await _loadUsers();
    final ok = users[username] == password;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_loggedInKey, ok);
    if (ok) await prefs.setString(_currentUserKey, username);
    return ok;
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_loggedInKey, false);
    await prefs.remove(_currentUserKey);
  }

  Future<bool> isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_loggedInKey) ?? false;
  }

  Future<String?> currentUser() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_currentUserKey);
  }
}
