// Phase 1: スタブ実装（Google Play Billing連携はPhase 3以降）
class BillingService {
  Future<bool> purchasePremium() async {
    // TODO: Google Play Billing の購入処理を実装
    await Future.delayed(const Duration(seconds: 1));
    return false; // Phase 1では課金不可
  }

  Future<bool> restorePurchases() async {
    // TODO: 購入復元処理を実装
    await Future.delayed(const Duration(seconds: 1));
    return false; // Phase 1では復元不可
  }

  Future<String?> getPrice() async {
    // TODO: 商品価格の取得処理を実装
    return '¥480/月';
  }
}
