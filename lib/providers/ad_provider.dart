import 'package:flutter/material.dart';
import '../services/ad_service.dart';

class AdProvider extends ChangeNotifier {
  final AdService _adService = AdService();

  bool _isLoading = false;
  String? _errorMessage;

  bool get canShowAd => _adService.canShowAd;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  Future<bool> watchAd(BuildContext context) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      await _adService.loadAd();
      if (!context.mounted) return false;
      final rewarded = await _adService.showAd(context);
      if (!rewarded) {
        _errorMessage = '広告の読み込みに失敗しました。時間をおいて再度お試しください。';
      }
      return rewarded;
    } catch (e) {
      _errorMessage = '広告の読み込みに失敗しました。時間をおいて再度お試しください。';
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
