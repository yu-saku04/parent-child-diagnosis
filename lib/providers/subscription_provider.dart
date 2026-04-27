import 'package:flutter/foundation.dart';
import '../services/billing_service.dart';

class SubscriptionProvider extends ChangeNotifier {
  final BillingService _billing = BillingService();

  bool _isPremium = false;
  bool _isLoading = false;
  String? _price;
  String? _errorMessage;

  bool get isPremium => _isPremium;
  bool get isLoading => _isLoading;
  String? get price => _price;
  String? get errorMessage => _errorMessage;

  void setPremiumFromAuth(bool value) {
    _isPremium = value;
    notifyListeners();
  }

  Future<void> loadPrice() async {
    _price = await _billing.getPrice();
    notifyListeners();
  }

  Future<bool> purchase() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final success = await _billing.purchasePremium();
      if (success) {
        _isPremium = true;
      } else {
        _errorMessage = 'Phase 1では課金機能はご利用いただけません。Phase 3以降に実装予定です。';
      }
      return success;
    } catch (e) {
      _errorMessage = '購入処理が完了しませんでした。もう一度お試しください。';
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> restore() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final success = await _billing.restorePurchases();
      if (success) {
        _isPremium = true;
      } else {
        _errorMessage = '有効なプレミアムプランが見つかりませんでした。';
      }
      return success;
    } catch (e) {
      _errorMessage = '復元処理が完了しませんでした。もう一度お試しください。';
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
