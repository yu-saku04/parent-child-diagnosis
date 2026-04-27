import 'package:flutter/foundation.dart';
import '../models/app_user.dart';
import '../services/auth_service.dart';
import '../services/local_storage_service.dart';

class AuthProvider extends ChangeNotifier {
  final AuthService _authService = AuthService(LocalStorageService());

  AppUser? _user;
  bool _isLoading = true;

  AppUser? get user => _user;
  bool get isLoading => _isLoading;
  String get userId => _user?.id ?? 'anonymous';
  bool get isPremium => _user?.isPremium ?? false;

  Future<void> initialize() async {
    _isLoading = true;
    notifyListeners();
    _user = await _authService.getOrCreateUser();
    _isLoading = false;
    notifyListeners();
  }

  Future<void> setPremium(bool value) async {
    if (_user == null) return;
    _user = _user!.copyWith(isPremium: value, updatedAt: DateTime.now());
    await _authService.updateUser(_user!);
    notifyListeners();
  }
}
