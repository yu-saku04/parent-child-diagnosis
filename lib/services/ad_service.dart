import 'package:flutter/material.dart';

// Phase 1: スタブ実装（AdMob連携はPhase 2以降）
class AdService {
  bool _isLoaded = false;
  int _dailyViewCount = 0;
  DateTime? _lastViewDate;

  bool get isLoaded => _isLoaded;
  int get dailyViewCount => _dailyViewCount;

  bool get canShowAd {
    if (_lastViewDate == null) return true;
    final today = DateTime.now();
    final isToday = _lastViewDate!.year == today.year &&
        _lastViewDate!.month == today.month &&
        _lastViewDate!.day == today.day;
    if (!isToday) return true;
    return _dailyViewCount < 3;
  }

  Future<void> loadAd() async {
    // TODO: AdMob リワード広告のロード処理を実装
    await Future.delayed(const Duration(milliseconds: 500));
    _isLoaded = true;
  }

  Future<bool> showAd(BuildContext context) async {
    if (!canShowAd) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('本日の広告視聴回数の上限に達しました。')),
        );
      }
      return false;
    }

    // Phase 1: 広告をシミュレート（実際の広告表示はPhase 2で実装）
    await Future.delayed(const Duration(seconds: 1));
    _recordAdView();
    return true;
  }

  void _recordAdView() {
    final today = DateTime.now();
    if (_lastViewDate == null ||
        !(_lastViewDate!.year == today.year &&
            _lastViewDate!.month == today.month &&
            _lastViewDate!.day == today.day)) {
      _dailyViewCount = 1;
    } else {
      _dailyViewCount++;
    }
    _lastViewDate = today;
  }

  void dispose() {}
}
