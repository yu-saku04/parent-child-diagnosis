class SubscriptionStatus {
  final bool isPremium;
  final String? productId;
  final DateTime? expiresAt;

  const SubscriptionStatus({
    required this.isPremium,
    this.productId,
    this.expiresAt,
  });

  static const free = SubscriptionStatus(isPremium: false);
}
