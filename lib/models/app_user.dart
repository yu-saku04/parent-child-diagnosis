class AppUser {
  final String id;
  final bool isPremium;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int dailyAdViewCount;
  final DateTime? lastAdViewDate;

  const AppUser({
    required this.id,
    required this.isPremium,
    required this.createdAt,
    required this.updatedAt,
    this.dailyAdViewCount = 0,
    this.lastAdViewDate,
  });

  AppUser copyWith({
    bool? isPremium,
    DateTime? updatedAt,
    int? dailyAdViewCount,
    DateTime? lastAdViewDate,
  }) =>
      AppUser(
        id: id,
        isPremium: isPremium ?? this.isPremium,
        createdAt: createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        dailyAdViewCount: dailyAdViewCount ?? this.dailyAdViewCount,
        lastAdViewDate: lastAdViewDate ?? this.lastAdViewDate,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'isPremium': isPremium,
        'createdAt': createdAt.toIso8601String(),
        'updatedAt': updatedAt.toIso8601String(),
        'dailyAdViewCount': dailyAdViewCount,
        'lastAdViewDate': lastAdViewDate?.toIso8601String(),
      };

  factory AppUser.fromJson(Map<String, dynamic> json) => AppUser(
        id: json['id'] as String,
        isPremium: json['isPremium'] as bool? ?? false,
        createdAt: DateTime.parse(json['createdAt'] as String),
        updatedAt: DateTime.parse(json['updatedAt'] as String),
        dailyAdViewCount: json['dailyAdViewCount'] as int? ?? 0,
        lastAdViewDate: json['lastAdViewDate'] != null
            ? DateTime.parse(json['lastAdViewDate'] as String)
            : null,
      );
}
