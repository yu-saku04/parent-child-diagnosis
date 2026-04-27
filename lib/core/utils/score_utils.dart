class ScoreUtils {
  static int toPercentage(int score, int maxScore) {
    if (maxScore == 0) return 0;
    return ((score / maxScore) * 100).round().clamp(0, 100);
  }

  static String scoreLabel(int percentage) {
    if (percentage <= 30) return '低';
    if (percentage <= 60) return '中';
    if (percentage <= 80) return '高';
    return '非常に高い';
  }
}
