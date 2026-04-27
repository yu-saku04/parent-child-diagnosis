import 'package:uuid/uuid.dart';
import '../models/app_user.dart';
import 'local_storage_service.dart';

// Phase 1: ローカル匿名ユーザー管理（Firebase連携はPhase 2以降）
class AuthService {
  final LocalStorageService _storage;
  static const _uuid = Uuid();

  AuthService(this._storage);

  Future<AppUser> getOrCreateUser() async {
    final existing = await _storage.loadUser();
    if (existing != null) return existing;

    final now = DateTime.now();
    final user = AppUser(
      id: _uuid.v4(),
      isPremium: false,
      createdAt: now,
      updatedAt: now,
    );
    await _storage.saveUser(user);
    return user;
  }

  Future<void> updateUser(AppUser user) async {
    await _storage.saveUser(user);
  }
}
