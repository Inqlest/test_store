import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test_store/features/profile/model/user.dart';

class SharedPreferencesService {
  static const String _userKey = 'user';
  static const String _favoriteKey = 'favoriteItems';

  Future<void> saveUser(User user) async {
    final prefs = await SharedPreferences.getInstance();
    final userJson = jsonEncode({
      'firstName': user.firstName,
      'secondName': user.secondName,
      'email': user.email,
      'password': user.password,
    });
    await prefs.setString(_userKey, userJson);
  }

  Future<User?> getUser() async {
    final prefs = await SharedPreferences.getInstance();
    final userJson = prefs.getString(_userKey);

    if (userJson == null) {
      return null;
    }

    final Map<String, dynamic> userMap = jsonDecode(userJson);
    return User(
        firstName: userMap['firstName'],
        secondName: userMap['secondName'],
        email: userMap['email'],
        password: userMap['password']);
  }

  Future<void> removeUser() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_userKey);
  }

  Future<void> saveFavoriteStatus(String itemTitle, bool isFavorite) async {
    final prefs = await SharedPreferences.getInstance();
    final favoriteTitles = prefs.getStringList(_favoriteKey) ?? [];

    if (isFavorite) {
      if (!favoriteTitles.contains(itemTitle)) {
        favoriteTitles.add(itemTitle);
      }
    } else {
      favoriteTitles.remove(itemTitle);
    }

    await prefs.setStringList(_favoriteKey, favoriteTitles);
  }

  Future<List<String>> loadFavoriteStatuses() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getStringList(_favoriteKey) ?? [];
  }
}
