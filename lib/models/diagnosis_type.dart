enum DiagnosisType { stress, talent, ngBehavior }

extension DiagnosisTypeExtension on DiagnosisType {
  String get label {
    switch (this) {
      case DiagnosisType.stress:
        return '親のストレス傾向チェック';
      case DiagnosisType.talent:
        return '子どもの才能タイプ診断';
      case DiagnosisType.ngBehavior:
        return '親のNG行動チェック';
    }
  }

  String get shortLabel {
    switch (this) {
      case DiagnosisType.stress:
        return 'ストレスチェック';
      case DiagnosisType.talent:
        return '才能タイプ診断';
      case DiagnosisType.ngBehavior:
        return 'NG行動チェック';
    }
  }

  String get description {
    switch (this) {
      case DiagnosisType.stress:
        return '今の親自身の疲れやストレス傾向を確認する。所要時間は約3分です。';
      case DiagnosisType.talent:
        return '子どもの行動や興味から、得意傾向を確認する。所要時間は約5分です。';
      case DiagnosisType.ngBehavior:
        return '日常の接し方を振り返り、改善ポイントを確認する。所要時間は約3分です。';
    }
  }

  String get iconEmoji {
    switch (this) {
      case DiagnosisType.stress:
        return '💆';
      case DiagnosisType.talent:
        return '🌟';
      case DiagnosisType.ngBehavior:
        return '🔍';
    }
  }

  String get estimatedTime {
    switch (this) {
      case DiagnosisType.stress:
        return '約3分';
      case DiagnosisType.talent:
        return '約5分';
      case DiagnosisType.ngBehavior:
        return '約3分';
    }
  }

  String get storageKey {
    switch (this) {
      case DiagnosisType.stress:
        return 'stress';
      case DiagnosisType.talent:
        return 'talent';
      case DiagnosisType.ngBehavior:
        return 'ng_behavior';
    }
  }

  static DiagnosisType fromStorageKey(String key) {
    switch (key) {
      case 'stress':
        return DiagnosisType.stress;
      case 'talent':
        return DiagnosisType.talent;
      case 'ng_behavior':
        return DiagnosisType.ngBehavior;
      default:
        return DiagnosisType.stress;
    }
  }
}
