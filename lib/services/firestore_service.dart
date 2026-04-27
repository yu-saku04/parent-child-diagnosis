import '../models/diagnosis_result.dart';

// Phase 1: スタブ実装（Firebase連携はPhase 2以降）
class FirestoreService {
  Future<void> saveResult(DiagnosisResult result) async {
    // TODO: Firebase Firestore への保存処理を実装
  }

  Future<List<DiagnosisResult>> fetchResults(String userId) async {
    // TODO: Firebase Firestore からの取得処理を実装
    return [];
  }

  Future<void> updateIsPremium(String userId, bool isPremium) async {
    // TODO: Firebase Firestore のisPremium更新処理を実装
  }
}
