class CategoryScore {
  final String key;
  final String label;
  final int score;
  final int maxScore;
  final String advice;

  const CategoryScore({
    required this.key,
    required this.label,
    required this.score,
    required this.maxScore,
    required this.advice,
  });

  int get percentage =>
      maxScore > 0 ? ((score / maxScore) * 100).round().clamp(0, 100) : 0;
}

class ResultDetail {
  final String resultType;
  final String typeLabel;
  final String simpleComment;
  final String detailComment;
  final List<CategoryScore> categoryScores;
  final List<String> improvements;
  final List<String> goodPoints;
  final String aiAdvice;

  const ResultDetail({
    required this.resultType,
    required this.typeLabel,
    required this.simpleComment,
    required this.detailComment,
    required this.categoryScores,
    required this.improvements,
    this.goodPoints = const [],
    required this.aiAdvice,
  });
}
