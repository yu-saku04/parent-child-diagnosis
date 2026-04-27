import 'package:flutter/foundation.dart';
import '../models/diagnosis_result.dart';
import '../services/local_storage_service.dart';
import '../core/constants/app_constants.dart';

class HistoryProvider extends ChangeNotifier {
  final LocalStorageService _storage = LocalStorageService();

  List<DiagnosisResult> _allResults = [];
  bool _isLoading = false;
  String? _errorMessage;

  List<DiagnosisResult> get allResults => _allResults;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  List<DiagnosisResult> visibleResults(bool isPremium) {
    if (isPremium) return _allResults;
    return _allResults.take(AppConstants.freeHistoryLimit).toList();
  }

  Future<void> load() async {
    _isLoading = true;
    notifyListeners();
    try {
      _allResults = await _storage.loadHistory();
    } catch (e) {
      _errorMessage = '履歴の読み込みに失敗しました。';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> save(DiagnosisResult result) async {
    try {
      await _storage.saveResult(result);
      _allResults.insert(0, result);
      notifyListeners();
    } catch (e) {
      _errorMessage = '診断結果の保存に失敗しました。ただし結果はこの画面で確認できます。';
      notifyListeners();
    }
  }

  Future<void> delete(String id) async {
    await _storage.deleteResult(id);
    _allResults.removeWhere((r) => r.id == id);
    notifyListeners();
  }
}
