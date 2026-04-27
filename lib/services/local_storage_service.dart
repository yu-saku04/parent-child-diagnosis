import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/diagnosis_result.dart';
import '../models/app_user.dart';

class LocalStorageService {
  static const _userKey = 'app_user';
  static const _historyKey = 'diagnosis_history';

  Future<AppUser?> loadUser() async {
    final prefs = await SharedPreferences.getInstance();
    final json = prefs.getString(_userKey);
    if (json == null) return null;
    return AppUser.fromJson(jsonDecode(json) as Map<String, dynamic>);
  }

  Future<void> saveUser(AppUser user) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_userKey, jsonEncode(user.toJson()));
  }

  Future<List<DiagnosisResult>> loadHistory() async {
    final prefs = await SharedPreferences.getInstance();
    final json = prefs.getString(_historyKey);
    if (json == null) return [];
    final list = jsonDecode(json) as List;
    return list
        .map((e) => DiagnosisResult.fromJson(e as Map<String, dynamic>))
        .toList()
      ..sort((a, b) => b.createdAt.compareTo(a.createdAt));
  }

  Future<void> saveResult(DiagnosisResult result) async {
    final results = await loadHistory();
    results.insert(0, result);
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(
        _historyKey, jsonEncode(results.map((r) => r.toJson()).toList()));
  }

  Future<void> deleteResult(String id) async {
    final results = await loadHistory();
    results.removeWhere((r) => r.id == id);
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(
        _historyKey, jsonEncode(results.map((r) => r.toJson()).toList()));
  }

  Future<void> clearAll() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }
}
